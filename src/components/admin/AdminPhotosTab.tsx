import { useState, useRef, useEffect, useCallback } from 'react'
import { Link } from 'react-router-dom'
import ReactCrop, { type Crop, centerCrop, makeAspectCrop } from 'react-image-crop'
import 'react-image-crop/dist/ReactCrop.css'
import { supabase } from '../../lib/supabase'
import { usePendingPhotos } from '../../hooks/usePendingPhotos'
import { useApprovedPhotos } from '../../hooks/useApprovedPhotos'
import { usePeopleSearch } from '../../hooks/usePeopleSearch'
import { useAuth } from '../../hooks/useAuth'
import compressImage from 'browser-image-compression'
import type { Person } from '../../lib/types'

interface AdminPhotosTabProps {
  onActionComplete?: () => void
}

export function AdminPhotosTab({ onActionComplete }: AdminPhotosTabProps) {
  const { user } = useAuth()
  const [viewMode, setViewMode] = useState<'pending' | 'approved'>('pending')
  const { photos: pendingPhotos, loading: pendingLoading, error: pendingError, refetch: refetchPending } = usePendingPhotos()
  const { photos: approvedPhotos, loading: approvedLoading, error: approvedError, refetch: refetchApproved } = useApprovedPhotos()
  const [processing, setProcessing] = useState<string | null>(null)
  const [selectedPhoto, setSelectedPhoto] = useState<string | null>(null)
  const [editingPhoto, setEditingPhoto] = useState<string | null>(null)
  const [editCaption, setEditCaption] = useState('')
  const [editDate, setEditDate] = useState('')
  const [editEvent, setEditEvent] = useState('')
  const [editSubmitterName, setEditSubmitterName] = useState('')
  const [editSubmitterEmail, setEditSubmitterEmail] = useState('')
  const [editTaggedPeople, setEditTaggedPeople] = useState<Person[]>([])
  const [editAdditionalPeople, setEditAdditionalPeople] = useState<string[]>([])
  const [tagSearchTerm, setTagSearchTerm] = useState('')
  const [showTagDropdown, setShowTagDropdown] = useState(false)
  const tagSearchRef = useRef<HTMLDivElement>(null)
  const [deleteConfirmState, setDeleteConfirmState] = useState<Record<string, 'none' | 'warning' | 'modal'>>({})
  const [deleteConfirmText, setDeleteConfirmText] = useState<Record<string, string>>({})

  // Crop-related state
  const [showCropInterface, setShowCropInterface] = useState(false)
  const [crop, setCrop] = useState<Crop>()
  const [completedCrop, setCompletedCrop] = useState<Crop>()
  const cropImgRef = useRef<HTMLImageElement>(null)
  const [cropImageUrl, setCropImageUrl] = useState<string | null>(null)
  const [croppedPreviewUrl, setCroppedPreviewUrl] = useState<string | null>(null)
  const [croppedBlob, setCroppedBlob] = useState<Blob | null>(null)

  // Image enhancement state
  const [brightness, setBrightness] = useState(0)
  const [contrast, setContrast] = useState(0)
  const [saturation, setSaturation] = useState(0)
  const [adjustedBlob, setAdjustedBlob] = useState<Blob | null>(null)
  const [adjustedPreviewUrl, setAdjustedPreviewUrl] = useState<string | null>(null)

  // Accordion state for edit form sections
  const [openSection, setOpenSection] = useState<'crop' | 'adjust' | 'focal' | null>(null)

  // Focal point state (percentage from top-left)
  const [focalPointX, setFocalPointX] = useState(50)
  const [focalPointY, setFocalPointY] = useState(50)
  const focalPointRef = useRef<HTMLDivElement>(null)

  // Computed CSS filter for real-time preview
  const imageFilter = `brightness(${1 + brightness / 100}) contrast(${1 + contrast / 100}) saturate(${1 + saturation / 100})`
  const hasAdjustments = brightness !== 0 || contrast !== 0 || saturation !== 0

  const photos = viewMode === 'pending' ? pendingPhotos : approvedPhotos
  const loading = viewMode === 'pending' ? pendingLoading : approvedLoading
  const error = viewMode === 'pending' ? pendingError : approvedError
  const { people: tagSearchResults, loading: tagSearchLoading } = usePeopleSearch(tagSearchTerm)
  
  const refetch = () => {
    if (viewMode === 'pending') {
      refetchPending()
    } else {
      refetchApproved()
    }
  }

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (tagSearchRef.current && !tagSearchRef.current.contains(event.target as Node)) {
        setShowTagDropdown(false)
      }
    }
    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  // Reset crop and enhancement state when editing changes
  useEffect(() => {
    if (!editingPhoto) {
      setShowCropInterface(false)
      setCrop(undefined)
      setCompletedCrop(undefined)
      setCropImageUrl(null)
      setCroppedPreviewUrl(null)
      setCroppedBlob(null)
      setBrightness(0)
      setContrast(0)
      setSaturation(0)
      setAdjustedBlob(null)
      setAdjustedPreviewUrl(null)
      setOpenSection(null)
    }
  }, [editingPhoto])

  const onCropImageLoad = useCallback((e: React.SyntheticEvent<HTMLImageElement>) => {
    const { naturalWidth, naturalHeight } = e.currentTarget
    // For photos, use a free-form crop starting at 90% of the image
    const initialCrop = centerCrop(
      makeAspectCrop(
        {
          unit: '%',
          width: 90,
        },
        naturalWidth / naturalHeight, // Keep original aspect ratio initially
        naturalWidth,
        naturalHeight
      ),
      naturalWidth,
      naturalHeight
    )
    setCrop(initialCrop)
    setCompletedCrop(initialCrop)
  }, [])

  const getCroppedImg = useCallback(async (image: HTMLImageElement, cropData: Crop, filterString?: string): Promise<Blob> => {
    if (!image.complete) {
      throw new Error('Image not loaded')
    }

    if (!cropData || cropData.x === undefined || cropData.y === undefined || !cropData.width || !cropData.height) {
      throw new Error('Invalid crop coordinates')
    }

    const canvas = document.createElement('canvas')
    const naturalWidth = image.naturalWidth
    const naturalHeight = image.naturalHeight
    const pixelRatio = window.devicePixelRatio

    let cropX: number, cropY: number, cropWidth: number, cropHeight: number

    if (cropData.unit === '%') {
      cropX = (cropData.x / 100) * naturalWidth
      cropY = (cropData.y / 100) * naturalHeight
      cropWidth = (cropData.width / 100) * naturalWidth
      cropHeight = (cropData.height / 100) * naturalHeight
    } else {
      const scaleX = naturalWidth / image.width
      const scaleY = naturalHeight / image.height
      cropX = cropData.x * scaleX
      cropY = cropData.y * scaleY
      cropWidth = cropData.width * scaleX
      cropHeight = cropData.height * scaleY
    }

    canvas.width = Math.round(cropWidth * pixelRatio)
    canvas.height = Math.round(cropHeight * pixelRatio)

    const ctx = canvas.getContext('2d')
    if (!ctx) throw new Error('No 2d context')

    ctx.setTransform(pixelRatio, 0, 0, pixelRatio, 0, 0)
    ctx.imageSmoothingQuality = 'high'

    if (filterString) {
      ctx.filter = filterString
    }

    ctx.drawImage(
      image,
      Math.round(cropX),
      Math.round(cropY),
      Math.round(cropWidth),
      Math.round(cropHeight),
      0,
      0,
      cropWidth,
      cropHeight
    )

    return new Promise((resolve, reject) => {
      canvas.toBlob(
        (blob) => {
          if (!blob) {
            reject(new Error('Canvas is empty'))
            return
          }
          resolve(blob)
        },
        'image/jpeg',
        0.95
      )
    })
  }, [])

  const generateCroppedPreview = useCallback(async (filterString?: string) => {
    if (!completedCrop || !cropImgRef.current) return null

    const image = cropImgRef.current
    if (!image.complete) return null

    const canvas = document.createElement('canvas')
    const ctx = canvas.getContext('2d')
    if (!ctx) return null

    const naturalWidth = image.naturalWidth
    const naturalHeight = image.naturalHeight

    let cropX: number, cropY: number, cropWidth: number, cropHeight: number

    if (completedCrop.unit === '%') {
      cropX = (completedCrop.x / 100) * naturalWidth
      cropY = (completedCrop.y / 100) * naturalHeight
      cropWidth = (completedCrop.width / 100) * naturalWidth
      cropHeight = (completedCrop.height / 100) * naturalHeight
    } else {
      const scaleX = naturalWidth / image.width
      const scaleY = naturalHeight / image.height
      cropX = completedCrop.x * scaleX
      cropY = completedCrop.y * scaleY
      cropWidth = completedCrop.width * scaleX
      cropHeight = completedCrop.height * scaleY
    }

    // Preview at reasonable size
    const maxPreviewWidth = 300
    const scale = maxPreviewWidth / cropWidth
    canvas.width = maxPreviewWidth
    canvas.height = cropHeight * scale

    ctx.imageSmoothingQuality = 'high'

    if (filterString) {
      ctx.filter = filterString
    }

    ctx.drawImage(
      image,
      Math.round(cropX),
      Math.round(cropY),
      Math.round(cropWidth),
      Math.round(cropHeight),
      0,
      0,
      canvas.width,
      canvas.height
    )

    return canvas.toDataURL('image/jpeg', 0.9)
  }, [completedCrop])

  const handleStartCrop = (photoUrl: string) => {
    setCropImageUrl(photoUrl)
    setShowCropInterface(true)
    setCrop(undefined)
    setCompletedCrop(undefined)
    setCroppedPreviewUrl(null)
    setCroppedBlob(null)
    setBrightness(0)
    setContrast(0)
    setSaturation(0)
  }

  const resetEnhancements = () => {
    setBrightness(0)
    setContrast(0)
    setSaturation(0)
    setAdjustedBlob(null)
    setAdjustedPreviewUrl(null)
  }

  const applyAdjustments = useCallback(async (imageUrl: string) => {
    if (!hasAdjustments) return

    const img = new Image()
    img.crossOrigin = 'anonymous'

    await new Promise<void>((resolve, reject) => {
      img.onload = () => resolve()
      img.onerror = reject
      img.src = imageUrl
    })

    const canvas = document.createElement('canvas')
    const pixelRatio = window.devicePixelRatio
    canvas.width = img.naturalWidth * pixelRatio
    canvas.height = img.naturalHeight * pixelRatio

    const ctx = canvas.getContext('2d')
    if (!ctx) throw new Error('No 2d context')

    ctx.setTransform(pixelRatio, 0, 0, pixelRatio, 0, 0)
    ctx.imageSmoothingQuality = 'high'
    ctx.filter = imageFilter

    ctx.drawImage(img, 0, 0, img.naturalWidth, img.naturalHeight)

    const blob = await new Promise<Blob>((resolve, reject) => {
      canvas.toBlob(
        (b) => b ? resolve(b) : reject(new Error('Failed to create blob')),
        'image/jpeg',
        0.95
      )
    })

    setAdjustedBlob(blob)
    setAdjustedPreviewUrl(canvas.toDataURL('image/jpeg', 0.9))
    setOpenSection(null)
  }, [hasAdjustments, imageFilter])

  const handleDoneCropping = async () => {
    const preview = await generateCroppedPreview(imageFilter)
    if (preview) {
      setCroppedPreviewUrl(preview)
    }

    if (completedCrop && cropImgRef.current) {
      try {
        const blob = await getCroppedImg(cropImgRef.current, completedCrop, imageFilter)
        setCroppedBlob(blob)
      } catch (err) {
        console.error('Failed to generate cropped blob:', err)
      }
    }

    setShowCropInterface(false)
  }

  const handleCancelCrop = () => {
    setShowCropInterface(false)
    setCrop(undefined)
    setCompletedCrop(undefined)
    setCropImageUrl(null)
  }

  const handleStartEdit = async (photoId: string) => {
    const photo = photos.find((p) => p.id === photoId)
    if (!photo) return

    setEditCaption(photo.caption || '')
    setEditDate(photo.approximate_date || '')
    setEditEvent(photo.event_context || '')
    setEditSubmitterName(photo.submitter_name || '')
    setEditSubmitterEmail(photo.submitter_email || '')

    const { data: photoPeopleData } = await supabase
      .from('photo_people')
      .select(`
        person_id,
        people:person_id (
          id,
          display_name,
          full_name
        )
      `)
      .eq('photo_id', photoId)

    const taggedPeople: Person[] = []
    if (photoPeopleData) {
      photoPeopleData.forEach((item: any) => {
        if (item.people) {
          taggedPeople.push({
            id: item.people.id,
            display_name: item.people.display_name,
            full_name: item.people.full_name,
          } as Person)
        }
      })
    }
    setEditTaggedPeople(taggedPeople)

    let additionalPeople: string[] = []
    try {
      if (photo.additional_people) {
        additionalPeople = typeof photo.additional_people === 'string' 
          ? JSON.parse(photo.additional_people) 
          : photo.additional_people
      }
    } catch (e) {
      console.error('Failed to parse additional_people:', e)
    }
    setEditAdditionalPeople(additionalPeople || [])
    
    // Load focal point (default to center if not set)
    setFocalPointX((photo as any).focal_x ?? 50)
    setFocalPointY((photo as any).focal_y ?? 50)
    
    setEditingPhoto(photoId)
  }

  const handleCancelEdit = () => {
    setEditingPhoto(null)
    setEditCaption('')
    setEditDate('')
    setEditEvent('')
    setEditSubmitterName('')
    setEditSubmitterEmail('')
    setEditTaggedPeople([])
    setEditAdditionalPeople([])
    setTagSearchTerm('')
    setShowTagDropdown(false)
    setFocalPointX(50)
    setFocalPointY(50)
  }

  const handleSaveEdit = async () => {
    if (!editingPhoto) return

    setProcessing(editingPhoto)
    try {
      const photo = photos.find((p) => p.id === editingPhoto)
      if (!photo) throw new Error('Photo not found')

      let newPhotoUrl = photo.photo_url
      const oldPhotoUrl = photo.photo_url
      let fileToUpload: Blob | null = null

      // If crop was adjusted, use the stored cropped blob
      if (croppedBlob) {
        const croppedFile = new File([croppedBlob], 'cropped.jpg', { type: 'image/jpeg' })
        fileToUpload = await compressImage(croppedFile, {
          maxSizeMB: 1,
          maxWidthOrHeight: 1920,
          useWebWorker: true,
        })
      }
      // If adjustments were applied (without cropping), use the adjusted blob
      else if (adjustedBlob) {
        const adjustedFile = new File([adjustedBlob], 'adjusted.jpg', { type: 'image/jpeg' })
        fileToUpload = await compressImage(adjustedFile, {
          maxSizeMB: 1,
          maxWidthOrHeight: 1920,
          useWebWorker: true,
        })
      }

      if (fileToUpload) {
        const timestamp = Date.now()
        const newPath = `photos/${editingPhoto}_${timestamp}.jpg`

        const { error: uploadError } = await supabase.storage
          .from('photos')
          .upload(newPath, fileToUpload, { upsert: true })

        if (uploadError) throw uploadError

        const {
          data: { publicUrl },
        } = supabase.storage.from('photos').getPublicUrl(newPath)

        newPhotoUrl = publicUrl

        // Delete old file if URL changed
        if (oldPhotoUrl && oldPhotoUrl !== newPhotoUrl) {
          try {
            const url = new URL(oldPhotoUrl)
            const pathMatch = url.pathname.match(/\/storage\/v1\/object\/public\/photos\/(.+)/)
            if (pathMatch) {
              await supabase.storage.from('photos').remove([pathMatch[1]])
            }
          } catch (e) {
            console.error('Error deleting old photo:', e)
          }
        }
      }

      const { error: updateError } = await supabase
        .from('photos')
        .update({
          caption: editCaption,
          approximate_date: editDate || null,
          event_context: editEvent || null,
          submitter_name: editSubmitterName,
          submitter_email: editSubmitterEmail,
          additional_people: editAdditionalPeople.length > 0 ? JSON.stringify(editAdditionalPeople) : null,
          photo_url: newPhotoUrl,
          focal_x: focalPointX,
          focal_y: focalPointY,
        })
        .eq('id', editingPhoto)

      if (updateError) throw updateError

      const { error: deleteError } = await supabase
        .from('photo_people')
        .delete()
        .eq('photo_id', editingPhoto)

      if (deleteError) throw deleteError

      if (editTaggedPeople.length > 0) {
        const photoPeopleRecords = editTaggedPeople.map(person => ({
          photo_id: editingPhoto,
          person_id: person.id,
        }))

        const { error: insertError } = await supabase
          .from('photo_people')
          .insert(photoPeopleRecords)

        if (insertError) throw insertError
      }

      if (user) {
        await supabase.from('audit_log').insert({
          table_name: 'photos',
          record_id: editingPhoto,
          action: 'edit_photo',
          old_values: null,
          new_values: {
            caption: editCaption,
            approximate_date: editDate,
            event_context: editEvent,
            submitter_name: editSubmitterName,
            submitter_email: editSubmitterEmail,
            tagged_people_count: editTaggedPeople.length,
            image_modified: !!(croppedBlob || adjustedBlob),
          },
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }

      handleCancelEdit()
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to save changes')
    } finally {
      setProcessing(null)
    }
  }

  const handleAddTaggedPerson = (personToAdd: Person) => {
    if (!editTaggedPeople.find(p => p.id === personToAdd.id)) {
      setEditTaggedPeople([...editTaggedPeople, personToAdd])
    }
    setTagSearchTerm('')
    setShowTagDropdown(false)
  }

  const handleAddAdditionalPerson = (name: string) => {
    const trimmedName = name.trim()
    if (trimmedName && !editAdditionalPeople.includes(trimmedName)) {
      setEditAdditionalPeople([...editAdditionalPeople, trimmedName])
    }
    setTagSearchTerm('')
    setShowTagDropdown(false)
  }

  const handleRemoveTaggedPerson = (personId: string) => {
    setEditTaggedPeople(editTaggedPeople.filter(p => p.id !== personId))
  }

  const handleRemoveAdditionalPerson = (name: string) => {
    setEditAdditionalPeople(editAdditionalPeople.filter(n => n !== name))
  }

  const handleApprove = async (photoId: string) => {
    setProcessing(photoId)
    try {
      const photo = photos.find((p) => p.id === photoId)
      if (!photo) throw new Error('Photo not found')

      const { error: updateError } = await supabase
        .from('photos')
        .update({
          status: 'approved',
          reviewed_at: new Date().toISOString(),
        })
        .eq('id', photoId)

      if (updateError) throw updateError

      const { data: taggedPeopleData, error: taggedError } = await supabase
        .from('photo_people')
        .select('person_id')
        .eq('photo_id', photoId)

      if (taggedError) {
        console.error('Failed to fetch tagged people:', taggedError)
      } else if (taggedPeopleData && taggedPeopleData.length > 0) {
        const photoTitle = photo.caption || 'New photo'
        const activityRecords = taggedPeopleData.map((item) => ({
          person_id: item.person_id,
          activity_type: 'photo_tag' as const,
          photo_id: photoId,
          memory_id: null,
          title: photoTitle,
        }))

        const { error: activityError } = await supabase
          .from('follow_activity')
          .insert(activityRecords)

        if (activityError) {
          console.error('Failed to create activity records:', activityError)
        }
      }

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

  const handleDeleteClick = (photoId: string) => {
    const currentState = deleteConfirmState[photoId] || 'none'
    if (currentState === 'none') {
      setDeleteConfirmState({ ...deleteConfirmState, [photoId]: 'warning' })
    } else if (currentState === 'warning') {
      setDeleteConfirmState({ ...deleteConfirmState, [photoId]: 'modal' })
      setDeleteConfirmText({ ...deleteConfirmText, [photoId]: '' })
    }
  }

  const handleDeleteCancel = (photoId: string) => {
    setDeleteConfirmState({ ...deleteConfirmState, [photoId]: 'none' })
    setDeleteConfirmText({ ...deleteConfirmText, [photoId]: '' })
  }

  const handleDeleteConfirm = async (photoId: string) => {
    setProcessing(photoId)
    try {
      const photo = photos.find((p) => p.id === photoId)
      if (!photo) throw new Error('Photo not found')

      const { error: deletePeopleError } = await supabase
        .from('photo_people')
        .delete()
        .eq('photo_id', photoId)

      if (deletePeopleError) throw deletePeopleError

      if (photo.photo_url || (photo as any)?.file_url) {
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

      if (user) {
        await supabase.from('audit_log').insert({
          table_name: 'photos',
          record_id: photoId,
          action: 'delete_photo',
          old_values: {
            caption: photo.caption,
            photo_url: photo.photo_url,
          },
          new_values: null,
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }

      setDeleteConfirmState({ ...deleteConfirmState, [photoId]: 'none' })
      setDeleteConfirmText({ ...deleteConfirmText, [photoId]: '' })
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
                    style={{ objectPosition: `${(photo as any).focal_x ?? 50}% ${(photo as any).focal_y ?? 50}%` }}
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
              {(((photo as any).taggedPeople?.length > 0) || ((photo as any).additionalPeople?.length > 0)) && (
                <div className="mb-2">
                  <p className="text-xs text-gray-500 mb-1">Tagged:</p>
                  <div className="flex flex-wrap gap-1">
                    {[
                      ...((photo as any).taggedPeople || []).map((taggedPerson: any) => (
                        <Link
                          key={taggedPerson.id}
                          to={`/person/${taggedPerson.id}`}
                          className="text-xs text-primary-600 hover:text-primary-700 hover:underline"
                        >
                          {taggedPerson.display_name || taggedPerson.full_name}
                        </Link>
                      )),
                      ...((photo as any).additionalPeople || []).map((name: string, idx: number) => (
                        <span key={`additional-${idx}`} className="text-xs text-gray-700">{name}</span>
                      ))
                    ].map((item, idx, arr) => (
                      <span key={idx}>
                        {item}
                        {idx < arr.length - 1 && ', '}
                      </span>
                    ))}
                  </div>
                </div>
              )}
              <div className="text-xs text-gray-500 mb-3">
                Submitted by: {photo.submitter_name}
                {photo.submitter_email && ` (${photo.submitter_email})`}
              </div>
              <div className="flex gap-2 flex-col">
                <div className="flex gap-2">
                  <button
                    onClick={() => handleStartEdit(photo.id)}
                    disabled={processing === photo.id}
                    className="flex-1 px-3 py-1 bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50 text-sm"
                  >
                    Edit
                  </button>
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
                      onClick={() => handleDeleteClick(photo.id)}
                      disabled={processing === photo.id}
                      className={`flex-1 px-3 py-1 rounded text-sm disabled:opacity-50 ${
                        deleteConfirmState[photo.id] === 'warning'
                          ? 'bg-yellow-50 border-yellow-400 text-yellow-700 hover:bg-yellow-100 border-2'
                          : 'border-red-300 text-red-700 hover:bg-red-50 border-2'
                      }`}
                    >
                      {deleteConfirmState[photo.id] === 'warning' ? 'Are you sure?' : 'Delete'}
                    </button>
                  )}
                </div>
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

      {editingPhoto && (() => {
        const photo = photos.find((p) => p.id === editingPhoto)
        if (!photo) return null
        const photoUrl = photo.photo_url || (photo as any).file_url

        return (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
            <div className="bg-white rounded-lg shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto p-6">
              <h2 className="text-2xl font-bold text-primary-700 mb-4">Edit Photo</h2>
              
              {/* Image Preview with modification indicators */}
              {photoUrl && (
                <div className="mb-4">
                  {croppedPreviewUrl ? (
                    <div className="relative">
                      <img src={croppedPreviewUrl} alt="Cropped preview" className="w-full max-h-64 object-contain rounded border-2 border-green-500" />
                      <span className="absolute top-2 right-2 bg-green-500 text-white text-xs px-2 py-1 rounded">Cropped</span>
                    </div>
                  ) : adjustedPreviewUrl ? (
                    <div className="relative">
                      <img src={adjustedPreviewUrl} alt="Adjusted preview" className="w-full max-h-64 object-contain rounded border-2 border-blue-500" />
                      <span className="absolute top-2 right-2 bg-blue-500 text-white text-xs px-2 py-1 rounded">Adjusted</span>
                    </div>
                  ) : (
                    <img src={photoUrl} alt={editCaption || 'Photo'} className="w-full max-h-64 object-contain rounded" />
                  )}
                </div>
              )}

              <div className="space-y-4">
                {/* Crop Accordion */}
                {photoUrl && (
                  <div className="border border-gray-200 rounded-lg overflow-hidden">
                    <button
                      type="button"
                      onClick={() => setOpenSection(openSection === 'crop' ? null : 'crop')}
                      className="w-full px-4 py-3 bg-gray-50 flex justify-between items-center hover:bg-gray-100 transition-colors"
                    >
                      <span className="font-medium text-gray-700">Crop Image</span>
                      <span className={`transform transition-transform ${openSection === 'crop' ? 'rotate-180' : ''}`}>▼</span>
                    </button>
                    {openSection === 'crop' && (
                      <div className="p-4 border-t border-gray-200">
                        {showCropInterface && cropImageUrl ? (
                          <div className="space-y-4">
                            <div className="max-h-[400px] overflow-auto bg-gray-100 rounded flex items-center justify-center">
                              <ReactCrop
                                crop={crop}
                                onChange={(_, percentCrop) => setCrop(percentCrop)}
                                onComplete={(c) => setCompletedCrop(c)}
                              >
                                <img
                                  ref={cropImgRef}
                                  src={cropImageUrl}
                                  alt="Crop"
                                  onLoad={onCropImageLoad}
                                  style={{ maxWidth: '100%', maxHeight: '400px', filter: imageFilter }}
                                  crossOrigin="anonymous"
                                />
                              </ReactCrop>
                            </div>
                            
                            {/* Adjustment sliders in crop mode */}
                            <div className="space-y-3 p-3 bg-gray-50 rounded">
                              <div>
                                <label className="block text-xs font-medium text-gray-600 mb-1">
                                  Brightness: {brightness > 0 ? '+' : ''}{brightness}%
                                </label>
                                <input
                                  type="range"
                                  min="-50"
                                  max="50"
                                  value={brightness}
                                  onChange={(e) => setBrightness(Number(e.target.value))}
                                  className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer"
                                />
                              </div>
                              <div>
                                <label className="block text-xs font-medium text-gray-600 mb-1">
                                  Contrast: {contrast > 0 ? '+' : ''}{contrast}%
                                </label>
                                <input
                                  type="range"
                                  min="-50"
                                  max="50"
                                  value={contrast}
                                  onChange={(e) => setContrast(Number(e.target.value))}
                                  className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer"
                                />
                              </div>
                              <div>
                                <label className="block text-xs font-medium text-gray-600 mb-1">
                                  Saturation: {saturation > 0 ? '+' : ''}{saturation}%
                                </label>
                                <input
                                  type="range"
                                  min="-50"
                                  max="50"
                                  value={saturation}
                                  onChange={(e) => setSaturation(Number(e.target.value))}
                                  className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer"
                                />
                              </div>
                              {hasAdjustments && (
                                <button
                                  type="button"
                                  onClick={resetEnhancements}
                                  className="text-xs text-gray-500 hover:text-gray-700"
                                >
                                  Reset adjustments
                                </button>
                              )}
                            </div>

                            <div className="flex gap-2">
                              <button
                                type="button"
                                onClick={handleDoneCropping}
                                className="px-4 py-2 bg-green-600 text-white rounded hover:bg-green-700"
                              >
                                Apply Crop
                              </button>
                              <button
                                type="button"
                                onClick={handleCancelCrop}
                                className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
                              >
                                Cancel
                              </button>
                            </div>
                            <p className="text-xs text-amber-600">Warning: Crop cannot be undone after saving.</p>
                          </div>
                        ) : (
                          <div className="text-center">
                            <p className="text-sm text-gray-600 mb-3">Crop the image to remove unwanted areas.</p>
                            <button
                              type="button"
                              onClick={() => handleStartCrop(photoUrl)}
                              className="px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700"
                            >
                              Start Cropping
                            </button>
                          </div>
                        )}
                      </div>
                    )}
                  </div>
                )}

                {/* Adjust Accordion (only show if not cropping) */}
                {photoUrl && !showCropInterface && !croppedBlob && (
                  <div className="border border-gray-200 rounded-lg overflow-hidden">
                    <button
                      type="button"
                      onClick={() => setOpenSection(openSection === 'adjust' ? null : 'adjust')}
                      className="w-full px-4 py-3 bg-gray-50 flex justify-between items-center hover:bg-gray-100 transition-colors"
                    >
                      <span className="font-medium text-gray-700">Adjust Image</span>
                      <span className={`transform transition-transform ${openSection === 'adjust' ? 'rotate-180' : ''}`}>▼</span>
                    </button>
                    {openSection === 'adjust' && (
                      <div className="p-4 border-t border-gray-200">
                        <div className="mb-4">
                          <img
                            src={photoUrl}
                            alt="Preview"
                            style={{ filter: imageFilter }}
                            className="w-full max-h-48 object-contain rounded"
                            crossOrigin="anonymous"
                          />
                        </div>
                        <div className="space-y-3">
                          <div>
                            <label className="block text-xs font-medium text-gray-600 mb-1">
                              Brightness: {brightness > 0 ? '+' : ''}{brightness}%
                            </label>
                            <input
                              type="range"
                              min="-50"
                              max="50"
                              value={brightness}
                              onChange={(e) => setBrightness(Number(e.target.value))}
                              className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer"
                            />
                          </div>
                          <div>
                            <label className="block text-xs font-medium text-gray-600 mb-1">
                              Contrast: {contrast > 0 ? '+' : ''}{contrast}%
                            </label>
                            <input
                              type="range"
                              min="-50"
                              max="50"
                              value={contrast}
                              onChange={(e) => setContrast(Number(e.target.value))}
                              className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer"
                            />
                          </div>
                          <div>
                            <label className="block text-xs font-medium text-gray-600 mb-1">
                              Saturation: {saturation > 0 ? '+' : ''}{saturation}%
                            </label>
                            <input
                              type="range"
                              min="-50"
                              max="50"
                              value={saturation}
                              onChange={(e) => setSaturation(Number(e.target.value))}
                              className="w-full h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer"
                            />
                          </div>
                        </div>
                        <div className="flex gap-2 mt-4">
                          <button
                            type="button"
                            onClick={() => applyAdjustments(photoUrl)}
                            disabled={!hasAdjustments}
                            className="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 disabled:opacity-50"
                          >
                            Apply Adjustments
                          </button>
                          <button
                            type="button"
                            onClick={resetEnhancements}
                            disabled={!hasAdjustments}
                            className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50 disabled:opacity-50"
                          >
                            Reset
                          </button>
                        </div>
                      </div>
                    )}
                  </div>
                )}

                {/* Focal Point Accordion */}
                {photoUrl && !showCropInterface && (
                  <div className="border border-gray-200 rounded-lg overflow-hidden">
                    <button
                      type="button"
                      onClick={() => setOpenSection(openSection === 'focal' ? null : 'focal')}
                      className="w-full px-4 py-3 bg-gray-50 flex justify-between items-center hover:bg-gray-100 transition-colors"
                    >
                      <span className="font-medium text-gray-700">Preview Focus Point</span>
                      <span className={`transform transition-transform ${openSection === 'focal' ? 'rotate-180' : ''}`}>▼</span>
                    </button>
                    {openSection === 'focal' && (
                      <div className="p-4 border-t border-gray-200">
                        <p className="text-sm text-gray-600 mb-3">
                          Click on the image to set where the preview should focus (e.g., click on faces).
                        </p>
                        <div 
                          ref={focalPointRef}
                          className="relative cursor-crosshair border border-gray-300 rounded overflow-hidden"
                          onClick={(e) => {
                            const rect = e.currentTarget.getBoundingClientRect()
                            const x = ((e.clientX - rect.left) / rect.width) * 100
                            const y = ((e.clientY - rect.top) / rect.height) * 100
                            setFocalPointX(Math.round(x))
                            setFocalPointY(Math.round(y))
                          }}
                        >
                          <img
                            src={photoUrl}
                            alt="Set focal point"
                            className="w-full max-h-64 object-contain"
                            draggable={false}
                          />
                          {/* Focal point marker */}
                          <div
                            className="absolute w-8 h-8 border-2 border-red-500 rounded-full transform -translate-x-1/2 -translate-y-1/2 pointer-events-none"
                            style={{
                              left: `${focalPointX}%`,
                              top: `${focalPointY}%`,
                              boxShadow: '0 0 0 2px white, 0 0 8px rgba(0,0,0,0.5)',
                            }}
                          >
                            <div className="absolute inset-0 flex items-center justify-center">
                              <div className="w-2 h-2 bg-red-500 rounded-full" />
                            </div>
                          </div>
                        </div>
                        <div className="mt-3 flex items-center justify-between">
                          <span className="text-xs text-gray-500">
                            Position: {focalPointX}% from left, {focalPointY}% from top
                          </span>
                          <button
                            type="button"
                            onClick={() => { setFocalPointX(50); setFocalPointY(50) }}
                            className="text-xs text-primary-600 hover:text-primary-700"
                          >
                            Reset to center
                          </button>
                        </div>
                        {/* Preview of how it will look in card */}
                        <div className="mt-4">
                          <p className="text-xs text-gray-500 mb-2">Preview (how it appears in the grid):</p>
                          <div className="w-32 h-24 overflow-hidden rounded border border-gray-300 mx-auto">
                            <img
                              src={photoUrl}
                              alt="Preview"
                              className="w-full h-full object-cover"
                              style={{ objectPosition: `${focalPointX}% ${focalPointY}%` }}
                            />
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                )}
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Caption <span className="text-red-500">*</span>
                  </label>
                  <input
                    type="text"
                    value={editCaption}
                    onChange={(e) => setEditCaption(e.target.value)}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                    disabled={processing === editingPhoto}
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Approximate Date <span className="text-gray-400 text-xs">(optional)</span>
                  </label>
                  <input
                    type="text"
                    value={editDate}
                    onChange={(e) => setEditDate(e.target.value)}
                    placeholder="e.g., 1985 or Spring 1990"
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                    disabled={processing === editingPhoto}
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Event/Context <span className="text-gray-400 text-xs">(optional)</span>
                  </label>
                  <input
                    type="text"
                    value={editEvent}
                    onChange={(e) => setEditEvent(e.target.value)}
                    placeholder="e.g., Ward Christmas Party"
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                    disabled={processing === editingPhoto}
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Tagged People <span className="text-gray-400 text-xs">(optional)</span>
                  </label>
                  <p className="text-xs text-gray-500 mb-3">
                    Search for people in the database or add names manually.
                  </p>
                  {(editTaggedPeople.length > 0 || editAdditionalPeople.length > 0) && (
                    <div className="flex flex-wrap gap-2 mb-3">
                      {editTaggedPeople.map(taggedPerson => (
                        <span
                          key={taggedPerson.id}
                          className="inline-flex items-center gap-1 px-3 py-1 bg-primary-100 text-primary-800 rounded-full text-sm"
                        >
                          {taggedPerson.display_name || taggedPerson.full_name}
                          <button
                            type="button"
                            onClick={() => handleRemoveTaggedPerson(taggedPerson.id)}
                            disabled={processing === editingPhoto}
                            className="hover:text-primary-900 disabled:opacity-50"
                          >
                            ×
                          </button>
                        </span>
                      ))}
                      {editAdditionalPeople.map((name, idx) => (
                        <span
                          key={`additional-${idx}`}
                          className="inline-flex items-center gap-1 px-3 py-1 bg-primary-100 text-primary-800 rounded-full text-sm"
                        >
                          {name}
                          <button
                            type="button"
                            onClick={() => handleRemoveAdditionalPerson(name)}
                            disabled={processing === editingPhoto}
                            className="hover:text-primary-900 disabled:opacity-50"
                          >
                            ×
                          </button>
                        </span>
                      ))}
                    </div>
                  )}

                  <div ref={tagSearchRef} className="relative">
                    <input
                      type="text"
                      value={tagSearchTerm}
                      onChange={(e) => {
                        setTagSearchTerm(e.target.value)
                        setShowTagDropdown(true)
                      }}
                      onFocus={() => tagSearchTerm.length >= 2 && setShowTagDropdown(true)}
                      placeholder="Search for a person or type a name..."
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={processing === editingPhoto}
                    />
                    {showTagDropdown && tagSearchTerm.length >= 2 && (
                      <div className="absolute z-10 w-full mt-1 bg-white border border-gray-300 rounded-lg shadow-lg max-h-60 overflow-y-auto">
                        {tagSearchLoading ? (
                          <div className="px-4 py-2 text-sm text-gray-500">Searching...</div>
                        ) : (
                          <>
                            {tagSearchResults
                              .filter(searchPerson => !editTaggedPeople.find(p => p.id === searchPerson.id))
                              .slice(0, 10)
                              .map((searchPerson) => (
                                <button
                                  key={searchPerson.id}
                                  type="button"
                                  onClick={() => handleAddTaggedPerson(searchPerson)}
                                  className="w-full text-left px-4 py-2 hover:bg-gray-100 text-sm border-b border-gray-100 last:border-0"
                                >
                                  {searchPerson.display_name || searchPerson.full_name}
                                </button>
                              ))}
                            {tagSearchTerm.trim() && (
                              <>
                                {tagSearchResults.length > 0 && (
                                  <div className="border-t border-gray-200"></div>
                                )}
                                <button
                                  type="button"
                                  onClick={() => handleAddAdditionalPerson(tagSearchTerm)}
                                  className="w-full text-left px-4 py-2 hover:bg-gray-100 text-sm text-primary-600 font-medium"
                                >
                                  + Add "{tagSearchTerm.trim()}"
                                </button>
                              </>
                            )}
                          </>
                        )}
                      </div>
                    )}
                  </div>
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Submitter Name
                  </label>
                  <input
                    type="text"
                    value={editSubmitterName}
                    onChange={(e) => setEditSubmitterName(e.target.value)}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                    disabled={processing === editingPhoto}
                  />
                </div>

                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-1">
                    Submitter Email
                  </label>
                  <input
                    type="email"
                    value={editSubmitterEmail}
                    onChange={(e) => setEditSubmitterEmail(e.target.value)}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                    disabled={processing === editingPhoto}
                  />
                </div>
              </div>

              <div className="flex gap-3 justify-end mt-6">
                <button
                  onClick={handleCancelEdit}
                  disabled={processing === editingPhoto}
                  className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50"
                >
                  Cancel
                </button>
                <button
                  onClick={handleSaveEdit}
                  disabled={processing === editingPhoto || !editCaption.trim()}
                  className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed"
                >
                  {processing === editingPhoto ? 'Saving...' : 'Save Changes'}
                </button>
              </div>
            </div>
          </div>
        )
      })()}

      {photos.map((photo) => {
        const deleteState = deleteConfirmState[photo.id]
        if (deleteState === 'modal') {
          return (
            <div
              key={`delete-modal-${photo.id}`}
              className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4"
            >
              <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
                <h2 className="text-xl font-bold text-red-700 mb-4 flex items-center gap-2">
                  <span>⚠️</span> Delete Photo
                </h2>
                <p className="text-gray-700 mb-4">
                  This action CANNOT be undone.
                </p>
                <p className="text-gray-700 mb-4">
                  The photo and all associated data (tags, captions) will be permanently deleted. The image file will be lost.
                </p>
                <div className="mb-4">
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Type <strong>DELETE</strong> to confirm:
                  </label>
                  <input
                    type="text"
                    value={deleteConfirmText[photo.id] || ''}
                    onChange={(e) =>
                      setDeleteConfirmText({ ...deleteConfirmText, [photo.id]: e.target.value })
                    }
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500"
                    placeholder="DELETE"
                    autoFocus
                  />
                </div>
                <div className="flex gap-2 justify-end">
                  <button
                    onClick={() => handleDeleteCancel(photo.id)}
                    className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
                  >
                    Cancel
                  </button>
                  <button
                    onClick={() => handleDeleteConfirm(photo.id)}
                    disabled={
                      processing === photo.id ||
                      (deleteConfirmText[photo.id] || '').toUpperCase() !== 'DELETE'
                    }
                    className="px-4 py-2 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50 disabled:cursor-not-allowed"
                  >
                    Delete Forever
                  </button>
                </div>
              </div>
            </div>
          )
        }
        return null
      })}
    </div>
  )
}

