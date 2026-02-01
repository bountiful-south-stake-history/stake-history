import { useState, useRef, useEffect, useMemo, useCallback } from 'react'
import { Link } from 'react-router-dom'
import ReactCrop, { type Crop, centerCrop, makeAspectCrop } from 'react-image-crop'
import 'react-image-crop/dist/ReactCrop.css'
import { supabase } from '../../lib/supabase'
import { usePendingPortraits } from '../../hooks/usePendingPortraits'
import { useApprovedPortraits } from '../../hooks/useApprovedPortraits'
import { usePeopleSearch } from '../../hooks/usePeopleSearch'
import { useAuth } from '../../hooks/useAuth'
import type { Person } from '../../lib/types'
import compressImage from 'browser-image-compression'
import { PortraitLightbox } from '../people/PortraitLightbox'

const ASPECT_RATIO = 4 / 5

interface AdminPortraitsTabProps {
  onActionComplete?: () => void
}

export function AdminPortraitsTab({ onActionComplete }: AdminPortraitsTabProps) {
  const { user } = useAuth()
  const [viewMode, setViewMode] = useState<'pending' | 'approved'>('pending')
  const { portraits: pendingPortraits, loading: pendingLoading, error: pendingError, refetch: refetchPending } = usePendingPortraits()
  const { portraits: approvedPortraits, loading: approvedLoading, error: approvedError, refetch: refetchApproved } = useApprovedPortraits()
  const [processing, setProcessing] = useState<string | null>(null)
  const [showRejectModal, setShowRejectModal] = useState<{ id: string; name: string } | null>(null)
  const [rejectionReason, setRejectionReason] = useState('')
  const [editingPortrait, setEditingPortrait] = useState<string | null>(null)
  const [editPerson, setEditPerson] = useState<Person | null>(null)
  const [editPersonSearchTerm, setEditPersonSearchTerm] = useState('')
  const [showPersonDropdown, setShowPersonDropdown] = useState(false)
  const [newPortraitFile, setNewPortraitFile] = useState<File | null>(null)
  const [newPortraitPreview, setNewPortraitPreview] = useState<string | null>(null)
  const personSearchRef = useRef<HTMLDivElement>(null)
  const [deleteConfirmState, setDeleteConfirmState] = useState<Record<string, 'none' | 'warning' | 'modal'>>({})
  const [deleteConfirmText, setDeleteConfirmText] = useState<Record<string, string>>({})
  const [deleteTimeoutId, setDeleteTimeoutId] = useState<Record<string, NodeJS.Timeout>>({})
  const [lightboxImage, setLightboxImage] = useState<{ url: string; personName: string } | null>(null)
  const [searchQuery, setSearchQuery] = useState('')
  const [debouncedSearchQuery, setDebouncedSearchQuery] = useState('')
  const [sortOption, setSortOption] = useState<'approved-desc' | 'approved-asc' | 'name-asc' | 'name-desc'>('approved-desc')
  
  // Crop-related state
  const [showCropInterface, setShowCropInterface] = useState(false)
  const [crop, setCrop] = useState<Crop>()
  const [completedCrop, setCompletedCrop] = useState<Crop>()
  const cropImgRef = useRef<HTMLImageElement>(null)
  const [cropImageUrl, setCropImageUrl] = useState<string | null>(null)
  const [croppedPreviewUrl, setCroppedPreviewUrl] = useState<string | null>(null)
  const [croppedBlob, setCroppedBlob] = useState<Blob | null>(null)
  
  // Image enhancement state
  const [showGuide, setShowGuide] = useState(true)
  const [brightness, setBrightness] = useState(0)
  const [contrast, setContrast] = useState(0)
  const [saturation, setSaturation] = useState(0)
  
  // Computed CSS filter for real-time preview
  const imageFilter = `brightness(${1 + brightness / 100}) contrast(${1 + contrast / 100}) saturate(${1 + saturation / 100})`
  const hasAdjustments = brightness !== 0 || contrast !== 0 || saturation !== 0

  const loading = viewMode === 'pending' ? pendingLoading : approvedLoading
  const error = viewMode === 'pending' ? pendingError : approvedError
  const { people: personSearchResults, loading: personSearchLoading } = usePeopleSearch(editPersonSearchTerm)

  useEffect(() => {
    const timer = setTimeout(() => {
      setDebouncedSearchQuery(searchQuery)
    }, 300)
    return () => clearTimeout(timer)
  }, [searchQuery])

  const filteredAndSortedPortraits = useMemo(() => {
    let result = [...approvedPortraits]

    if (debouncedSearchQuery) {
      result = result.filter((portrait) => {
        const personName = (portrait.person.display_name || portrait.person.full_name || '').toLowerCase()
        return personName.includes(debouncedSearchQuery.toLowerCase())
      })
    }

    switch (sortOption) {
      case 'approved-desc':
        result.sort((a, b) => {
          const dateA = a.portrait_approved_at ? new Date(a.portrait_approved_at).getTime() : 0
          const dateB = b.portrait_approved_at ? new Date(b.portrait_approved_at).getTime() : 0
          return dateB - dateA
        })
        break
      case 'approved-asc':
        result.sort((a, b) => {
          const dateA = a.portrait_approved_at ? new Date(a.portrait_approved_at).getTime() : 0
          const dateB = b.portrait_approved_at ? new Date(b.portrait_approved_at).getTime() : 0
          return dateA - dateB
        })
        break
      case 'name-asc':
        result.sort((a, b) => {
          const nameA = (a.person.display_name || a.person.full_name || '').toLowerCase()
          const nameB = (b.person.display_name || b.person.full_name || '').toLowerCase()
          return nameA.localeCompare(nameB)
        })
        break
      case 'name-desc':
        result.sort((a, b) => {
          const nameA = (a.person.display_name || a.person.full_name || '').toLowerCase()
          const nameB = (b.person.display_name || b.person.full_name || '').toLowerCase()
          return nameB.localeCompare(nameA)
        })
        break
    }

    return result
  }, [approvedPortraits, debouncedSearchQuery, sortOption])

  const refetch = () => {
    if (viewMode === 'pending') {
      refetchPending()
    } else {
      refetchApproved()
    }
  }

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (personSearchRef.current && !personSearchRef.current.contains(event.target as Node)) {
        setShowPersonDropdown(false)
      }
    }
    document.addEventListener('mousedown', handleClickOutside)
    return () => document.removeEventListener('mousedown', handleClickOutside)
  }, [])

  useEffect(() => {
    if (editPersonSearchTerm) {
      setShowPersonDropdown(true)
    }
  }, [editPersonSearchTerm, personSearchResults])

  // Reset crop and enhancement state when editing changes
  useEffect(() => {
    if (!editingPortrait) {
      setShowCropInterface(false)
      setCrop(undefined)
      setCompletedCrop(undefined)
      setCropImageUrl(null)
      setCroppedPreviewUrl(null)
      setCroppedBlob(null)
      // Reset enhancement sliders
      setBrightness(0)
      setContrast(0)
      setSaturation(0)
      setShowGuide(true)
    }
  }, [editingPortrait])

  const onCropImageLoad = useCallback((e: React.SyntheticEvent<HTMLImageElement>) => {
    const { naturalWidth, naturalHeight } = e.currentTarget
    const initialCrop = centerCrop(
      makeAspectCrop(
        {
          unit: '%',
          width: 90,
        },
        ASPECT_RATIO,
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
      // Pixel-based crop - need to scale from displayed size to natural size
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
    
    // Apply image filters if provided
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
    
    // Preview size (4:5 aspect ratio)
    canvas.width = 160
    canvas.height = 200
    
    ctx.imageSmoothingQuality = 'high'
    
    // Apply image filters if provided
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
      160,
      200
    )
    
    return canvas.toDataURL('image/jpeg', 0.9)
  }, [completedCrop])

  const handleStartCrop = (portraitUrl: string) => {
    setCropImageUrl(portraitUrl)
    setShowCropInterface(true)
    setCrop(undefined)
    setCompletedCrop(undefined)
    setCroppedPreviewUrl(null)
    setCroppedBlob(null)
    // Reset enhancement sliders when starting new crop
    setBrightness(0)
    setContrast(0)
    setSaturation(0)
    setShowGuide(true)
  }
  
  const resetEnhancements = () => {
    setBrightness(0)
    setContrast(0)
    setSaturation(0)
  }

  const handleDoneCropping = async () => {
    // Generate preview for display (with filters applied)
    const preview = await generateCroppedPreview(imageFilter)
    if (preview) {
      setCroppedPreviewUrl(preview)
    }
    
    // Store the cropped blob for upload (with filters applied)
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
    setCroppedPreviewUrl(null)
    setCroppedBlob(null)
  }

  const handleApprove = async (submissionId: string) => {
    setProcessing(submissionId)
    try {
      const submission = pendingPortraits.find((p) => p.id === submissionId)
      if (!submission) throw new Error('Portrait submission not found')

      const personId = submission.person_id
      const oldPath = submission.portrait_url
      const filename = oldPath.split('/').pop() || `${personId}.jpg`
      const newPath = `portraits/approved/${personId}/${filename}`

      const { data: fileData, error: downloadError } = await supabase.storage
        .from('portraits')
        .download(oldPath)

      if (downloadError) throw downloadError

      const { error: uploadError } = await supabase.storage
        .from('portraits')
        .upload(newPath, fileData, { upsert: true })

      if (uploadError) throw uploadError

      const { error: deleteError } = await supabase.storage.from('portraits').remove([oldPath])
      if (deleteError) console.error('Failed to delete old file:', deleteError)

      const {
        data: { publicUrl },
      } = supabase.storage.from('portraits').getPublicUrl(newPath)

      const { data: { user } } = await supabase.auth.getUser()
      const reviewedBy = user?.id || null

      const { error: updatePeopleError } = await supabase
        .from('people')
        .update({
          portrait_url: publicUrl,
          portrait_pending: false,
          portrait_approved_at: new Date().toISOString(),
        })
        .eq('id', personId)

      if (updatePeopleError) throw updatePeopleError

      const { error: updateSubmissionError } = await supabase
        .from('portrait_submissions')
        .update({
          status: 'approved',
          reviewed_at: new Date().toISOString(),
          reviewed_by: reviewedBy,
        })
        .eq('id', submissionId)

      if (updateSubmissionError) throw updateSubmissionError

      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to approve portrait')
    } finally {
      setProcessing(null)
    }
  }

  const handleReject = async () => {
    if (!showRejectModal) return

    setProcessing(showRejectModal.id)
    try {
      const submission = pendingPortraits.find((p) => p.id === showRejectModal.id)
      if (!submission) throw new Error('Portrait submission not found')
      
      await supabase.storage.from('portraits').remove([submission.portrait_url])

      const { data: { user } } = await supabase.auth.getUser()
      const reviewedBy = user?.id || null

      const { error: updateSubmissionError } = await supabase
        .from('portrait_submissions')
        .update({
          status: 'rejected',
          reviewed_at: new Date().toISOString(),
          reviewed_by: reviewedBy,
          rejection_reason: rejectionReason || null,
        })
        .eq('id', showRejectModal.id)

      if (updateSubmissionError) throw updateSubmissionError

      setShowRejectModal(null)
      setRejectionReason('')
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to reject portrait')
    } finally {
      setProcessing(null)
    }
  }

  const handleStartEdit = (personId: string) => {
    const portrait = approvedPortraits.find((p) => p.person.id === personId)
    if (!portrait) return

    setEditingPortrait(personId)
    setEditPerson(portrait.person)
    setEditPersonSearchTerm('')
    setNewPortraitFile(null)
    setNewPortraitPreview(null)
  }

  const handleCancelEdit = () => {
    setEditingPortrait(null)
    setEditPerson(null)
    setEditPersonSearchTerm('')
    setNewPortraitFile(null)
    setNewPortraitPreview(null)
  }

  const handlePortraitFileChange = async (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return

    if (!file.type.match(/^image\/(jpeg|jpg|png|webp|heic)$/i)) {
      alert('Please select a valid image file (JPEG, PNG, WebP, or HEIC)')
      return
    }

    try {
      const compressedFile = await compressImage(file, {
        maxSizeMB: 2,
        maxWidthOrHeight: 1920,
        useWebWorker: true,
      })

      setNewPortraitFile(compressedFile)
      const reader = new FileReader()
      reader.onloadend = () => {
        setNewPortraitPreview(reader.result as string)
      }
      reader.readAsDataURL(compressedFile)
    } catch (err) {
      alert('Failed to process image. Please try again.')
    }
  }

  const handleSaveEdit = async () => {
    if (!editingPortrait || !editPerson) return

    setProcessing(editingPortrait)
    try {
      const portrait = approvedPortraits.find((p) => p.person.id === editingPortrait)
      if (!portrait) throw new Error('Portrait not found')

      let newPortraitUrl = portrait.portrait_url
      const oldPortraitUrl = portrait.portrait_url
      let fileToUpload: Blob | File | null = newPortraitFile

      // If crop was adjusted, use the stored cropped blob
      if (croppedBlob && !newPortraitFile) {
        // Compress the cropped image
        const croppedFile = new File([croppedBlob], 'cropped.jpg', { type: 'image/jpeg' })
        fileToUpload = await compressImage(croppedFile, {
          maxSizeMB: 0.5,
          maxWidthOrHeight: 800,
          useWebWorker: true,
        })
      }

      if (fileToUpload) {
        const personId = editPerson.id
        const timestamp = Date.now()
        const newPath = `portraits/approved/${personId}/${personId}_${timestamp}.jpg`

        const { error: uploadError } = await supabase.storage
          .from('portraits')
          .upload(newPath, fileToUpload, { upsert: true })

        if (uploadError) throw uploadError

        const {
          data: { publicUrl },
        } = supabase.storage.from('portraits').getPublicUrl(newPath)

        newPortraitUrl = publicUrl

        // Extract storage path from old URL and delete old file
        const urlParts = oldPortraitUrl.split('/storage/v1/object/public/portraits/')
        if (urlParts.length > 1) {
          const oldPath = urlParts[1]
          await supabase.storage.from('portraits').remove([oldPath])
        }
      }

      const oldPersonId = portrait.person.id
      const newPersonId = editPerson.id

      if (oldPersonId !== newPersonId) {
        const { error: updateOldPersonError } = await supabase
          .from('people')
          .update({
            portrait_url: null,
            portrait_pending: false,
          })
          .eq('id', oldPersonId)

        if (updateOldPersonError) throw updateOldPersonError
      }

      const { error: updateNewPersonError } = await supabase
        .from('people')
        .update({
          portrait_url: newPortraitUrl,
          portrait_pending: false,
        })
        .eq('id', newPersonId)

      if (updateNewPersonError) throw updateNewPersonError

      if (user) {
        await supabase.from('audit_log').insert({
          table_name: 'people',
          record_id: newPersonId,
          action: 'edit_portrait',
          old_values: {
            person_id: oldPersonId,
            portrait_url: oldPortraitUrl,
          },
          new_values: {
            person_id: newPersonId,
            portrait_url: newPortraitUrl,
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

  const handleDeleteClick = (personId: string) => {
    const currentState = deleteConfirmState[personId] || 'none'
    
    if (currentState === 'none') {
      const timeoutId = setTimeout(() => {
        setDeleteConfirmState({ ...deleteConfirmState, [personId]: 'none' })
        setDeleteTimeoutId((prev) => {
          const newState = { ...prev }
          delete newState[personId]
          return newState
        })
      }, 3000)
      
      setDeleteTimeoutId({ ...deleteTimeoutId, [personId]: timeoutId })
      setDeleteConfirmState({ ...deleteConfirmState, [personId]: 'warning' })
    } else if (currentState === 'warning') {
      if (deleteTimeoutId[personId]) {
        clearTimeout(deleteTimeoutId[personId])
      }
      setDeleteConfirmState({ ...deleteConfirmState, [personId]: 'modal' })
      setDeleteConfirmText({ ...deleteConfirmText, [personId]: '' })
    }
  }

  const handleDeleteCancel = (personId: string) => {
    if (deleteTimeoutId[personId]) {
      clearTimeout(deleteTimeoutId[personId])
    }
    setDeleteConfirmState({ ...deleteConfirmState, [personId]: 'none' })
    setDeleteConfirmText({ ...deleteConfirmText, [personId]: '' })
    setDeleteTimeoutId((prev) => {
      const newState = { ...prev }
      delete newState[personId]
      return newState
    })
  }

  const handleDeleteConfirm = async (personId: string) => {
    const portrait = approvedPortraits.find((p) => p.person.id === personId)
    if (!portrait) return

    setProcessing(personId)
    try {
      const portraitUrl = portrait.portrait_url
      const storagePath = portraitUrl.split('/').slice(-2).join('/')
      
      if (storagePath.startsWith('portraits/approved/')) {
        await supabase.storage.from('portraits').remove([storagePath])
      }

      const { error: updateError } = await supabase
        .from('people')
        .update({
          portrait_url: null,
          portrait_pending: false,
        })
        .eq('id', personId)

      if (updateError) throw updateError

      if (user) {
        await supabase.from('audit_log').insert({
          table_name: 'people',
          record_id: personId,
          action: 'delete_portrait',
          old_values: {
            portrait_url: portraitUrl,
          },
          new_values: null,
          performed_by: user.id,
          performed_at: new Date().toISOString(),
        })
      }

      setDeleteConfirmState({ ...deleteConfirmState, [personId]: 'none' })
      setDeleteConfirmText({ ...deleteConfirmText, [personId]: '' })
      refetch()
      onActionComplete?.()
    } catch (err) {
      alert(err instanceof Error ? err.message : 'Failed to delete portrait')
    } finally {
      setProcessing(null)
    }
  }

  if (loading) {
    return <div className="text-center py-8 text-gray-600">Loading portraits...</div>
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
          Pending ({pendingPortraits.length})
        </button>
        <button
          onClick={() => setViewMode('approved')}
          className={`px-4 py-2 font-medium border-b-2 transition-colors ${
            viewMode === 'approved'
              ? 'border-primary-600 text-primary-700'
              : 'border-transparent text-gray-500 hover:text-gray-700'
          }`}
        >
          Approved ({approvedPortraits.length})
        </button>
      </div>

      {viewMode === 'pending' && (
        <>
          {pendingPortraits.length === 0 ? (
            <div className="text-center py-8 text-gray-600">No pending portraits</div>
          ) : (
            <>
              {/* Mobile Card Layout */}
              <div className="grid gap-4 md:hidden">
                {pendingPortraits.map((submission) => {
                  const person = submission.person
                  const personName = person?.display_name || person?.full_name || 'Unknown Person'
                  const personId = submission.person_id
                  
                  const {
                    data: { publicUrl: pendingPortraitUrl },
                  } = supabase.storage.from('portraits').getPublicUrl(submission.portrait_url)
                  
                  return (
                    <div key={submission.id} className="bg-white border border-gray-200 rounded-lg p-4">
                      <div className="flex flex-col gap-4">
                        <img
                          src={pendingPortraitUrl}
                          alt={personName}
                          className="w-full h-48 object-cover rounded cursor-pointer hover:opacity-80 transition-opacity"
                          onClick={() => setLightboxImage({ url: pendingPortraitUrl, personName })}
                          onError={(e) => {
                            if (person?.portrait_url) {
                              (e.target as HTMLImageElement).src = person.portrait_url
                            }
                          }}
                        />
                        <div className="space-y-2">
                          <div>
                            <span className="text-xs text-gray-500">Name:</span>{' '}
                            <Link
                              to={`/person/${personId}`}
                              className="text-primary-600 hover:text-primary-700 hover:underline font-medium"
                            >
                              {personName}
                            </Link>
                          </div>
                          <div>
                            <span className="text-xs text-gray-500">Submitted:</span>{' '}
                            <span className="text-sm text-gray-900">
                              {submission.submitted_at
                                ? new Date(submission.submitted_at).toLocaleDateString()
                                : '-'}
                            </span>
                          </div>
                          <div>
                            <span className="text-xs text-gray-500">By:</span>{' '}
                            <span className="text-sm text-gray-900">{submission.submitter_name}</span>
                          </div>
                          <div>
                            <span className="text-xs text-gray-500">Email:</span>{' '}
                            <span className="text-sm text-gray-600">{submission.submitter_email}</span>
                          </div>
                          {submission.submitter_phone && (
                            <div>
                              <span className="text-xs text-gray-500">Phone:</span>{' '}
                              <span className="text-sm text-gray-600">{submission.submitter_phone}</span>
                            </div>
                          )}
                        </div>
                        <div className="flex gap-2 pt-2 border-t border-gray-200">
                          <button
                            onClick={() => handleApprove(submission.id)}
                            disabled={processing === submission.id}
                            className="flex-1 px-3 py-2 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm font-medium"
                          >
                            Approve
                          </button>
                          <button
                            onClick={() =>
                              setShowRejectModal({
                                id: submission.id,
                                name: personName,
                              })
                            }
                            disabled={processing === submission.id}
                            className="flex-1 px-3 py-2 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50 text-sm font-medium"
                          >
                            Reject
                          </button>
                        </div>
                      </div>
                    </div>
                  )
                })}
              </div>

              {/* Desktop Table Layout */}
              <div className="hidden md:block overflow-x-auto">
                <table className="min-w-full bg-white border border-gray-200">
                  <thead className="bg-gray-50">
                    <tr>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Portrait</th>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Person Name</th>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Submitted By</th>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Email</th>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Phone</th>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Date</th>
                      <th className="px-4 py-3 text-left text-xs font-medium text-gray-500 uppercase">Actions</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-gray-200">
                    {pendingPortraits.map((submission) => {
                      const person = submission.person
                      const personName = person?.display_name || person?.full_name || 'Unknown Person'
                      const personId = submission.person_id
                      
                      const {
                        data: { publicUrl: pendingPortraitUrl },
                      } = supabase.storage.from('portraits').getPublicUrl(submission.portrait_url)
                      
                      return (
                        <tr key={submission.id} className="hover:bg-gray-50">
                          <td className="px-4 py-3">
                            <img
                              src={pendingPortraitUrl}
                              alt={personName}
                              className="w-20 h-[100px] object-cover rounded cursor-pointer hover:opacity-80 transition-opacity"
                              onClick={() => setLightboxImage({ url: pendingPortraitUrl, personName })}
                              onError={(e) => {
                                if (person?.portrait_url) {
                                  (e.target as HTMLImageElement).src = person.portrait_url
                                }
                              }}
                            />
                          </td>
                          <td className="px-4 py-3">
                            <Link
                              to={`/person/${personId}`}
                              className="text-primary-600 hover:text-primary-700 hover:underline"
                            >
                              {personName}
                            </Link>
                          </td>
                          <td className="px-4 py-3 text-sm text-gray-900">{submission.submitter_name}</td>
                          <td className="px-4 py-3 text-sm text-gray-600">{submission.submitter_email}</td>
                          <td className="px-4 py-3 text-sm text-gray-600">{submission.submitter_phone || '-'}</td>
                          <td className="px-4 py-3 text-sm text-gray-600">
                            {submission.submitted_at
                              ? new Date(submission.submitted_at).toLocaleDateString()
                              : '-'}
                          </td>
                          <td className="px-4 py-3">
                            <div className="flex gap-2">
                              <button
                                onClick={() => handleApprove(submission.id)}
                                disabled={processing === submission.id}
                                className="px-3 py-1 bg-green-600 text-white rounded hover:bg-green-700 disabled:opacity-50 text-sm"
                              >
                                Approve
                              </button>
                              <button
                                onClick={() =>
                                  setShowRejectModal({
                                    id: submission.id,
                                    name: personName,
                                  })
                                }
                                disabled={processing === submission.id}
                                className="px-3 py-1 bg-red-600 text-white rounded hover:bg-red-700 disabled:opacity-50 text-sm"
                              >
                                Reject
                              </button>
                            </div>
                          </td>
                        </tr>
                      )
                    })}
                  </tbody>
                </table>
              </div>
            </>
          )}
        </>
      )}

      {viewMode === 'approved' && (
        <>
          {approvedPortraits.length === 0 ? (
            <div className="text-center py-8 text-gray-600">No approved portraits</div>
          ) : (
            <>
              <div className="bg-white border border-gray-200 rounded-lg p-4 mb-4">
                <div className="flex flex-col md:flex-row md:items-center md:justify-between gap-4">
                  <div className="flex-1 relative">
                    <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                      <svg className="h-5 w-5 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                        <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
                      </svg>
                    </div>
                    <input
                      type="text"
                      value={searchQuery}
                      onChange={(e) => setSearchQuery(e.target.value)}
                      placeholder="Search by name..."
                      className="w-full pl-10 pr-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                    />
                  </div>
                  <div className="flex items-center gap-2">
                    <label htmlFor="sort-select" className="text-sm font-medium text-gray-700 whitespace-nowrap">
                      Sort:
                    </label>
                    <select
                      id="sort-select"
                      value={sortOption}
                      onChange={(e) => setSortOption(e.target.value as typeof sortOption)}
                      className="px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 focus:border-transparent text-sm"
                    >
                      <option value="approved-desc">Approved Date (Newest)</option>
                      <option value="approved-asc">Approved Date (Oldest)</option>
                      <option value="name-asc">Name (A-Z)</option>
                      <option value="name-desc">Name (Z-A)</option>
                    </select>
                  </div>
                </div>
                {debouncedSearchQuery && (
                  <div className="mt-3 text-sm text-gray-600">
                    Showing {filteredAndSortedPortraits.length} of {approvedPortraits.length} portraits
                  </div>
                )}
              </div>
              <div className="grid gap-4">
                {filteredAndSortedPortraits.length === 0 ? (
                  <div className="text-center py-8 text-gray-600">No portraits match your search</div>
                ) : (
                  filteredAndSortedPortraits.map((portrait) => {
                const isEditing = editingPortrait === portrait.person.id
                const personName = portrait.person.display_name || portrait.person.full_name

                if (isEditing) {
                  return (
                    <div key={portrait.person.id} className="bg-white border border-gray-200 rounded-lg p-6">
                      <h3 className="text-lg font-semibold text-gray-900 mb-4">Edit Portrait</h3>
                      
                      <div className="mb-4">
                        <label className="block text-sm font-medium text-gray-700 mb-2">
                          Current Portrait
                        </label>
                        
                        {showCropInterface && cropImageUrl ? (
                          <div className="space-y-4">
                            {/* Crop area with silhouette guide */}
                            <div className="border border-gray-300 rounded-lg p-2 bg-gray-50 relative">
                              <ReactCrop
                                crop={crop}
                                onChange={(_, percentCrop) => setCrop(percentCrop)}
                                onComplete={(_, percentCrop) => setCompletedCrop(percentCrop)}
                                aspect={ASPECT_RATIO}
                                minWidth={50}
                                minHeight={62}
                              >
                                <div className="relative">
                                  <img
                                    ref={cropImgRef}
                                    src={cropImageUrl}
                                    alt={personName}
                                    onLoad={onCropImageLoad}
                                    className="max-w-full max-h-96"
                                    crossOrigin="anonymous"
                                    style={{ filter: imageFilter }}
                                  />
                                  {/* Silhouette guide overlay - shows inside crop area */}
                                  {showGuide && crop && (
                                    <div
                                      className="absolute pointer-events-none"
                                      style={{
                                        left: `${crop.x}%`,
                                        top: `${crop.y}%`,
                                        width: `${crop.width}%`,
                                        height: `${crop.height}%`,
                                      }}
                                    >
                                      <svg
                                        viewBox="0 0 80 100"
                                        className="w-full h-full"
                                        style={{ opacity: 0.35 }}
                                      >
                                        {/* Head oval */}
                                        <ellipse
                                          cx="40"
                                          cy="32"
                                          rx="18"
                                          ry="22"
                                          fill="none"
                                          stroke="#1e40af"
                                          strokeWidth="1.5"
                                          strokeDasharray="3,2"
                                        />
                                        {/* Neck */}
                                        <path
                                          d="M 32 52 Q 32 58 28 65 L 28 75"
                                          fill="none"
                                          stroke="#1e40af"
                                          strokeWidth="1.5"
                                          strokeDasharray="3,2"
                                        />
                                        <path
                                          d="M 48 52 Q 48 58 52 65 L 52 75"
                                          fill="none"
                                          stroke="#1e40af"
                                          strokeWidth="1.5"
                                          strokeDasharray="3,2"
                                        />
                                        {/* Shoulders */}
                                        <path
                                          d="M 28 75 Q 15 78 5 85 L 5 100"
                                          fill="none"
                                          stroke="#1e40af"
                                          strokeWidth="1.5"
                                          strokeDasharray="3,2"
                                        />
                                        <path
                                          d="M 52 75 Q 65 78 75 85 L 75 100"
                                          fill="none"
                                          stroke="#1e40af"
                                          strokeWidth="1.5"
                                          strokeDasharray="3,2"
                                        />
                                        {/* Eye line indicator */}
                                        <line
                                          x1="15"
                                          y1="30"
                                          x2="25"
                                          y2="30"
                                          stroke="#1e40af"
                                          strokeWidth="1"
                                          opacity="0.6"
                                        />
                                        <line
                                          x1="55"
                                          y1="30"
                                          x2="65"
                                          y2="30"
                                          stroke="#1e40af"
                                          strokeWidth="1"
                                          opacity="0.6"
                                        />
                                      </svg>
                                    </div>
                                  )}
                                </div>
                              </ReactCrop>
                            </div>
                            
                            {/* Guide toggle */}
                            <div className="flex items-center gap-2">
                              <label className="flex items-center gap-2 text-sm text-gray-600 cursor-pointer">
                                <input
                                  type="checkbox"
                                  checked={showGuide}
                                  onChange={(e) => setShowGuide(e.target.checked)}
                                  className="rounded border-gray-300 text-primary-600 focus:ring-primary-500"
                                />
                                Show position guide
                              </label>
                            </div>
                            
                            {/* Image adjustment sliders */}
                            <div className="bg-gray-50 rounded-lg p-3 space-y-3">
                              <div className="flex items-center justify-between">
                                <span className="text-sm font-medium text-gray-700">Image Adjustments</span>
                                {hasAdjustments && (
                                  <button
                                    onClick={resetEnhancements}
                                    className="text-xs text-primary-600 hover:text-primary-700"
                                  >
                                    Reset
                                  </button>
                                )}
                              </div>
                              
                              <div className="space-y-2">
                                <div className="flex items-center gap-3">
                                  <label className="text-xs text-gray-600 w-20">Brightness</label>
                                  <input
                                    type="range"
                                    min="-50"
                                    max="50"
                                    value={brightness}
                                    onChange={(e) => setBrightness(Number(e.target.value))}
                                    className="flex-1 h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer"
                                  />
                                  <span className="text-xs text-gray-500 w-8 text-right">{brightness}</span>
                                </div>
                                
                                <div className="flex items-center gap-3">
                                  <label className="text-xs text-gray-600 w-20">Contrast</label>
                                  <input
                                    type="range"
                                    min="-50"
                                    max="50"
                                    value={contrast}
                                    onChange={(e) => setContrast(Number(e.target.value))}
                                    className="flex-1 h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer"
                                  />
                                  <span className="text-xs text-gray-500 w-8 text-right">{contrast}</span>
                                </div>
                                
                                <div className="flex items-center gap-3">
                                  <label className="text-xs text-gray-600 w-20">Saturation</label>
                                  <input
                                    type="range"
                                    min="-50"
                                    max="50"
                                    value={saturation}
                                    onChange={(e) => setSaturation(Number(e.target.value))}
                                    className="flex-1 h-2 bg-gray-200 rounded-lg appearance-none cursor-pointer"
                                  />
                                  <span className="text-xs text-gray-500 w-8 text-right">{saturation}</span>
                                </div>
                              </div>
                            </div>
                            
                            <p className="text-xs text-gray-500">
                              Drag to reposition or resize the crop area. Aspect ratio is locked to 4:5.
                            </p>
                            
                            {/* Action buttons */}
                            <div className="space-y-2">
                              <div className="flex gap-2">
                                <button
                                  onClick={handleDoneCropping}
                                  className="px-4 py-2 text-sm bg-primary-600 text-white rounded hover:bg-primary-700 font-medium"
                                >
                                  Crop
                                </button>
                                <button
                                  onClick={handleCancelCrop}
                                  className="px-4 py-2 text-sm border border-gray-300 rounded hover:bg-gray-50"
                                >
                                  Cancel
                                </button>
                              </div>
                              <p className="text-xs text-amber-600 font-medium">
                                ⚠️ Cropping cannot be undone. The original image will be replaced.
                              </p>
                            </div>
                          </div>
                        ) : (
                          <div className="space-y-2">
                            <img
                              src={croppedPreviewUrl || newPortraitPreview || portrait.portrait_url}
                              alt={personName}
                              className="w-32 h-40 object-cover rounded"
                            />
                            {!newPortraitFile && (
                              <div className="flex gap-2 items-center">
                                <button
                                  onClick={() => handleStartCrop(portrait.portrait_url)}
                                  className="text-sm text-primary-600 hover:text-primary-700 hover:underline"
                                  disabled={processing === portrait.person.id}
                                >
                                  {croppedPreviewUrl ? 'Adjust Again' : 'Adjust Crop'}
                                </button>
                                {croppedPreviewUrl && (
                                  <span className="text-xs text-green-600 font-medium">
                                    (crop adjusted)
                                  </span>
                                )}
                              </div>
                            )}
                          </div>
                        )}
                      </div>

                      <div className="mb-4">
                        <label className="block text-sm font-medium text-gray-700 mb-2">
                          Upload Replacement (optional)
                        </label>
                        <input
                          type="file"
                          accept="image/jpeg,image/jpg,image/png,image/webp,image/heic"
                          onChange={(e) => {
                            handlePortraitFileChange(e)
                            // Reset crop when uploading new file
                            handleCancelCrop()
                          }}
                          className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                          disabled={processing === portrait.person.id}
                        />
                      </div>

                      <div className="mb-4" ref={personSearchRef}>
                        <label className="block text-sm font-medium text-gray-700 mb-2">
                          Assign to Person <span className="text-red-500">*</span>
                        </label>
                        <input
                          type="text"
                          value={editPersonSearchTerm || (editPerson?.display_name || editPerson?.full_name || '')}
                          onChange={(e) => {
                            setEditPersonSearchTerm(e.target.value)
                            setShowPersonDropdown(true)
                          }}
                          onFocus={() => {
                            if (editPersonSearchTerm) {
                              setShowPersonDropdown(true)
                            }
                          }}
                          placeholder="Search for person..."
                          className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                          disabled={processing === portrait.person.id}
                        />
                        {showPersonDropdown && editPersonSearchTerm && (
                          <div className="absolute z-10 mt-1 w-full bg-white border border-gray-300 rounded-lg shadow-lg max-h-60 overflow-y-auto">
                            {personSearchLoading ? (
                              <div className="px-4 py-2 text-gray-500">Searching...</div>
                            ) : personSearchResults.length === 0 ? (
                              <div className="px-4 py-2 text-gray-500">No people found</div>
                            ) : (
                              personSearchResults.map((person) => (
                                <button
                                  key={person.id}
                                  onClick={() => {
                                    setEditPerson(person)
                                    setEditPersonSearchTerm('')
                                    setShowPersonDropdown(false)
                                  }}
                                  className="w-full text-left px-4 py-2 hover:bg-gray-100 border-b border-gray-100 last:border-0"
                                >
                                  <div className="font-medium text-gray-900">
                                    {person.display_name || person.full_name}
                                  </div>
                                  {person.display_name && person.full_name !== person.display_name && (
                                    <div className="text-sm text-gray-500">{person.full_name}</div>
                                  )}
                                </button>
                              ))
                            )}
                          </div>
                        )}
                      </div>

                      <div className="flex gap-2">
                        <button
                          onClick={handleSaveEdit}
                          disabled={processing === portrait.person.id || !editPerson}
                          className="px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed"
                        >
                          Save Changes
                        </button>
                        <button
                          onClick={handleCancelEdit}
                          disabled={processing === portrait.person.id}
                          className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50 disabled:opacity-50"
                        >
                          Cancel
                        </button>
                      </div>
                    </div>
                  )
                }

                return (
                  <div key={portrait.person.id} className="bg-white border border-gray-200 rounded-lg p-4 md:p-6">
                    {/* Mobile Card Layout */}
                    <div className="md:hidden flex flex-col gap-4">
                      <img
                        src={portrait.portrait_url}
                        alt={personName}
                        className="w-full h-48 object-cover rounded cursor-pointer hover:opacity-80 transition-opacity"
                        onClick={() => setLightboxImage({ url: portrait.portrait_url, personName })}
                      />
                      <div className="space-y-2">
                        <div>
                          <span className="text-xs text-gray-500">Name:</span>{' '}
                          <Link
                            to={`/person/${portrait.person.id}`}
                            className="text-primary-600 hover:text-primary-700 hover:underline font-medium"
                          >
                            {personName}
                          </Link>
                        </div>
                        {portrait.portrait_approved_at && (
                          <div>
                            <span className="text-xs text-gray-500">Approved:</span>{' '}
                            <span className="text-sm text-gray-900">
                              {new Date(portrait.portrait_approved_at).toLocaleDateString()}
                            </span>
                          </div>
                        )}
                        {portrait.submitter_name && (
                          <div>
                            <span className="text-xs text-gray-500">Submitted by:</span>{' '}
                            <span className="text-sm text-gray-900">{portrait.submitter_name}</span>
                            {portrait.submitter_email && (
                              <span className="text-sm text-gray-600"> ({portrait.submitter_email})</span>
                            )}
                          </div>
                        )}
                      </div>
                      <div className="flex gap-2 pt-2 border-t border-gray-200">
                        <button
                          onClick={() => handleStartEdit(portrait.person.id)}
                          disabled={processing === portrait.person.id}
                          className="flex-1 px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700 disabled:opacity-50 font-medium"
                        >
                          Edit
                        </button>
                        <button
                          onClick={() => handleDeleteClick(portrait.person.id)}
                          disabled={processing === portrait.person.id}
                          className={`flex-1 px-4 py-2 rounded disabled:opacity-50 font-medium ${
                            deleteConfirmState[portrait.person.id] === 'warning'
                              ? 'bg-yellow-50 border-yellow-400 text-yellow-700 hover:bg-yellow-100 border-2'
                              : 'border-red-300 text-red-700 hover:bg-red-50 border-2'
                          }`}
                        >
                          {deleteConfirmState[portrait.person.id] === 'warning' ? 'Are you sure?' : 'Delete'}
                        </button>
                      </div>
                    </div>

                    {/* Desktop Layout */}
                    <div className="hidden md:flex items-start gap-4">
                      <img
                        src={portrait.portrait_url}
                        alt={personName}
                        className="w-20 h-[100px] object-cover rounded flex-shrink-0 cursor-pointer hover:opacity-80 transition-opacity"
                        onClick={() => setLightboxImage({ url: portrait.portrait_url, personName })}
                      />
                      <div className="flex-1">
                        <h3 className="font-semibold text-gray-900 mb-2">
                          <Link
                            to={`/person/${portrait.person.id}`}
                            className="text-primary-600 hover:text-primary-700 hover:underline"
                          >
                            {personName}
                          </Link>
                        </h3>
                        <div className="text-xs text-gray-500 space-y-1">
                          {portrait.portrait_approved_at && (
                            <div>
                              <span className="text-gray-400">Approved:</span>{' '}
                              {new Date(portrait.portrait_approved_at).toLocaleDateString()}
                            </div>
                          )}
                          {portrait.submitter_name && (
                            <div>
                              <span className="text-gray-400">Submitted by:</span> {portrait.submitter_name}
                              {portrait.submitter_email && ` (${portrait.submitter_email})`}
                            </div>
                          )}
                        </div>
                      </div>
                      <div className="flex gap-2">
                        <button
                          onClick={() => handleStartEdit(portrait.person.id)}
                          disabled={processing === portrait.person.id}
                          className="px-4 py-2 bg-primary-600 text-white rounded hover:bg-primary-700 disabled:opacity-50"
                        >
                          Edit
                        </button>
                        <button
                          onClick={() => handleDeleteClick(portrait.person.id)}
                          disabled={processing === portrait.person.id}
                          className={`px-4 py-2 rounded disabled:opacity-50 ${
                            deleteConfirmState[portrait.person.id] === 'warning'
                              ? 'bg-yellow-50 border-yellow-400 text-yellow-700 hover:bg-yellow-100 border-2'
                              : 'border-red-300 text-red-700 hover:bg-red-50 border-2'
                          }`}
                        >
                          {deleteConfirmState[portrait.person.id] === 'warning' ? 'Are you sure?' : 'Delete'}
                        </button>
                      </div>
                    </div>
                  </div>
                )
                  })
                )}
              </div>
            </>
          )}
        </>
      )}

      {showRejectModal && (
        <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
          <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
            <h2 className="text-xl font-bold text-gray-900 mb-4">
              Reject Portrait for {showRejectModal.name}
            </h2>
            <div className="mb-4">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Rejection Reason (optional)
              </label>
              <textarea
                value={rejectionReason}
                onChange={(e) => setRejectionReason(e.target.value)}
                rows={3}
                className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                placeholder="e.g., Image quality too low, incorrect person..."
              />
            </div>
            <div className="flex gap-3 justify-end">
              <button
                onClick={() => {
                  setShowRejectModal(null)
                  setRejectionReason('')
                }}
                className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50"
              >
                Cancel
              </button>
              <button
                onClick={handleReject}
                disabled={processing === showRejectModal.id}
                className="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 disabled:opacity-50"
              >
                Reject
              </button>
            </div>
          </div>
        </div>
      )}

      {approvedPortraits.map((portrait) => {
        const deleteState = deleteConfirmState[portrait.person.id]
        if (deleteState === 'modal') {
          const personName = portrait.person.display_name || portrait.person.full_name
          return (
            <div
              key={`delete-modal-${portrait.person.id}`}
              className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4"
            >
              <div className="bg-white rounded-lg shadow-xl max-w-md w-full p-6">
                <h2 className="text-xl font-bold text-red-700 mb-4 flex items-center gap-2">
                  <span>⚠️</span> Delete Portrait
                </h2>
                <p className="text-gray-700 mb-4">
                  This action CANNOT be undone.
                </p>
                <p className="text-gray-700 mb-4">
                  The portrait for <strong>{personName}</strong> will be permanently deleted. The image file will be removed from storage.
                </p>
                <div className="mb-4">
                  <label className="block text-sm font-medium text-gray-700 mb-2">
                    Type <strong>DELETE</strong> to confirm:
                  </label>
                  <input
                    type="text"
                    value={deleteConfirmText[portrait.person.id] || ''}
                    onChange={(e) =>
                      setDeleteConfirmText({ ...deleteConfirmText, [portrait.person.id]: e.target.value })
                    }
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-red-500"
                    placeholder="DELETE"
                    autoFocus
                  />
                </div>
                <div className="flex gap-2 justify-end">
                  <button
                    onClick={() => handleDeleteCancel(portrait.person.id)}
                    className="px-4 py-2 border border-gray-300 rounded hover:bg-gray-50"
                  >
                    Cancel
                  </button>
                  <button
                    onClick={() => handleDeleteConfirm(portrait.person.id)}
                    disabled={
                      processing === portrait.person.id ||
                      (deleteConfirmText[portrait.person.id] || '').toUpperCase() !== 'DELETE'
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

      {lightboxImage && (
        <PortraitLightbox
          imageUrl={lightboxImage.url}
          personName={lightboxImage.personName}
          onClose={() => setLightboxImage(null)}
        />
      )}
    </div>
  )
}
