import { useState, useRef } from 'react'
import ReactCrop, { type Crop, centerCrop, makeAspectCrop } from 'react-image-crop'
import 'react-image-crop/dist/ReactCrop.css'
import imageCompression from 'browser-image-compression'
import { supabase } from '../../lib/supabase'
import type { Person } from '../../lib/types'

interface ContributionModalProps {
  person: Person
  onUploadComplete: () => void
  onCancel: () => void
}

type ContributionType = 'portrait' | 'correction' | 'memory' | 'photos'

const relationshipOptions = [
  { value: 'family', label: 'Family Member' },
  { value: 'friend', label: 'Friend' },
  { value: 'served_together', label: 'Served Together' },
  { value: 'ward_member', label: 'Ward Member' },
  { value: 'other', label: 'Other' },
]

interface FormErrors {
  name?: string
  email?: string
  phone?: string
  description?: string
  memory?: string
  relationship?: string
  photos?: string
  photoCaptions?: Record<number, string>
}

interface PhotoFile {
  file: File
  preview: string
  caption: string
  approximateDate: string
  eventContext: string
}

export function ContributionModal({ person, onUploadComplete, onCancel }: ContributionModalProps) {
  const [contributionType, setContributionType] = useState<ContributionType>('portrait')
  const [submitterName, setSubmitterName] = useState('')
  const [submitterEmail, setSubmitterEmail] = useState('')
  const [submitterPhone, setSubmitterPhone] = useState('')
  const [correctionType, setCorrectionType] = useState<'name_spelling' | 'date_correction' | 'other'>('other')
  const [correctionDescription, setCorrectionDescription] = useState('')
  const [relationship, setRelationship] = useState('')
  const [timePeriod, setTimePeriod] = useState('')
  const [memoryContent, setMemoryContent] = useState('')
  const [selectedFile, setSelectedFile] = useState<File | null>(null)
  const [previewUrl, setPreviewUrl] = useState<string | null>(null)
  const [photoFiles, setPhotoFiles] = useState<PhotoFile[]>([])
  const [crop, setCrop] = useState<Crop>()
  const [completedCrop, setCompletedCrop] = useState<Crop>()
  const [submitting, setSubmitting] = useState(false)
  const [error, setError] = useState<string | null>(null)
  const [success, setSuccess] = useState(false)
  const [formErrors, setFormErrors] = useState<FormErrors>({})
  const imgRef = useRef<HTMLImageElement>(null)
  const fileInputRef = useRef<HTMLInputElement>(null)
  const photosInputRef = useRef<HTMLInputElement>(null)

  const aspectRatio = 4 / 5
  const MAX_MEMORY_LENGTH = 2000
  const MAX_PHOTOS = 5

  const validateEmail = (email: string): boolean => {
    return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email)
  }

  const validateForm = (): boolean => {
    const errors: FormErrors = {}

    if (!submitterName.trim()) {
      errors.name = 'Name is required'
    }

    if (!submitterEmail.trim()) {
      errors.email = 'Email is required'
    } else if (!validateEmail(submitterEmail)) {
      errors.email = 'Please enter a valid email address'
    }

    if (contributionType === 'correction') {
      if (!correctionDescription.trim()) {
        errors.description = 'Please describe the correction needed'
      }
    } else if (contributionType === 'memory') {
      if (!memoryContent.trim()) {
        errors.memory = 'Please share your memory'
      } else if (memoryContent.length > MAX_MEMORY_LENGTH) {
        errors.memory = `Memory must be ${MAX_MEMORY_LENGTH} characters or less`
      }
    } else if (contributionType === 'photos') {
      if (photoFiles.length === 0) {
        errors.photos = 'Please select at least one photo'
      } else {
        const captionErrors: Record<number, string> = {}
        photoFiles.forEach((photo, index) => {
          if (!photo.caption.trim()) {
            captionErrors[index] = 'Caption is required'
          }
        })
        if (Object.keys(captionErrors).length > 0) {
          errors.photoCaptions = captionErrors
        }
      }
    }

    setFormErrors(errors)
    return Object.keys(errors).length === 0
  }

  const isFormValid = (): boolean => {
    const baseValid = submitterName.trim() !== '' && submitterEmail.trim() !== '' && validateEmail(submitterEmail)

    if (contributionType === 'portrait') {
      return baseValid && previewUrl !== null && completedCrop !== undefined
    } else if (contributionType === 'correction') {
      return baseValid && correctionDescription.trim() !== ''
    } else if (contributionType === 'memory') {
      return baseValid && memoryContent.trim() !== '' && memoryContent.length <= MAX_MEMORY_LENGTH
    } else if (contributionType === 'photos') {
      return baseValid && photoFiles.length > 0 && photoFiles.every(p => p.caption.trim() !== '')
    }
    return false
  }

  const handleFileSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0]
    if (!file) return

    if (!file.type.startsWith('image/')) {
      setError('Please select an image file')
      return
    }

    setSelectedFile(file)
    setError(null)
    const reader = new FileReader()
    reader.onload = () => {
      setPreviewUrl(reader.result as string)
    }
    reader.readAsDataURL(file)
  }

  const handlePhotosSelect = (e: React.ChangeEvent<HTMLInputElement>) => {
    const files = Array.from(e.target.files || [])
    if (files.length === 0) return

    if (photoFiles.length + files.length > MAX_PHOTOS) {
      setError(`Maximum ${MAX_PHOTOS} photos allowed`)
      return
    }

    const newPhotos: PhotoFile[] = []
    files.forEach((file) => {
      if (!file.type.startsWith('image/')) {
        setError('All files must be images')
        return
      }
      const reader = new FileReader()
      reader.onload = () => {
        newPhotos.push({
          file,
          preview: reader.result as string,
          caption: '',
          approximateDate: '',
          eventContext: '',
        })
        if (newPhotos.length === files.length) {
          setPhotoFiles([...photoFiles, ...newPhotos])
        }
      }
      reader.readAsDataURL(file)
    })
  }

  const removePhoto = (index: number) => {
    setPhotoFiles(photoFiles.filter((_, i) => i !== index))
  }

  const updatePhotoField = (index: number, field: keyof PhotoFile, value: string) => {
    const updated = [...photoFiles]
    updated[index] = { ...updated[index], [field]: value }
    setPhotoFiles(updated)
  }

  const onImageLoad = (e: React.SyntheticEvent<HTMLImageElement>) => {
    const { naturalWidth, naturalHeight } = e.currentTarget
    const crop = centerCrop(
      makeAspectCrop(
        {
          unit: '%',
          width: 90,
        },
        aspectRatio,
        naturalWidth,
        naturalHeight
      ),
      naturalWidth,
      naturalHeight
    )
    setCrop(crop)
  }

  const getCroppedImg = async (image: HTMLImageElement, crop: Crop): Promise<Blob> => {
    const canvas = document.createElement('canvas')
    const scaleX = image.naturalWidth / image.width
    const scaleY = image.naturalHeight / image.height
    const pixelRatio = window.devicePixelRatio

    canvas.width = crop.width! * scaleX * pixelRatio
    canvas.height = crop.height! * scaleY * pixelRatio

    const ctx = canvas.getContext('2d')
    if (!ctx) throw new Error('No 2d context')

    ctx.setTransform(pixelRatio, 0, 0, pixelRatio, 0, 0)
    ctx.imageSmoothingQuality = 'high'

    const cropX = crop.x! * scaleX
    const cropY = crop.y! * scaleY

    ctx.drawImage(
      image,
      cropX,
      cropY,
      crop.width! * scaleX,
      crop.height! * scaleY,
      0,
      0,
      crop.width! * scaleX,
      crop.height! * scaleY
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
  }

  const compressImage = async (file: File): Promise<File> => {
    const options = {
      maxSizeMB: 1,
      maxWidthOrHeight: 1200,
      useWebWorker: true,
      fileType: 'image/jpeg',
    }
    return await imageCompression(file, options)
  }

  const handlePortraitUpload = async () => {
    if (!selectedFile || !previewUrl || !completedCrop || !imgRef.current) {
      setError('Please select and crop an image')
      return
    }

    setSubmitting(true)
    setError(null)

    try {
      const croppedBlob = await getCroppedImg(imgRef.current, completedCrop)
      const croppedFile = new File([croppedBlob], 'portrait.jpg', { type: 'image/jpeg' })

      const options = {
        maxSizeMB: 0.1,
        maxWidthOrHeight: 400,
        useWebWorker: true,
        fileType: 'image/jpeg',
      }

      const compressedFile = await imageCompression(croppedFile, options)

      const timestamp = Date.now()
      const filename = `${timestamp}.jpg`
      const filePath = `portraits/pending/${person.id}/${filename}`

      console.log('Uploading to storage:', filePath, 'File size:', compressedFile.size)

      const { data: uploadData, error: uploadError } = await supabase.storage
        .from('portraits')
        .upload(filePath, compressedFile, {
          cacheControl: '3600',
          upsert: false,
        })

      if (uploadError) {
        console.error('Storage upload error:', uploadError)
        const errorDetails = uploadError as any
        console.error('Error details:', {
          message: uploadError.message,
          statusCode: errorDetails.statusCode,
          name: uploadError.name,
        })
        
        let errorMsg = uploadError.message || 'Unknown storage error'
        
        // Provide more specific error messages
        if (errorMsg.toLowerCase().includes('bucket')) {
          errorMsg = 'Storage bucket "portraits" not found. Please create it in Supabase Dashboard > Storage.'
        } else if (errorMsg.toLowerCase().includes('permission') || errorMsg.toLowerCase().includes('denied') || errorMsg.toLowerCase().includes('policy')) {
          errorMsg = 'Permission denied. Please check storage bucket policies allow public uploads.'
        } else if (errorMsg.includes('413') || errorMsg.toLowerCase().includes('too large')) {
          errorMsg = 'File is too large. Please try a smaller image.'
        }
        
        throw new Error(`Storage upload failed: ${errorMsg}`)
      }
      
      console.log('File uploaded successfully:', uploadData)

      const { error: insertError } = await supabase
        .from('portrait_submissions')
        .insert({
          person_id: person.id,
          portrait_url: filePath,
          submitter_name: submitterName,
          submitter_email: submitterEmail,
          submitter_phone: submitterPhone || null,
          status: 'pending',
          submitted_at: new Date().toISOString(),
        })

      if (insertError) {
        console.error('Portrait submission insert error:', insertError)
        
        // If insert fails, try to clean up the uploaded file
        await supabase.storage.from('portraits').remove([filePath])
        
        let errorMsg = insertError.message || 'Unknown database error'
        
        if (insertError.code === 'PGRST204' || errorMsg.includes("Could not find") || errorMsg.includes("column") || errorMsg.includes("schema cache")) {
          errorMsg = 'Database schema is missing portrait_submissions table. Please create it in Supabase SQL Editor.'
        } else if (errorMsg.includes('row-level security') || errorMsg.includes('RLS') || insertError.code === '42501') {
          errorMsg = 'Permission denied. Row-level security policy is blocking this insert. Please check RLS policies on portrait_submissions table.'
        } else if (errorMsg.includes('violates foreign key') || insertError.code === '23503') {
          errorMsg = 'Invalid person ID. The person record may not exist.'
        }
        
        throw new Error(`Failed to save portrait submission: ${errorMsg}${insertError.code ? ` (Code: ${insertError.code})` : ''}`)
      }
      
      console.log('Portrait submission created successfully')

      setSuccess(true)
      setTimeout(() => {
        onUploadComplete()
      }, 2000)
    } catch (err) {
      console.error('Portrait upload error:', err)
      let errorMessage = 'Failed to upload portrait'
      
      if (err instanceof Error) {
        errorMessage = err.message
        // Check for specific Supabase error codes
        if ('code' in err) {
          const code = (err as any).code
          if (code === 'PGRST116') {
            errorMessage = 'Storage bucket not found. Please ensure the "portraits" bucket exists in Supabase Storage.'
          } else if (code === '42501' || code === 'PGRST301') {
            errorMessage = 'Permission denied. Please check storage bucket permissions.'
          } else if (code === '23505') {
            errorMessage = 'Portrait already exists for this person.'
          }
        }
        // Check for storage-specific errors
        if (err.message.includes('Bucket not found') || err.message.includes('storage')) {
          errorMessage = 'Storage bucket "portraits" not found or not accessible. Please check Supabase Storage configuration.'
        }
        // Check for RLS policy errors
        if (err.message.includes('new row violates row-level security') || err.message.includes('RLS')) {
          errorMessage = 'Permission denied. Row-level security policy may be blocking this update.'
        }
      }
      
      setError(errorMessage)
      setSubmitting(false)
    }
  }

  const handleCorrectionSubmit = async () => {
    if (!validateForm()) {
      return
    }

    setSubmitting(true)
    setError(null)

    try {
      const { error: insertError } = await supabase.from('correction_requests').insert({
        person_id: person.id,
        correction_type: correctionType,
        description: correctionDescription,
        submitter_name: submitterName,
        submitter_email: submitterEmail,
        submitter_phone: submitterPhone || null,
        status: 'pending',
      })

      if (insertError) throw insertError

      setSuccess(true)
      setTimeout(() => {
        onUploadComplete()
      }, 2000)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to submit correction')
      setSubmitting(false)
    }
  }

  const handleMemorySubmit = async () => {
    if (!validateForm()) {
      return
    }

    setSubmitting(true)
    setError(null)

    try {
      // Ensure relationship is null if empty string, otherwise use the value directly (already matches DB constraint)
      const relationshipValue = relationship && relationship.trim() ? relationship.trim() : null
      
      // Ensure time_period is properly null (not an object)
      // JavaScript typeof null === 'object' is a quirk, but we need actual null
      const timePeriodValue = (timePeriod && typeof timePeriod === 'string' && timePeriod.trim()) 
        ? timePeriod.trim() 
        : null
      
      const memoryData = {
        person_id: person.id,
        content: memoryContent,
        submitter_name: submitterName,
        submitter_email: submitterEmail,
        submitter_phone: submitterPhone && submitterPhone.trim() ? submitterPhone.trim() : null,
        relationship: relationshipValue,
        time_period: timePeriodValue,
        status: 'pending' as const,
      }

      console.log('Attempting to insert memory:', memoryData)
      console.log('Person ID:', person.id)
      console.log('Memory content length:', memoryContent.length)
      console.log('Submitter name:', submitterName)
      console.log('Submitter email:', submitterEmail)
      console.log('Relationship value:', relationshipValue, '(type:', typeof relationshipValue, ')')
      console.log('Time period value:', timePeriodValue, '(type:', typeof timePeriodValue, ')')

      const { data, error: memoryError } = await supabase
        .from('memories')
        .insert(memoryData)
        .select()

      if (memoryError) {
        console.error('Memory insert error:', memoryError)
        console.error('Error code:', memoryError.code)
        console.error('Error message:', memoryError.message)
        console.error('Error details:', memoryError.details)
        console.error('Error hint:', memoryError.hint)
        throw memoryError
      }

      console.log('Memory inserted successfully:', data)

      setSuccess(true)
      setTimeout(() => {
        onUploadComplete()
      }, 2000)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to submit memory')
      setSubmitting(false)
    }
  }

  const handlePhotosSubmit = async () => {
    if (!validateForm()) {
      return
    }

    setSubmitting(true)
    setError(null)

    try {
      for (const photoFile of photoFiles) {
        const compressedFile = await compressImage(photoFile.file)
        const filePath = `photos/pending/${person.id}/${Date.now()}-${photoFile.file.name}`

        const { error: uploadError } = await supabase.storage
          .from('photos')
          .upload(filePath, compressedFile, {
            cacheControl: '3600',
            upsert: false,
          })

        if (uploadError) throw uploadError

        const {
          data: { publicUrl },
        } = supabase.storage.from('photos').getPublicUrl(filePath)

        const { error: photoError } = await supabase
          .from('photos')
          .insert({
            photo_url: publicUrl,
            caption: photoFile.caption,
            submitter_name: submitterName,
            submitter_email: submitterEmail,
            submitter_phone: submitterPhone || null,
            approximate_date: photoFile.approximateDate || null,
            event_context: photoFile.eventContext || null,
            status: 'pending',
          })

        if (photoError) throw photoError

        // Note: If photos table needs person_id column, add it here
        // Otherwise, may need a junction table for person-photo relationships
      }

      setSuccess(true)
      setTimeout(() => {
        onUploadComplete()
      }, 2000)
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Failed to upload photos')
      setSubmitting(false)
    }
  }

  const handleSubmit = () => {
    if (!validateForm()) {
      return
    }

    if (contributionType === 'portrait') {
      handlePortraitUpload()
    } else if (contributionType === 'correction') {
      handleCorrectionSubmit()
    } else if (contributionType === 'memory') {
      handleMemorySubmit()
    } else if (contributionType === 'photos') {
      handlePhotosSubmit()
    }
  }

  const getSuccessMessage = () => {
    switch (contributionType) {
      case 'portrait':
        return `Portrait submitted for approval. Thank you, ${submitterName}!`
      case 'correction':
        return `Correction submitted for review. Thank you, ${submitterName}!`
      case 'memory':
        return `Memory submitted for review. Thank you, ${submitterName}!`
      case 'photos':
        return `Photos submitted for review. Thank you, ${submitterName}!`
    }
  }

  const tabs = [
    { id: 'portrait', label: 'Portrait' },
    { id: 'correction', label: 'Correction' },
    { id: 'memory', label: 'Memory' },
    { id: 'photos', label: 'Photos' },
  ] as const

  return (
    <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
      <div className="bg-white rounded-lg shadow-xl max-w-3xl w-full max-h-[90vh] overflow-y-auto">
        <div className="p-6">
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-2xl font-bold text-primary-700">
              Contribute Information for {person.full_name}
            </h2>
            <button
              onClick={onCancel}
              disabled={submitting}
              className="text-gray-500 hover:text-gray-700 text-2xl font-bold disabled:opacity-50"
            >
              ×
            </button>
          </div>

          {error && (
            <div className="bg-red-50 border border-red-200 text-red-700 px-4 py-3 rounded mb-4">
              {error}
            </div>
          )}

          {success && (
            <div className="bg-green-50 border border-green-200 text-green-700 px-4 py-3 rounded mb-4">
              {getSuccessMessage()}
            </div>
          )}

          <div className="mb-6">
            <div className="flex gap-2 border-b border-gray-200 overflow-x-auto">
              {tabs.map((tab) => (
                <button
                  key={tab.id}
                  type="button"
                  onClick={() => {
                    setContributionType(tab.id)
                    setError(null)
                    setFormErrors({})
                  }}
                  disabled={submitting || success}
                  className={`px-4 py-2 font-medium border-b-2 transition-colors disabled:opacity-50 whitespace-nowrap ${
                    contributionType === tab.id
                      ? 'border-primary-600 text-primary-700'
                      : 'border-transparent text-gray-500 hover:text-gray-700'
                  }`}
                >
                  {tab.label}
                </button>
              ))}
            </div>
          </div>

          <div className="space-y-6">
            <div className="border-b border-gray-200 pb-6">
              <h3 className="text-lg font-semibold text-gray-900 mb-4">
                Submitter Information
              </h3>
              <div className="space-y-4">
                <div>
                  <label htmlFor="submitter-name" className="block text-sm font-medium text-gray-700 mb-1">
                    Your Name <span className="text-red-500">*</span>
                  </label>
                  <input
                    id="submitter-name"
                    type="text"
                    value={submitterName}
                    onChange={(e) => {
                      setSubmitterName(e.target.value)
                      if (formErrors.name) {
                        setFormErrors({ ...formErrors, name: undefined })
                      }
                    }}
                    onBlur={() => {
                      if (!submitterName.trim()) {
                        setFormErrors({ ...formErrors, name: 'Name is required' })
                      }
                    }}
                    className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 ${
                      formErrors.name ? 'border-red-500' : 'border-gray-300'
                    }`}
                    disabled={submitting || success}
                  />
                  {formErrors.name && (
                    <p className="mt-1 text-sm text-red-600">{formErrors.name}</p>
                  )}
                </div>

                <div>
                  <label htmlFor="submitter-email" className="block text-sm font-medium text-gray-700 mb-1">
                    Email <span className="text-red-500">*</span>
                  </label>
                  <input
                    id="submitter-email"
                    type="email"
                    value={submitterEmail}
                    onChange={(e) => {
                      setSubmitterEmail(e.target.value)
                      if (formErrors.email) {
                        setFormErrors({ ...formErrors, email: undefined })
                      }
                    }}
                    onBlur={() => {
                      if (!submitterEmail.trim()) {
                        setFormErrors({ ...formErrors, email: 'Email is required' })
                      } else if (!validateEmail(submitterEmail)) {
                        setFormErrors({ ...formErrors, email: 'Please enter a valid email address' })
                      }
                    }}
                    className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 ${
                      formErrors.email ? 'border-red-500' : 'border-gray-300'
                    }`}
                    disabled={submitting || success}
                  />
                  {formErrors.email && (
                    <p className="mt-1 text-sm text-red-600">{formErrors.email}</p>
                  )}
                </div>

                <div>
                  <label htmlFor="submitter-phone" className="block text-sm font-medium text-gray-700 mb-1">
                    Phone <span className="text-gray-400 text-xs">(optional)</span>
                  </label>
                  <input
                    id="submitter-phone"
                    type="tel"
                    value={submitterPhone}
                    onChange={(e) => setSubmitterPhone(e.target.value)}
                    className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                    disabled={submitting || success}
                  />
                </div>

                <p className="text-xs text-gray-500 italic">
                  We may contact you if there are questions about this submission
                </p>
              </div>
            </div>

            {contributionType === 'portrait' && (
              <div className="border-b border-gray-200 pb-6">
                <h3 className="text-lg font-semibold text-gray-900 mb-2">
                  Portrait Selection
                </h3>
                <p className="text-sm text-gray-600 mb-4">
                  Uploading portrait for: <span className="font-medium">{person.full_name}</span>
                </p>

                {!previewUrl ? (
                  <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center">
                    <input
                      ref={fileInputRef}
                      type="file"
                      accept="image/jpeg,image/png,image/webp,image/heic"
                      onChange={handleFileSelect}
                      className="hidden"
                      disabled={submitting || success}
                    />
                    <button
                      onClick={() => fileInputRef.current?.click()}
                      disabled={submitting || success}
                      className="bg-primary-600 text-white px-6 py-3 rounded-lg hover:bg-primary-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                    >
                      Select Image
                    </button>
                    <p className="text-sm text-gray-500 mt-2">
                      JPEG, PNG, WebP, or HEIC format
                    </p>
                  </div>
                ) : (
                  <div className="space-y-4">
                    <div className="flex justify-center">
                      <ReactCrop
                        crop={crop}
                        onChange={(_, percentCrop) => setCrop(percentCrop)}
                        onComplete={(c) => setCompletedCrop(c)}
                        aspect={aspectRatio}
                        minWidth={100}
                        disabled={submitting || success}
                      >
                        <img
                          ref={imgRef}
                          alt="Crop preview"
                          src={previewUrl}
                          onLoad={onImageLoad}
                          className="max-w-full max-h-[400px]"
                        />
                      </ReactCrop>
                    </div>

                    <button
                      onClick={() => {
                        setSelectedFile(null)
                        setPreviewUrl(null)
                        setCrop(undefined)
                        setCompletedCrop(undefined)
                      }}
                      disabled={submitting || success}
                      className="text-sm text-primary-600 hover:text-primary-700 underline disabled:opacity-50"
                    >
                      Choose Different Image
                    </button>
                  </div>
                )}
              </div>
            )}

            {contributionType === 'correction' && (
              <div className="border-b border-gray-200 pb-6">
                <h3 className="text-lg font-semibold text-gray-900 mb-4">
                  Correction Details
                </h3>
                <div className="space-y-4">
                  <div>
                    <label htmlFor="correction-type" className="block text-sm font-medium text-gray-700 mb-1">
                      Correction Type <span className="text-red-500">*</span>
                    </label>
                    <select
                      id="correction-type"
                      value={correctionType}
                      onChange={(e) =>
                        setCorrectionType(e.target.value as 'name_spelling' | 'date_correction' | 'other')
                      }
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={submitting || success}
                    >
                      <option value="name_spelling">Name Spelling</option>
                      <option value="date_correction">Date Correction</option>
                      <option value="other">Other</option>
                    </select>
                  </div>

                  <div>
                    <label htmlFor="correction-description" className="block text-sm font-medium text-gray-700 mb-1">
                      Please describe the correction needed <span className="text-red-500">*</span>
                    </label>
                    <textarea
                      id="correction-description"
                      value={correctionDescription}
                      onChange={(e) => {
                        setCorrectionDescription(e.target.value)
                        if (formErrors.description) {
                          setFormErrors({ ...formErrors, description: undefined })
                        }
                      }}
                      onBlur={() => {
                        if (!correctionDescription.trim()) {
                          setFormErrors({ ...formErrors, description: 'Please describe the correction needed' })
                        }
                      }}
                      rows={4}
                      className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 ${
                        formErrors.description ? 'border-red-500' : 'border-gray-300'
                      }`}
                      disabled={submitting || success}
                    />
                    {formErrors.description && (
                      <p className="mt-1 text-sm text-red-600">{formErrors.description}</p>
                    )}
                  </div>
                </div>
              </div>
            )}

            {contributionType === 'memory' && (
              <div className="border-b border-gray-200 pb-6">
                <h3 className="text-lg font-semibold text-gray-900 mb-4">
                  Share a Memory
                </h3>
                <div className="space-y-4">
                  <div>
                    <label htmlFor="relationship" className="block text-sm font-medium text-gray-700 mb-1">
                      Your Relationship
                    </label>
                    <select
                      id="relationship"
                      value={relationship}
                      onChange={(e) => setRelationship(e.target.value)}
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={submitting || success}
                    >
                      <option value="">Select relationship...</option>
                      {relationshipOptions.map(opt => (
                        <option key={opt.value} value={opt.value}>{opt.label}</option>
                      ))}
                    </select>
                  </div>

                  <div>
                    <label htmlFor="time-period" className="block text-sm font-medium text-gray-700 mb-1">
                      Time Period <span className="text-gray-400 text-xs">(optional)</span>
                    </label>
                    <input
                      id="time-period"
                      type="text"
                      value={timePeriod}
                      onChange={(e) => setTimePeriod(e.target.value)}
                      placeholder="e.g., When he was bishop 1985-1990"
                      className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                      disabled={submitting || success}
                    />
                  </div>

                  <div>
                    <label htmlFor="memory-content" className="block text-sm font-medium text-gray-700 mb-1">
                      Memory/Story <span className="text-red-500">*</span>
                    </label>
                    <textarea
                      id="memory-content"
                      value={memoryContent}
                      onChange={(e) => {
                        const value = e.target.value
                        if (value.length <= MAX_MEMORY_LENGTH) {
                          setMemoryContent(value)
                          if (formErrors.memory) {
                            setFormErrors({ ...formErrors, memory: undefined })
                          }
                        }
                      }}
                      onBlur={() => {
                        if (!memoryContent.trim()) {
                          setFormErrors({ ...formErrors, memory: 'Please share your memory' })
                        }
                      }}
                      rows={8}
                      className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 ${
                        formErrors.memory ? 'border-red-500' : 'border-gray-300'
                      }`}
                      disabled={submitting || success}
                    />
                    <div className="flex justify-between mt-1">
                      {formErrors.memory && (
                        <p className="text-sm text-red-600">{formErrors.memory}</p>
                      )}
                      <p className={`text-sm ml-auto ${memoryContent.length > MAX_MEMORY_LENGTH ? 'text-red-600' : 'text-gray-500'}`}>
                        {memoryContent.length} / {MAX_MEMORY_LENGTH}
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            )}

            {contributionType === 'photos' && (
              <div className="border-b border-gray-200 pb-6">
                <h3 className="text-lg font-semibold text-gray-900 mb-4">
                  Add Photos
                </h3>
                <div className="space-y-4">
                  {photoFiles.length === 0 ? (
                    <div className="border-2 border-dashed border-gray-300 rounded-lg p-8 text-center">
                      <input
                        ref={photosInputRef}
                        type="file"
                        accept="image/jpeg,image/png,image/webp,image/heic"
                        multiple
                        onChange={handlePhotosSelect}
                        className="hidden"
                        disabled={submitting || success}
                      />
                      <button
                        onClick={() => photosInputRef.current?.click()}
                        disabled={submitting || success}
                        className="bg-primary-600 text-white px-6 py-3 rounded-lg hover:bg-primary-700 transition-colors disabled:opacity-50 disabled:cursor-not-allowed"
                      >
                        Select Photos (up to {MAX_PHOTOS})
                      </button>
                      <p className="text-sm text-gray-500 mt-2">
                        JPEG, PNG, WebP, or HEIC format
                      </p>
                    </div>
                  ) : (
                    <div className="space-y-6">
                      {photoFiles.map((photo, index) => (
                        <div key={index} className="border border-gray-200 rounded-lg p-4">
                          <div className="flex gap-4 mb-4">
                            <img
                              src={photo.preview}
                              alt={`Preview ${index + 1}`}
                              className="w-32 h-32 object-cover rounded"
                            />
                            <div className="flex-1 space-y-3">
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Caption <span className="text-red-500">*</span>
                                </label>
                                <input
                                  type="text"
                                  value={photo.caption}
                                  onChange={(e) => updatePhotoField(index, 'caption', e.target.value)}
                                  className={`w-full px-3 py-2 border rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500 ${
                                    formErrors.photoCaptions?.[index] ? 'border-red-500' : 'border-gray-300'
                                  }`}
                                  disabled={submitting || success}
                                />
                                {formErrors.photoCaptions?.[index] && (
                                  <p className="mt-1 text-sm text-red-600">{formErrors.photoCaptions[index]}</p>
                                )}
                              </div>
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Approximate Date <span className="text-gray-400 text-xs">(optional)</span>
                                </label>
                                <input
                                  type="text"
                                  value={photo.approximateDate}
                                  onChange={(e) => updatePhotoField(index, 'approximateDate', e.target.value)}
                                  placeholder="e.g., 1985 or Spring 1990"
                                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                                  disabled={submitting || success}
                                />
                              </div>
                              <div>
                                <label className="block text-sm font-medium text-gray-700 mb-1">
                                  Event/Context <span className="text-gray-400 text-xs">(optional)</span>
                                </label>
                                <input
                                  type="text"
                                  value={photo.eventContext}
                                  onChange={(e) => updatePhotoField(index, 'eventContext', e.target.value)}
                                  placeholder="e.g., Ward Christmas Party"
                                  className="w-full px-3 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-primary-500"
                                  disabled={submitting || success}
                                />
                              </div>
                            </div>
                            <button
                              onClick={() => removePhoto(index)}
                              disabled={submitting || success}
                              className="text-red-600 hover:text-red-700 disabled:opacity-50"
                            >
                              Remove
                            </button>
                          </div>
                        </div>
                      ))}
                      {photoFiles.length < MAX_PHOTOS && (
                        <button
                          onClick={() => photosInputRef.current?.click()}
                          disabled={submitting || success}
                          className="text-sm text-primary-600 hover:text-primary-700 underline disabled:opacity-50"
                        >
                          Add More Photos ({photoFiles.length} / {MAX_PHOTOS})
                        </button>
                      )}
                      {formErrors.photos && (
                        <p className="text-sm text-red-600">{formErrors.photos}</p>
                      )}
                    </div>
                  )}
                </div>
              </div>
            )}

            <div className="flex gap-3 justify-end">
              <button
                onClick={onCancel}
                disabled={submitting || success}
                className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 disabled:opacity-50 disabled:cursor-not-allowed"
              >
                Cancel
              </button>
              <button
                onClick={handleSubmit}
                disabled={submitting || success || !isFormValid()}
                className="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50 disabled:cursor-not-allowed flex items-center gap-2"
              >
                {submitting ? (
                  <>
                    <svg
                      className="animate-spin h-4 w-4 text-white"
                      xmlns="http://www.w3.org/2000/svg"
                      fill="none"
                      viewBox="0 0 24 24"
                    >
                      <circle
                        className="opacity-25"
                        cx="12"
                        cy="12"
                        r="10"
                        stroke="currentColor"
                        strokeWidth="4"
                      />
                      <path
                        className="opacity-75"
                        fill="currentColor"
                        d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"
                      />
                    </svg>
                    {contributionType === 'portrait'
                      ? 'Uploading...'
                      : contributionType === 'photos'
                      ? 'Uploading...'
                      : 'Submitting...'}
                  </>
                ) : (
                  contributionType === 'portrait'
                    ? 'Upload'
                    : contributionType === 'photos'
                    ? 'Upload Photos'
                    : 'Submit'
                )}
              </button>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}
