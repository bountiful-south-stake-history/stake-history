import { useState, useEffect } from 'react'
import { supabase } from '../../lib/supabase'
import { useAuth } from '../../hooks/useAuth'
import { ImageLightbox } from './ImageLightbox'
import compressImage from 'browser-image-compression'

interface BuildingPhoto {
  id: string
  photo_url: string
  caption?: string
  approximate_date?: string
  submitter_name?: string
}

interface BuildingPhotoAlbumProps {
  buildingId: string
  buildingName: string
}

export function BuildingPhotoAlbum({ buildingId, buildingName }: BuildingPhotoAlbumProps) {
  const { user } = useAuth()
  const [photos, setPhotos] = useState<BuildingPhoto[]>([])
  const [loading, setLoading] = useState(true)
  const [error, setError] = useState<string | null>(null)
  const [lightboxImage, setLightboxImage] = useState<{ url: string; alt: string } | null>(null)
  const [showSubmitModal, setShowSubmitModal] = useState(false)

  useEffect(() => {
    fetchPhotos()
  }, [buildingId])

  const fetchPhotos = async () => {
    try {
      setLoading(true)
      setError(null)

      const { data, error: fetchError } = await supabase
        .from('photos')
        .select('id, photo_url, caption, approximate_date, submitter_name')
        .eq('building_id', buildingId)
        .eq('status', 'approved')
        .order('submitted_at', { ascending: false })

      if (fetchError) throw fetchError

      // Generate signed URLs for private bucket
      const photosWithSignedUrls = await Promise.all(
        (data || []).map(async (photo) => {
          let displayUrl = photo.photo_url
          if (photo.photo_url) {
            try {
              const url = new URL(photo.photo_url)
              const pathMatch = url.pathname.match(/\/storage\/v1\/object\/(?:public|sign)\/photos\/(.+)/)
              if (pathMatch) {
                const { data: signedData } = await supabase.storage
                  .from('photos')
                  .createSignedUrl(pathMatch[1], 86400)
                if (signedData?.signedUrl) displayUrl = signedData.signedUrl
              }
            } catch { /* fall back to raw url */ }
          }
          return { ...photo, photo_url: displayUrl }
        })
      )

      setPhotos(photosWithSignedUrls)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to load photos')
    } finally {
      setLoading(false)
    }
  }

  return (
    <div>
      <div className="flex items-center justify-between mb-4">
        <h3 className="text-lg font-semibold text-gray-900">Photos</h3>
        {user && (
          <button
            onClick={() => setShowSubmitModal(true)}
            className="px-4 py-2 bg-primary-600 text-white text-sm rounded-lg hover:bg-primary-700 transition-colors"
          >
            Submit Photo
          </button>
        )}
      </div>

      {loading && <p className="text-gray-500 text-sm">Loading photos...</p>}
      {error && <p className="text-red-600 text-sm">{error}</p>}

      {!loading && photos.length === 0 && (
        <p className="text-gray-500 text-sm py-4">
          No photos yet.{user ? ' Be the first to submit one!' : ' Sign in to submit photos.'}
        </p>
      )}

      {photos.length > 0 && (
        <div className="grid grid-cols-2 sm:grid-cols-3 lg:grid-cols-4 gap-3">
          {photos.map((photo) => (
            <div
              key={photo.id}
              className="aspect-square bg-gray-100 rounded-lg overflow-hidden cursor-pointer hover:opacity-90 transition-opacity"
              onClick={() => setLightboxImage({ url: photo.photo_url, alt: photo.caption || buildingName })}
            >
              <img
                src={photo.photo_url}
                alt={photo.caption || buildingName}
                className="w-full h-full object-cover"
                onError={(e) => {
                  const target = e.target as HTMLImageElement
                  target.style.display = 'none'
                }}
              />
            </div>
          ))}
        </div>
      )}

      {lightboxImage && (
        <ImageLightbox
          imageUrl={lightboxImage.url}
          alt={lightboxImage.alt}
          onClose={() => setLightboxImage(null)}
        />
      )}

      {showSubmitModal && (
        <BuildingPhotoSubmitModal
          buildingId={buildingId}
          buildingName={buildingName}
          onClose={() => setShowSubmitModal(false)}
          onSuccess={() => {
            setShowSubmitModal(false)
            fetchPhotos()
          }}
        />
      )}
    </div>
  )
}

interface BuildingPhotoSubmitModalProps {
  buildingId: string
  buildingName: string
  onClose: () => void
  onSuccess: () => void
}

