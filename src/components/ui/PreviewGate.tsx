interface PreviewGateProps {
  previewImages: { url: string; alt: string }[]
  title: string
  description: string
  onSignIn: () => void
}

/**
 * A sign-in gate that previews the gated content rather than merely refusing it.
 * Shows de-emphasized teaser images with a lock affordance, then a heading,
 * description, and a Sign In call to action. Renders only the signed-out state;
 * callers decide when to show it.
 *
 * Preview images are intentionally non-interactive (no click, no hover) — they
 * are teasers, not lightbox triggers.
 */
export function PreviewGate({ previewImages, title, description, onSignIn }: PreviewGateProps) {
  return (
    <div>
      <div className="relative">
        {/* Teaser previews: reduced opacity reads as "locked" without hiding
            what's behind the gate. Stacks on mobile, row on sm+. */}
        <div className="grid grid-cols-1 sm:grid-cols-3 gap-4">
          {previewImages.map((image, idx) => (
            <img
              key={idx}
              src={image.url}
              alt={image.alt}
              loading="lazy"
              className="w-full h-40 object-cover rounded-lg opacity-70"
            />
          ))}
        </div>

        {/* Lock affordance overlaid on the previews. pointer-events-none keeps
            the teasers non-interactive and the badge from blocking anything. */}
        <div className="absolute inset-0 flex items-center justify-center pointer-events-none">
          <span className="flex items-center justify-center w-14 h-14 rounded-full bg-white/90 shadow-md">
            <svg className="w-7 h-7 text-primary-700" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
              />
            </svg>
          </span>
        </div>
      </div>

      <div className="mt-4">
        <h3 className="text-lg font-semibold text-gray-900 mb-2">{title}</h3>
        <p className="text-gray-700 mb-4">{description}</p>
        <button
          type="button"
          onClick={onSignIn}
          className="px-4 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 transition-colors"
        >
          Sign In
        </button>
      </div>
    </div>
  )
}
