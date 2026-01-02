export interface DedicationSpeaker {
  name: string
  role: string
  personId: string | null
  audioUrl: string
  imageUrl?: string | null
  subtitle?: string
}

export interface BuildingDocument {
  title: string
  url: string
}

export interface Building {
  id: string
  name: string
  address: string
  dedicatedDate: string
  dedicatedBy?: string
  dedicatedByImage?: string
  description?: string
  imageUrl: string
  documents: BuildingDocument[]
  fullAudioUrl?: string
}

export const stakeInfo = {
  organizedDate: 'April 20, 1958',
  boundariesDate: 'January 10, 1971',
}

export const dedicationSpeakers: DedicationSpeaker[] = [
  {
    name: 'Claude L. Mills',
    role: 'Invocation',
    personId: 'f493660e-3ae2-44bb-926d-e1bc77bb7a30',
    audioUrl: '', // Add when audio uploaded
  },
  {
    name: 'Delmont Hayes',
    role: 'Remarks',
    personId: '0b33c957-8e93-4d7d-8355-07422088e0ae',
    audioUrl: '', // Add when audio uploaded
  },
  {
    name: 'Lyle N. Cole',
    role: 'Remarks',
    personId: '1cc5c669-53af-4bd3-bd34-ab1398c17e9e',
    audioUrl: '', // Add when audio uploaded
  },
  {
    name: 'Floyd E. Trimble',
    role: 'Remarks',
    personId: 'b3621cde-5e26-4cdc-92ab-2f897cfc3636',
    audioUrl: '', // Add when audio uploaded
  },
  {
    name: 'F. Burton Howard',
    role: 'Remarks',
    personId: 'ad5f64a2-1a14-4e65-bb79-b14bc05b4c5b',
    audioUrl: '', // Add when audio uploaded
  },
  {
    name: 'Harold B. Lee',
    role: 'Address & Dedicatory Prayer',
    personId: null,
    audioUrl: '', // Add when audio uploaded
    imageUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/harold-b-lee.jpg',
    subtitle: 'Apostle, later President of the Church',
  },
  {
    name: 'Kenneth G. Toone',
    role: 'Benediction',
    personId: 'bf24560a-32b5-43db-b99b-9dbc89c1eb8a',
    audioUrl: '', // Add when audio uploaded
  },
]

export const buildings: Building[] = [
  {
    id: 'stake-center',
    name: 'Stake Center',
    address: '1250 S Main Street, Bountiful UT',
    dedicatedDate: 'October 17, 1971',
    imageUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/stake-center-exterior.jpg',
    documents: [
      {
        title: 'Dedication Program & Open House Card',
        url: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/documents/stake-center-dedication-program-1971.pdf',
      }
    ],
    fullAudioUrl: '', // Add when audio uploaded
  },
  {
    id: 'middle-building',
    name: 'Middle Building',
    address: '102 E 1400 S, Bountiful UT',
    dedicatedDate: 'March 2, 1952',
    dedicatedBy: 'Bishop LeGrand Richards',
    dedicatedByImage: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/legrand-richards.jpg',
    description: 'Built and funded by Bountiful 4th Ward members. The east wing and cultural hall were later added to facilitate additional classrooms and bishop offices.',
    imageUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/middle-building-exterior.jpg',
    documents: [
      {
        title: 'Dedicatory Remarks & Prayer',
        url: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/documents/middle-building-dedication-1952.pdf',
      }
    ],
  },
]
