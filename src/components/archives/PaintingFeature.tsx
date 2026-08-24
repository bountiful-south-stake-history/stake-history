import { PreviewGate } from '../ui/PreviewGate'

interface PaintingFeatureProps {
  onImageClick: (url: string, alt: string) => void
  isSignedIn: boolean
  onSignIn: () => void
}

const IMAGE_BASE = 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images'

const paintingImage = {
  url: `${IMAGE_BASE}/painting-in-place-lores.jpg`,
  caption: 'Christ among the fishermen, after Ernst Zimmermann. Painted by W. Dean Belnap, 1953–54.',
}
const pencilStudy = {
  url: `${IMAGE_BASE}/pencil-sketch.jpg`,
  caption: 'The preparatory pencil study.',
}
const belnapPortrait = {
  url: `${IMAGE_BASE}/w-dean-and-elen-belnap.jpg`,
  caption: 'W. Dean and Elen Belnap.',
}
// Supabase serves the plain object URL as image/jpeg with no Content-Disposition,
// and it is cross-origin, so the HTML `download` attribute alone is ignored and the
// browser would open the 6.3 MB file in a tab. The `?download` param sets
// Content-Disposition: attachment, which forces a save.
const hiResDownloadUrl = `${IMAGE_BASE}/w-dean-belnap-painting-hires.jpg?download`

const paragraphs = [
  `For nearly 70 years, the Saints worshipping in the red-brick chapel at 102 East 1400 South in Bountiful looked up at a painting of Christ among the fishermen. Beneath it a congregation grew up, raised families, buried loved ones, and covenanted to follow the Fisher of Men. Few thought to ask who had painted it. Fewer still would have guessed the answer: a young Army doctor, who painted his testimony on canvas in an empty barracks a thousand miles away during the middle of a war, never guessing it would one day find a home in the hearts of generations.`,
  `Wilford Dean Belnap was born in Salt Lake City in 1926. He was a gifted artist as a boy, winning state and national awards before he was 14. As a young man he was offered a scholarship to study art. He turned it down. A national examination had revealed an unusual aptitude for medicine, and he followed where it led, entering the University of Utah at 15 and earning his medical degree at 20. He trained in pediatrics in Cleveland, and in 1950 he married Mary Elen Bennett in the Salt Lake Temple. The boy who might have been a painter had become a doctor, and would remain one for 65 years.`,
  `Then, in 1953, war found him. Called into the Army during the Korean conflict, he was stationed at Fort Belvoir, Virginia, and served two years as a captain in the Medical Corps. It was there, with time on his hands and an empty barracks to work in, that the painter he had set aside resurfaced. His commanding officer let him set up an easel, and over the better part of a year, he painted the Savior among the fishermen. He worked out the whole composition first in a careful pencil study, then put it to canvas, following a rendering of an 1886 painting by the German artist Ernst Zimmermann. When it was finished, he rolled it up and carried it home to Utah.`,
  `He had painted it with no particular place in mind, only a desire to paint the Savior he loved. It was later, after the family had settled in Bountiful so he could begin his practice, that it found its home. He noticed one day that the broad wall behind the pulpit in his chapel stood bare, and it occurred to him that the painting he had made during the war might belong there.`,
  `The meetinghouse itself had been raised by the people who worshipped in it, built and funded by the members of the Bountiful 4th Ward and dedicated in 1952. When the building was later enlarged, the Belnap family hauled brick alongside their neighbors. It was a house of worship made by the hands of its own congregation, and the painting behind its pulpit was made by one of their own.`,
  `The scene it shows has never had a caption. Zimmermann named no one in it, and so each worshipper has been left free to imagine the participants in the moment for themselves. Some have seen Zebedee and his sons, who were called to leave their nets and their father behind. Some have seen Peter, older and weathered, called by the Master whose Church he would one day lead. And some have seen themselves, young or old, called by the Savior to do His work. The painting holds room for them all.`,
  `Wherever Dean Belnap went, he did the one thing the painting depicts. He served the Lord at home and across the world, as a counselor in the 7th Ward bishopric, presiding over a mission in London, and laboring with Elen in Jakarta and Frankfurt. He drew people toward Christ one at a time, in an examining room, the mission field, or at home. The family feels the painting is fitting, because their father had, himself, answered the call to be a fisher of men. And it hung where a congregation could sit beneath it and feel the same call.`,
  `Now, with the building being sold, we are pleased to return the painting to the family, where it will hang in the home Dean and Elen built.`,
]

export function PaintingFeature({ onImageClick, isSignedIn, onSignIn }: PaintingFeatureProps) {
  return (
    <div>
      {/* The painting, full width, clickable to open the lightbox */}
      <figure className="mb-4">
        <img
          src={paintingImage.url}
          alt={paintingImage.caption}
          loading="lazy"
          onClick={() => onImageClick(paintingImage.url, paintingImage.caption)}
          className="w-full rounded-lg shadow-md cursor-pointer hover:opacity-90 transition-opacity"
        />
        <figcaption className="text-sm text-gray-500 mt-2">{paintingImage.caption}</figcaption>
      </figure>

      {/* Story */}
      <div className="space-y-4">
        {paragraphs.map((paragraph, idx) => (
          <p key={idx} className="text-gray-700 leading-relaxed">{paragraph}</p>
        ))}
      </div>

      {/* Preparatory study + the Belnaps, side by side on sm+, stacked on mobile */}
      <div className="grid grid-cols-1 sm:grid-cols-2 gap-4 mt-6">
        {[pencilStudy, belnapPortrait].map((image, idx) => (
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

      {/* Gated high-resolution download */}
      <div className="mt-8">
        {isSignedIn ? (
          <a
            href={hiResDownloadUrl}
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
            <span>Download high-resolution image</span>
            <span className="text-xs text-purple-500">[JPEG, 6.3 MB]</span>
          </a>
        ) : (
          <PreviewGate
            previewImages={[
              { url: paintingImage.url, alt: paintingImage.caption },
              { url: pencilStudy.url, alt: pencilStudy.caption },
              { url: belnapPortrait.url, alt: belnapPortrait.caption },
            ]}
            title="Download the painting"
            description="Create a free account to download a high-resolution image of the painting, suitable for printing and framing."
            onSignIn={onSignIn}
          />
        )}
      </div>

      {/* Credit and terms, shown in both states */}
      <p className="text-sm text-gray-500 mt-6">
        Painting by W. Dean Belnap, after Ernst Zimmermann. Shared by permission of the Belnap family for personal, non-commercial use. Reproductions for sale are not permitted.
      </p>
    </div>
  )
}
