import { useState } from 'react'
import { Link } from 'react-router-dom'
import { supabase } from '../../lib/supabase'
import { usePendingPhotos } from '../../hooks/usePendingPhotos'
import { useApprovedPhotos } from '../../hooks/useApprovedPhotos'

interface AdminPhotosTabProps {
  onActionComplete?: () => void
}

export function AdminPhotosTab({ onActionComplete }: AdminPhotosTabProps) {
  const [viewMode, setViewMode] = useState<'pending' | 'approved'>('pending')
  const { photos: pendingPhotos, loading: pendingLoading, error: pendingError, refetch: refetchPending } = usePendingPhotos()
  const { photos: approvedPhotos, loading: approvedLoading, error: approvedError, refetch: refetchApproved } = useApprovedPhotos()
  const [processing, setProcessing] = useState<string | null>(null)
  const [selectedPhoto, setSelectedPhoto] = useState<string | null>(null)

  const photos = viewMode === 'pending' ? pendingPhotos : approvedPhotos
  const loading = viewMode === 'pending' ? pendingLoading : approvedLoading
  const error = viewMode === 'pending' ? pendingError : approvedError
  
  const refetch = () => {
    if (viewMode === 'pending') {
      refetchPending()
    } else {
      refetchApproved()
    }
  }

  const handleApprove = async (photoId: string) => {
    setProcessing(photoId)
    try {
      const { error: updateError } = await supabase
        .from('photos')
        .update({
          status: 'approved',
          reviewed_at: new Date().toISOString(),
        })
        .eq('id', photoId)

      if (updateError) throw updateError
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to approve photo')
    } finally {
      setProcessing(null)
    }
  }

  const handleReject = async (photoId: string) => {
    setProcessing(photoId)
    try {
      const photo = photos.find((p) => p.id === photoId)
      if (photo && (photo.photo_url || (photo as any)?.file_url)) {
        const photoUrl = photo.photo_url || (photo as any).file_url
        const urlParts = photoUrl.split('/')
        const filePath = urlParts.slice(urlParts.indexOf('photos')).join('/')
        await supabase.storage.from('photos').remove([filePath])
      }

      const { error: updateError } = await supabase
        .from('photos')
        .update({
          status: 'rejected',
          reviewed_at: new Date().toISOString(),
        })
        .eq('id', photoId)
      if (updateError) throw updateError
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to reject photo')
    } finally {
      setProcessing(null)
    }
  }

  const handleDelete = async (photoId: string) => {
    if (!confirm('Are you sure you want to delete this photo? This action cannot be undone.')) {
      return
    }

    setProcessing(photoId)
    try {
      const photo = photos.find((p) => p.id === photoId)
      if (photo && (photo.photo_url || (photo as any)?.file_url)) {
        const photoUrl = photo.photo_url || (photo as any).file_url
        try {
          const url = new URL(photoUrl)
          const pathMatch = url.pathname.match(/\/storage\/v1\/object\/public\/photos\/(.+)/)
          if (pathMatch) {
            const filePath = pathMatch[1]
            await supabase.storage.from('photos').remove([filePath])
          }
        } catch (e) {
          console.error('Error extracting file path:', e)
        }
      }

      const { error: deleteError } = await supabase
        .from('photos')
        .delete()
        .eq('id', photoId)

      if (deleteError) throw deleteError
      
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to delete photo')
    } finally {
      setProcessing(null)
    }
  }

  if (loading) {
    return <div className="text-center py-8 text-gray-600">Loading photos...</div>
  }

  if (error) {
    return <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded">Error: {error.message}</div>
  }

  return (
    <div>
      <div className="mb-4 flex gap-2 border-b border-gray-200">
        <button
          onClick={() => setViewMode('pending')}
          className={`px-4 py-2 font-medium border-b-2 transition-colors ${
            viewMode === 'pending'
              ? 'border-primary-600 text-primary-700'
              : 'border-transparent text-gray-500 hover:text-gray-700'
          }`}
        >
          Pending ({pendingPhotos.length})
        </button>
        <button
          onClick={() => setViewMode('approved')}
          className={`px-4 py-2 font-medium border-b-2 transition-colors ${
            viewMode === 'approved'
              ? 'border-primary-600 text-primary-700'
              : 'border-transparent text-gray-500 hover:text-gray-700'
          }`}
        >
          Approved ({approvedPhotos.length})
        </button>
      </div>

      {photos.length === 0 && (
        <div className="text-center py-8 text-gray-600">
          No {viewMode} photos
        </div>
      )}

      {photos.length > 0 && (
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        {photos.map((photo) => {
          const photoUrl = photo.photo_url || (photo as any).file_url
          console.log('Photo data:', {
            id: photo.id,
            photo_url: photo.photo_url,
            file_url: (photo as any).file_url,
            resolvedUrl: photoUrl,
            caption: photo.caption,
          })
          
          // Extract file path from URL to potentially create signed URL
          let filePath: string | null = null
          if (photoUrl) {
            try {
              const url = new URL(photoUrl)
              // Extract path after /storage/v1/object/public/photos/
              const pathMatch = url.pathname.match(/\/storage\/v1\/object\/public\/photos\/(.+)/)
              if (pathMatch) {
                filePath = pathMatch[1]
                console.log('Extracted file path:', filePath)
              }
            } catch (e) {
              console.error('Error parsing URL:', e)
            }
          }
          
          return (
            <div key={photo.id} className="bg-white border border-gray-200 rounded-lg overflow-hidden">
              <div
                className="aspect-video bg-gray-100 cursor-pointer flex items-center justify-center"
                onClick={() => photoUrl && setSelectedPhoto(photoUrl)}
              >
                {photoUrl ? (
                  <img
                    src={photoUrl}
                    alt={photo.caption || 'Photo'}
                    className="w-full h-full object-cover"
                    onError={async (e) => {
                      console.error('Image load error for photo:', photo.id)
                      console.error('URL:', photoUrl)
                      console.error('File path:', filePath)
                      
                      // Try to get a signed URL as fallback
                      if (filePath) {
                        try {
                          const { data: signedData, error: signedError } = await supabase.storage
                            .from('photos')
                            .createSignedUrl(filePath, 3600)
                          
                          if (!signedError && signedData?.signedUrl) {
                            console.log('Generated signed URL:', signedData.signedUrl)
                            const target = e.target as HTMLImageElement
                            target.src = signedData.signedUrl
                            return
                          } else {
                            console.error('Failed to create signed URL:', signedError)
                          }
                        } catch (err) {
                          console.error('Error creating signed URL:', err)
                        }
                      }
                      
                      // Show placeholder on error
                      const target = e.target as HTMLImageElement
                      target.style.display = 'none'
                      const parent = target.parentElement
                      if (parent) {
                        parent.innerHTML = `
                          <div class="w-full h-full flex items-center justify-center text-gray-400">
                            <div class="text-center p-4">
                              <svg class="w-12 h-12 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                              </svg>
                              <p class="text-sm font-medium">Image not available</p>
                              <p class="text-xs mt-2 text-gray-500 break-all">${photoUrl.substring(0, 60)}...</p>
                              <p class="text-xs mt-1 text-gray-400">Check storage bucket permissions</p>
                            </div>
                          </div>
                        `
                      }
                    }}
                  />
                ) : (
                  <div className="w-full h-full flex items-center justify-center text-gray-400">
                    <div className="text-center">
                      <svg className="w-12 h-12 mx-auto mb-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M4 16l4.586-4.586a2 2 0 012.828 0L16 16m-2-2l1.586-1.586a2 2 0 012.828 0L20 14m-6-6h.01M6 20h12a2 2 0 002-2V6a2 2 0 00-2-2H6a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                      </svg>
                      <p className="text-sm">No photo URL</p>
                    </div>
                  </div>
                )}
              </div>
            <div className="p-4">
              {photo.caption && (
                <p className="text-sm text-gray-900 mb-2 font-medium">{photo.caption}</p>
              )}
              {photo.approximate_date && (
                <p className="text-xs text-gray-500 mb-2">Date: {photo.approximate_date}</p>
              )}
              {photo.event_context && (
                <p className="text-xs text-gray-500 mb-2">Event: {photo.event_context}</p>
              )}
              {(photo as any).person_id && (
                <div className="mb-2">
                  <p className="text-xs text-gray-500 mb-1">Person:</p>
                  <Link
                    to={`/person/${(photo as any).person_id}`}
                    className="text-xs text-primary-600 hover:text-primary-700 hover:underline"
                  >
                    {(photo as any).person_name || 'View Person'}
                  </Link>
                </div>
              )}
              {(photo as any).person_names && (photo as any).person_names.length > 0 && (
                <div className="mb-2">
                  <p className="text-xs text-gray-500 mb-1">Tagged:</p>
                  <div className="flex flex-wrap gap-1">
                    {(photo as any).person_ids?.map((personId: string, idx: number) => (
                      <Link
                        key={personId}
                        to={`/person/${personId}`}
                        className="text-xs text-primary-600 hover:text-primary-700 hover:underline"
                      >
                        {(photo as any).person_names?.[idx]}
                      </Link>
                    ))}
                  </div>
                </div>
              )}
              <div className="text-xs text-gray-500 mb-3">
                Submitted by: {photo.submitter_name}
                {photo.submitter_email && ` (${photo.submitter_email})`}
              </div>
              <div className="flex gap-2">
                {viewMode === 'pending' ? (
                  <>
                    <button
                      onClick={() => handleApprove(photo.id)}
                      disabled={processing === photo.id}
                      className="flex-1 px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm"
                    >
                      Approve
                    </button>
                    <button
                      onClick={() => handleReject(photo.id)}
                      disabled={processing === photo.id}
                      className="flex-1 px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50 text-sm"
                    >
                      Reject
                    </button>
                  </>
                ) : (
                  <button
                    onClick={() => handleDelete(photo.id)}
                    disabled={processing === photo.id}
                    className="w-full px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50 text-sm"
                  >
                    Delete
                  </button>
                )}
              </div>
            </div>
          </div>
        )
        })}
        </div>
      )}

      {selectedPhoto && (
        <div
          className="fixed inset-0 bg-black bg-opacity-75 flex items-center justify-center z-50 p-4"
          onClick={() => setSelectedPhoto(null)}
        >
          <div className="max-w-4xl max-h-[90vh] overflow-auto">
            <img src={selectedPhoto} alt="Full size" className="max-w-full h-auto" />
          </div>
        </div>
      )}
    </div>
  )
}

