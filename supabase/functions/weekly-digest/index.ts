import { createClient } from 'https://esm.sh/@supabase/supabase-js@2'
import { SMTPClient } from 'https://deno.land/x/denomailer@1.6.0/mod.ts'

const supabaseUrl = Deno.env.get('SUPABASE_URL')!
const supabaseServiceKey = Deno.env.get('SUPABASE_SERVICE_ROLE_KEY')!
const gmailUser = Deno.env.get('GMAIL_USER')!
const gmailPassword = Deno.env.get('GMAIL_APP_PASSWORD')!

const supabase = createClient(supabaseUrl, supabaseServiceKey)

// Hash function to determine which day a user gets their digest (0-6)
function getUserDigestDay(userId: string): number {
  let hash = 0
  for (let i = 0; i < userId.length; i++) {
    hash = ((hash << 5) - hash) + userId.charCodeAt(i)
    hash |= 0
  }
  return Math.abs(hash) % 7
}

// Format date nicely
function formatDate(dateStr: string): string {
  const date = new Date(dateStr)
  return date.toLocaleDateString('en-US', { 
    month: 'short', 
    day: 'numeric', 
    year: 'numeric' 
  })
}

// Build email HTML
function buildEmailHtml(
  userName: string, 
  activities: Array<{
    personName: string,
    activityType: string,
    title: string,
    photoId?: string,
    memoryId?: string,
    personId: string,
    createdAt: string
  }>,
  siteUrl: string
): string {
  // Group activities by person
  const byPerson = new Map<string, typeof activities>()
  for (const activity of activities) {
    const existing = byPerson.get(activity.personName) || []
    existing.push(activity)
    byPerson.set(activity.personName, existing)
  }

  let personSections = ''
  for (const [personName, personActivities] of byPerson) {
    const photoCount = personActivities.filter(a => a.activityType === 'photo_tag').length
    const memoryCount = personActivities.filter(a => a.activityType === 'memory').length
    
    let items = ''
    if (photoCount > 0) {
      items += `<p style="margin: 5px 0;">📷 ${photoCount} new photo${photoCount > 1 ? 's' : ''}</p>`
    }
    if (memoryCount > 0) {
      items += `<p style="margin: 5px 0;">💭 ${memoryCount} new memor${memoryCount > 1 ? 'ies' : 'y'}</p>`
    }
    
    const personId = personActivities[0].personId
    personSections += `
      <div style="margin-bottom: 20px; padding: 15px; background-color: #f8f9fa; border-radius: 8px;">
        <h3 style="margin: 0 0 10px 0; color: #1e3a5f;">${personName}</h3>
        ${items}
        <a href="${siteUrl}/person/${personId}" style="color: #2563eb; text-decoration: none;">→ View profile</a>
      </div>
    `
  }

  return `
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <body style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif; line-height: 1.6; color: #333; max-width: 600px; margin: 0 auto; padding: 20px;">
      <h1 style="color: #1e3a5f; border-bottom: 2px solid #d4a574; padding-bottom: 10px;">
        Weekly Update from Stake History 📸
      </h1>
      
      <p>Hi ${userName},</p>
      
      <p>Here's what's new for the people you're watching:</p>
      
      ${personSections}
      
      <hr style="border: none; border-top: 1px solid #ddd; margin: 30px 0;">
      
      <p style="color: #666; font-size: 14px;">
        <a href="${siteUrl}/my-watchlist" style="color: #2563eb;">Manage your watchlist</a> · 
        <a href="${siteUrl}" style="color: #2563eb;">Visit Stake History</a>
      </p>
      
      <p style="color: #999; font-size: 12px;">
        Bountiful Utah South Stake History<br>
        You received this because you're watching people on our site.
      </p>
    </body>
    </html>
  `
}

Deno.serve(async (req) => {
  try {
    const today = new Date().getDay() // 0 = Sunday, 6 = Saturday
    const oneWeekAgo = new Date(Date.now() - 7 * 24 * 60 * 60 * 1000).toISOString()
    const siteUrl = 'https://history.bountifulsouthstake.org'

    // Get users who want weekly digest
    const { data: users, error: usersError } = await supabase
      .from('user_profiles')
      .select('id, display_name')
      .eq('weekly_digest_enabled', true)

    if (usersError) throw usersError

    // Get emails from auth.users
    const { data: authUsers, error: authError } = await supabase.auth.admin.listUsers()
    if (authError) throw authError

    const emailMap = new Map(authUsers.users.map(u => [u.id, u.email]))

    // Set up SMTP
    const smtp = new SMTPClient({
      connection: {
        hostname: 'smtp.gmail.com',
        port: 587,
        tls: true,
        auth: {
          username: gmailUser,
          password: gmailPassword
        }
      }
    })

    let emailsSent = 0
    let usersSkipped = 0

    for (const user of users || []) {
      // Check if today is this user's digest day
      if (getUserDigestDay(user.id) !== today) {
        continue
      }

      const userEmail = emailMap.get(user.id)
      if (!userEmail) continue

      // Get people this user is watching
      const { data: watches } = await supabase
        .from('person_follows')
        .select('person_id')
        .eq('user_id', user.id)

      if (!watches || watches.length === 0) continue

      const watchedPersonIds = watches.map(w => w.person_id)

      // Get activity for watched people in the last 7 days
      const { data: activities } = await supabase
        .from('follow_activity')
        .select(`
          id,
          person_id,
          activity_type,
          photo_id,
          memory_id,
          title,
          created_at,
          people:person_id (full_name)
        `)
        .in('person_id', watchedPersonIds)
        .gte('created_at', oneWeekAgo)
        .order('created_at', { ascending: false })

      // NO ACTIVITY = NO EMAIL
      if (!activities || activities.length === 0) {
        usersSkipped++
        continue
      }

      // Format activities for email
      const formattedActivities = activities.map(a => ({
        personName: (a.people as any)?.full_name || 'Unknown',
        activityType: a.activity_type,
        title: a.title,
        photoId: a.photo_id,
        memoryId: a.memory_id,
        personId: a.person_id,
        createdAt: a.created_at
      }))

      // Build and send email
      const html = buildEmailHtml(
        user.display_name || 'Friend',
        formattedActivities,
        siteUrl
      )

      await smtp.send({
        from: `Bountiful Utah South Stake History <${gmailUser}>`,
        to: userEmail,
        subject: 'Weekly Update from Stake History 📸',
        html
      })

      emailsSent++
    }

    await smtp.close()

    return new Response(
      JSON.stringify({ 
        success: true, 
        emailsSent, 
        usersSkipped,
        dayOfWeek: today 
      }),
      { headers: { 'Content-Type': 'application/json' } }
    )

  } catch (error) {
    console.error('Weekly digest error:', error)
    return new Response(
      JSON.stringify({ success: false, error: error.message }),
      { status: 500, headers: { 'Content-Type': 'application/json' } }
    )
  }
})