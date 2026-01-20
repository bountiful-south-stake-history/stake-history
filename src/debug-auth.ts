export function debugAuthConfig() {
  if (typeof window === 'undefined') {
    console.log('⚠️  This debug script must run in the browser')
    return
  }

  console.log('=== Supabase Auth Configuration Debug ===')
  console.log('Current origin:', window.location.origin)
  console.log('Current URL:', window.location.href)
  console.log('Supabase URL:', import.meta.env.VITE_SUPABASE_URL)
  console.log('Supabase Anon Key:', import.meta.env.VITE_SUPABASE_ANON_KEY ? '✓ Set' : '✗ Missing')
  
  const supabaseUrl = import.meta.env.VITE_SUPABASE_URL
  if (supabaseUrl) {
    try {
      const url = new URL(supabaseUrl)
      console.log('Supabase Project ID:', url.hostname.split('.')[0])
      console.log('Supabase Host:', url.hostname)
    } catch (e) {
      console.error('Error parsing Supabase URL:', e)
    }
  }
  
  console.log('=========================================')
}

if (typeof window !== 'undefined') {
  debugAuthConfig()
}
