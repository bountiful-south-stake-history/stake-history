import { PreviewGate } from '../ui/PreviewGate'

interface FarewellSectionProps {
  onImageClick: (url: string, alt: string) => void
  isSignedIn: boolean
  onSignIn: () => void
}

// Bunny Stream. Defined as an array so a fourth video is a one-line addition.
const BUNNY_LIBRARY = '734651'
const BUNNY_PULL_ZONE = 'vz-cc532c09-f44.b-cdn.net'

// Thumbnail filenames carry per-video hashes and are not predictable — use the
// exact filenames below. Bunny may regenerate these if a video is re-encoded, so
// a 404 on a thumbnail means the URL changed; fetch the new one from the Bunny
// dashboard. (The pull zone also enforces hotlink protection: thumbnails load in
// the browser via the page Referer, but a bare fetch with no Referer gets a 403.)
const videos = [
  { label: 'Relief Society', guid: '5c4b0794-4738-4e2c-8782-451aa1a6c304', thumbnail: 'thumbnail_25b57a8a.jpg' },
  { label: 'Elders Quorum', guid: '4b480e0c-e932-4a6d-b730-cbcc34dfbfe9', thumbnail: 'thumbnail_220f3e37.jpg' },
  { label: 'Primary', guid: 'ee1b8e70-f427-46a8-9afe-1f2e2362bba9', thumbnail: 'thumbnail_af217851.jpg' },
]

const embedUrl = (guid: string) => `https://iframe.mediadelivery.net/embed/${BUNNY_LIBRARY}/${guid}?autoplay=false`
const thumbnailUrl = (guid: string, thumbnail: string) => `https://${BUNNY_PULL_ZONE}/${guid}/${thumbnail}`

// Direct MP4 download link per video. Click behavior from the page is still being
// evaluated and cannot be determined by inspection. The pull zone has "Block direct
// url file access" ON, so a request without a Referer header is blocked (an
// address-bar hit returns 403); a click from the page sends a Referer. play_720p.mp4
// follows Bunny's play_{resolution}.mp4 MP4-fallback pattern and was confirmed
// present for all three videos with a Referer'd request; which resolutions exist
// depends on the encode ladder. These are cross-origin video/mp4 with no
// Content-Disposition, so the download attribute may be ignored and the browser may
// open/play the file in a tab rather than save it.
const mp4Url = (guid: string) => `https://${BUNNY_PULL_ZONE}/${guid}/play_720p.mp4`

const IMAGE_BASE = 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images'

const doorFlyer = {
  url: `${IMAGE_BASE}/door-posting-flyer.jpg`,
  caption: "The invitation posted on members' doors and handed out.",
}
const davisAd = {
  url: `${IMAGE_BASE}/davis-journal-ad.jpg`,
  caption: 'The public announcement in the Davis Journal.',
}

const paragraphs = [
  `On a Saturday in August, the doors of the 102 East 1400 South Chapel stood open to greet friends old and new.`,
  `Hundreds came, from ten in the morning until four in the afternoon, some arriving early and some staying late. Three wards meet in the building today, and all three grew out of the ward that built it. Many who came were adults who had spent some or all of their childhood here, bringing their children and grandchildren back to show them the rooms and tell them the stories.`,
  `Scrapbooks and memorabilia filled the classrooms. Testimonial videos played in several rooms, ward members telling what the building had meant. In the chapel, near the sacrament table, a video of Christ played quietly, and people sat with it.`,
  `Out on the back patio, tables and canopies were set up under the trees, with hot dogs and Pace Bars, a Bountiful original, served through the afternoon. People carried plates out to the shade and stayed, visiting long after they had finished eating.`,
  `They filled the foyer and wandered the halls, visiting and remembering and saying goodbye to a place that had held a part of their lives.`,
  `Seventy-four years earlier, members of the Bountiful 4th Ward had raised the money and swung the hammers to build it. The building outgrew them. The 7th Ward was organized from the 4th in 1952, the 20th in 1961, and in 1968 those three wards together organized the 36th. On August 15, 2026, those generations came back to thank the building that gathered them.`,
]

export function FarewellSection({ onImageClick, isSignedIn, onSignIn }: FarewellSectionProps) {
  return (
    <div>
      {/* Story */}
      <div className="space-y-4">
        {paragraphs.map((paragraph, idx) => (
          <p key={idx} className="text-gray-700 leading-relaxed">{paragraph}</p>
        ))}
      </div>

      {/* Invitations — public, not gated */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mt-6">
        {[doorFlyer, davisAd].map((image, idx) => (
          <figure key={idx}>
            <img
              src={image.url}
              alt={image.caption}
              loading="lazy"
              onClick={() => onImageClick(image.url, image.caption)}
              className="w-full rounded-lg shadow-md cursor-pointer hover:opacity-90 transition-opacity"
            />
            <figcaption className="text-sm text-gray-500 mt-2">{image.caption}</figcaption>
          </figure>
        ))}
      </div>

      {/* Videos — gated */}
      <h4 className="text-md font-semibold text-gray-800 mt-8 mb-4">Videos from the open house</h4>
      {isSignedIn ? (
        <div className="space-y-6">
          {videos.map(video => (
            <div key={video.guid}>
              <p className="font-medium text-gray-700 mb-2">{video.label}</p>
              <div className="relative w-full aspect-video">
                <iframe
                  className="absolute inset-0 w-full h-full"
                  src={embedUrl(video.guid)}
                  loading="lazy"
                  allow="accelerometer;gyroscope;encrypted-media;picture-in-picture;"
                  allowFullScreen
                  title={video.label}
                />
              </div>
              {/* Direct MP4 download link (see comment above). */}
              <div className="mt-2 flex flex-wrap items-center gap-x-2">
                <a
                  href={mp4Url(video.guid)}
                  download
                  className="inline-flex items-center gap-2 text-purple-600 hover:text-purple-700 hover:underline font-medium"
                >
                  <svg className="w-5 h-5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                    <path
                      strokeLinecap="round"
                      strokeLinejoin="round"
                      strokeWidth={2}
                      d="M4 16v1a3 3 0 003 3h10a3 3 0 003-3v-1m-4-4l-4 4m0 0l-4-4m4 4V4"
                    />
                  </svg>
                  <span>Download this video</span>
                  <span className="text-xs text-purple-500">[MP4]</span>
                </a>
                <span className="text-sm text-purple-600">
                  opens new tab — then right-click (or long-press on mobile) and choose 'Save video as.'
                </span>
              </div>
            </div>
          ))}
        </div>
      ) : (
        <PreviewGate
          previewImages={[
            { url: doorFlyer.url, alt: doorFlyer.caption },
            { url: thumbnailUrl(videos[0].guid, videos[0].thumbnail), alt: `${videos[0].label} video` },
            { url: davisAd.url, alt: davisAd.caption },
          ]}
          title="Watch the farewell open house"
          description="Three videos recorded at the open house, shared by the Relief Society, the Elders Quorum, and the Primary. Create a free account to watch."
          onSignIn={onSignIn}
        />
      )}

      {/* Coming-soon notice — visible in both states */}
      <p className="text-sm text-gray-500 mt-4">
        A video from the open house is in production and will be added here.
      </p>
    </div>
  )
}