function BuildingPhotoSubmitModal({ buildingId, buildingName, onClose, onSuccess }: BuildingPhotoSubmitModalProps) {
  const { user } = useAuth()
  const [file, setFile] = useState<File | null>(null)
  const [preview, setPreview] = useState<string | null>(null)
  const [caption, setCaption] = useState('')
  const [approximateDate, setApproximateDate] = useState('')
  const [submitterName, setSubmitterName] = useState('')
  const [submitterEmail, setSubmitterEmail] = useState('')
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState(false)

  useEffect(() => {
    if (user) {
      const autoPopulate = async () => {
        if (user.email) setSubmitterEmail(prev => prev || user.email || '')
        try {
          const { data } = await supabase
            .from('user_profiles')
            .select('display_name')
            .eq('id', user.id)
            .single()
          if (data?.display_name) setSubmitterName(prev => prev || data.display_name)
        } catch {}
      }
      autoPopulate()
    }
  }, [user])

  const handleFileChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const selected = e.target.files?.[0]
    if (selected) {
      setFile(selected)
      const reader = new FileReader()
      reader.onload = () => setPreview(reader.result as string)
      reader.readAsDataURL(selected)
    }
  }

  const handleSubmit = async () => {
    if (!file) { setError('Please select a photo'); return }
    if (!submitterName.trim()) { setError('Please enter your name'); return }
    if (!submitterEmail.trim()) { setError('Please enter your email'); return }

    setSubmitting(true)
    setError(null)

    try {
      const compressedFile = await compressImage(file, {
        maxSizeMB: 1,
        maxWidthOrHeight: 1920,
        useWebWorker: true,
      })
      const timestamp = Date.now()
      const sanitizedName = file.name.replace(/[^a-zA-Z0-9.-]/g, '_')
      const filePath = `photos/pending/buildings/${buildingId}/${timestamp}-${sanitizedName}`

      const { error: uploadError } = await supabase.storage
        .from('photos')
        .upload(filePath, compressedFile, { cacheControl: '3600', upsert: false })

      if (uploadError) throw new Error(`Upload failed: ${uploadError.message}`)

      const { data: { publicUrl } } = supabase.storage.from('photos').getPublicUrl(filePath)

      const photoId = crypto.randomUUID()
      const { error: insertError } = await supabase
        .from('photos')
        .insert({
          id: photoId,
          photo_url: publicUrl,
          caption: caption || null,
          approximate_date: approximateDate || null,
          building_id: buildingId,
          submitter_name: submitterName,
          submitter_email: submitterEmail,
          status: 'pending',
        })

      if (insertError) {
        try { await supabase.storage.from('photos').remove([filePath]) } catch {}
        throw insertError
      }

      setSuccess(true)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to submit photo')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4" onClick={onClose}>
      <div className="bg-white rounded-lg shadow-xl max-w-lg w-full max-h-[90vh] overflow-y-auto p-6" onClick={e => e.stopPropagation()}>
        {success ? (
          <div className="text-center py-8">
            <div className="text-4xl mb-4">✓</div>
            <h3 className="text-xl font-semibold text-gray-900 mb-2">Photo Submitted!</h3>
            <p className="text-gray-600 mb-6">Your photo will appear after admin review.</p>
            <button
              onClick={onSuccess}
              className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700"
            >
              Done
            </button>
          </div>
        ) : (
          <>
            <h2 className="text-xl font-semibold text-gray-900 mb-1">Submit Photo</h2>
            <p className="text-sm text-gray-600 mb-4">for {buildingName}</p>

            {error && (
              <div className="px-4 py-3 bg-red-50 border border-red-200 rounded-lg text-red-700 text-sm mb-4">
                {error}
              </div>
            )}

            <div className="space-y-4">
              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Photo <span className="text-red-600">*</span>
                </label>
                <input
                  type="file"
                  accept="image/*"
                  onChange={handleFileChange}
                  className="w-full text-sm text-gray-500 file:mr-4 file:py-2 file:px-4 file:rounded-lg file:border-0 file:text-sm file:font-medium file:bg-primary-50 file:text-primary-700 hover:file:bg-primary-100"
                  disabled={submitting}
                />
                {preview && (
                  <img src={preview} alt="Preview" className="mt-2 max-h-48 rounded-lg object-cover" />
                )}
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">Caption</label>
                <input
                  type="text"
                  value={caption}
                  onChange={e => setCaption(e.target.value)}
                  placeholder="Describe this photo..."
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  disabled={submitting}
                />
              </div>

              <div>
                <label className="block text-sm font-medium text-gray-700 mb-1">
                  Approximate Date <span className="text-gray-500 font-normal">(optional)</span>
                </label>
                <input
                  type="text"
                  value={approximateDate}
                  onChange={e => setApproximateDate(e.target.value)}
                  placeholder="e.g., 1971, Summer 1985"
                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                  disabled={submitting}
                />
              </div>

              <div className="border-t border-gray-200 pt-4">
                <h4 className="text-sm font-semibold text-gray-900 mb-3">Your Information</h4>
                <div className="space-y-3">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Name <span className="text-red-600">*</span>
                    </label>
                    <input
                      type="text"
                      value={submitterName}
                      onChange={e => setSubmitterName(e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={submitting}
                    />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-1">
                      Email <span className="text-red-600">*</span>
                    </label>
                    <input
                      type="email"
                      value={submitterEmail}
                      onChange={e => setSubmitterEmail(e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={submitting}
                    />
                  </div>
                </div>
              </div>
            </div>

            <div className="flex gap-3 justify-end mt-6 pt-4 border-t border-gray-200">
              <button
                onClick={onClose}
                disabled={submitting}
                className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50"
              >
                Cancel
              </button>
              <button
                onClick={handleSubmit}
                disabled={submitting}
                className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 flex items-center gap-2"
              >
                {submitting ? (
                  <>
                    <svg className="animate-spin h-4 w-4 text-white" fill="none" viewBox="0 0 24 24">
                      <circle className="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" strokeWidth="4" />
                      <path className="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z" />
                    </svg>
                    Submitting...
                  </>
                ) : 'Submit Photo'}
              </button>
            </div>
          </>
        )}
      </div>
    </div>
  )
}
