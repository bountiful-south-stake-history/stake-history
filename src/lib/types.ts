export interface Person {
  id: string
  full_name: string
  display_name?: string
  suffix?: string
  birth_date?: string
  death_date?: string
  bio?: string
  photo_url?: string
  portrait_url?: string
  portrait_pending?: boolean
  portrait_uploaded_at?: string
  portrait_uploaded_by?: string | null
  portrait_submission_notes?: string
  redacted: boolean
  created_at: string
  updated_at: string
}

export interface Organization {
  id: string
  name: string
  short_name?: string
  org_type: 'stake' | 'ward' | 'branch' | 'auxiliary'
  parent_org_id?: string
  organized_date?: string
  discontinued_date?: string
  notes?: string
  sort_order: number
}

export interface Position {
  id: string
  title: string
  short_title?: string
  position_type: 'president' | 'counselor' | 'secretary' | 'clerk' | 'member' | 'other'
  sort_order: number
}

export interface Calling {
  id: string
  person_id: string
  position_id: string
  organization_id: string
  presidency_number: number
  sustained_date: string
  sustained_precision: 'exact' | 'month' | 'year'
  released_date?: string
  released_precision?: 'exact' | 'month' | 'year'
  notes?: string
  person?: Person
  position?: Position
  organization?: Organization
}

export interface Presidency {
  number: number
  organization: Organization
  start_date: string
  end_date?: string
  callings: Calling[]
}

export interface PersonWithCallings extends Person {
  callings: Calling[]
}

export interface OrganizationWithHistory extends Organization {
  presidencies: Presidency[]
}

export interface Correction {
  id: string
  person_id: string
  correction_type: 'name_spelling' | 'date_correction' | 'other'
  description: string
  submitter_name: string
  submitter_email: string
  submitter_phone?: string
  status: 'pending' | 'completed' | 'dismissed'
  reviewed_by?: string
  reviewed_at?: string
  notes?: string
  created_at: string
  updated_at: string
}

export interface Memory {
  id: string
  person_id: string
  content: string
  submitter_name: string
  submitter_email: string
  submitter_phone?: string
  relationship?: string
  time_period?: string
  status: 'pending' | 'approved' | 'rejected'
  submitted_at: string
  reviewed_at?: string
  reviewed_by?: string
  rejection_reason?: string
}

export interface Photo {
  id: string
  photo_url: string
  caption?: string
  submitter_name: string
  submitter_email: string
  submitter_phone?: string
  approximate_date?: string
  event_context?: string
  status: 'pending' | 'approved' | 'rejected'
  submitted_at: string
  reviewed_at?: string
  reviewed_by?: string
  rejection_reason?: string
}

export interface PortraitSubmission {
  id: string
  person_id: string
  portrait_url: string
  submitter_name: string
  submitter_email: string
  submitter_phone?: string
  status: 'pending' | 'approved' | 'rejected'
  submitted_at: string
  reviewed_at?: string
  reviewed_by?: string
  rejection_reason?: string
  person?: Person
}

