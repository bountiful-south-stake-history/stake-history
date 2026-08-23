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

export interface BuildingEvent {
  year: string
  date?: string
  label: string
  detail?: string
  authority?: string
  authorityImage?: string
  authorityRole?: string
}

export interface Building {
  id: string
  name: string
  address: string
  dedicatedDate: string
  dedicatedBy?: string
  dedicatedByImage?: string
  dedicatedByRole?: string
  description?: string
  imageUrl: string
  documents: BuildingDocument[]
  fullAudioUrl?: string
  timeline?: BuildingEvent[]
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
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/3-Invocation_Claude_L_Mills_1st_Counselor_7th_ward.mp3',
  },
  {
    name: 'Floyd E. Trimble',
    role: 'Sacrament Announcement',
    personId: 'b3621cde-5e26-4cdc-92ab-2f897cfc3636',
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/4-Bishop_Trimble_Announce_Sacrament.mp3',
  },
  {
    name: 'Floyd E. Trimble',
    role: 'Sacrament Conclusion',
    personId: 'b3621cde-5e26-4cdc-92ab-2f897cfc3636',
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/7-Bishop_Trimble_conclude_sacrament.mp3',
  },
  {
    name: 'Delmont Hayes',
    role: 'Remarks',
    personId: '0b33c957-8e93-4d7d-8355-07422088e0ae',
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/8-president-delmont-hayes.mp3',
  },
  {
    name: 'Lyle N. Cole',
    role: 'Remarks',
    personId: '1cc5c669-53af-4bd3-bd34-ab1398c17e9e',
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/9-Bishop_Lyle_N_Cole_7th_ward_remarks.mp3',
  },
  {
    name: 'Floyd E. Trimble',
    role: 'Remarks',
    personId: 'b3621cde-5e26-4cdc-92ab-2f897cfc3636',
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/10-Trimble-remarks.mp3',
  },
  {
    name: 'F. Burton Howard',
    role: 'Introduction of Regional Representative Romney',
    personId: 'ad5f64a2-1a14-4e65-bb79-b14bc05b4c5b',
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/11-President_F_Burton_Howard_call_on_Rep_Romney.mp3',
  },
  {
    name: 'Antone K. Romney',
    role: 'Remarks',
    personId: null,
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/12-Regional_Representative_Antone_K_Romney_remarks.mp3',
    imageUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/antone-k-romney.jpg',
    subtitle: 'Regional Representative',
  },
  {
    name: 'F. Burton Howard',
    role: 'Remarks',
    personId: 'ad5f64a2-1a14-4e65-bb79-b14bc05b4c5b',
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/13-President_F_Burton Howard.mp3',
  },
  {
    name: 'Harold B. Lee',
    role: 'Remarks',
    personId: null,
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/15-Harold_B_Lee_remarks.mp3',
    imageUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/harold-b-lee.jpg',
    subtitle: 'First Counselor in the First Presidency (later President of the Church)',
  },
  {
    name: 'Harold B. Lee',
    role: 'Dedicatory Prayer',
    personId: null,
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/16-Harold_B_Lee_Dedicatory_Prayer.mp3',
    imageUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/harold-b-lee.jpg',
    subtitle: 'First Counselor in the First Presidency (later President of the Church)',
  },
  {
    name: 'Floyd E. Trimble',
    role: 'Closing Remarks',
    personId: 'b3621cde-5e26-4cdc-92ab-2f897cfc3636',
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/18-Bishop_Trimble_Closing_Remarks.mp3',
  },
  {
    name: 'Kenneth G. Toone',
    role: 'Benediction',
    personId: 'bf24560a-32b5-43db-b99b-9dbc89c1eb8a',
    audioUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/audio/19-Benediction_Kenneth_G_Toone_1st_C_15th_ward.mp3',
  },
]

export const buildings: Building[] = [
  {
    id: '1250-s-main',
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
    id: '102-e-1400-s',
    name: 'Middle',
    address: '102 E 1400 S, Bountiful UT',
    dedicatedDate: 'March 2, 1952',
    description: 'The Bountiful 4th Ward built this chapel in 1952 and enlarged it a decade later to serve three wards. Two future Presidents of the Church broke ground on it, fourteen years apart. After seventy-four years, it was announced for sale in 2026.',
    imageUrl: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/middle-building-exterior.jpg',
    documents: [
      {
        title: 'Dedicatory Remarks & Prayer (1952)',
        url: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/documents/middle-building-dedication-1952.pdf',
      }
    ],
    timeline: [
      {
        year: '1949',
        date: 'June 7, 1949',
        label: 'Groundbreaking',
        detail: "Elder Harold B. Lee of the Quorum of the Twelve Apostles — later President of the Church — represented the General Authorities. Dr. Theodore Martin conducted. The site near First East and Thirteenth South had been selected that March, on open ground before the surrounding streets were developed.",
        authority: 'Elder Harold B. Lee',
        authorityImage: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/harold-b-lee.jpg',
        authorityRole: 'Quorum of the Twelve Apostles, later President of the Church',
      },
      {
        year: '1952',
        date: 'March 2, 1952',
        label: 'Dedicated',
        detail: "The original building held the chapel, west wing, and recreation hall with a small stage and kitchen nook, in 9,900 square feet built at a cost of $148,000. The steeple originally stood over the west entrance. Members of the Bountiful 4th Ward raised the funds and donated the labor; Justin Tolman kept a written record of every donated hour by organization. The dedication service music was carried entirely by the ward's youth choir. Five weeks later, Bishop Richards was called to the Quorum of the Twelve Apostles.",
        authority: 'Bishop LeGrand Richards',
        authorityImage: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/legrand-richards.jpg',
        authorityRole: 'Presiding Bishop, later called as an apostle',
      },
      {
        year: '1963',
        date: 'August 1963',
        label: 'Groundbreaking for the addition',
        detail: "Elder Spencer W. Kimball of the Quorum of the Twelve Apostles — later President of the Church — officiated. Construction ran from September 1, 1963 to October 1, 1964.",
        authority: 'Elder Spencer W. Kimball',
        authorityImage: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/spencer-w-kimball.jpg',
        authorityRole: 'Quorum of the Twelve Apostles, later President of the Church',
      },
      {
        year: '1967',
        date: 'January 22, 1967',
        label: 'Rededicated after enlargement',
        detail: "The addition brought 10,692 square feet at a cost of $242,893 — larger than the original building — including the east wing, a full raised stage, a large kitchen, additional classrooms, and bishop's offices. The steeple was moved from the west entrance to the top of the chapel. Members of the three wards donated labor valued at $27,100. By then the building served the Bountiful 4th, 7th, and 20th Wards — 1,834 members in 1963.",
        authority: 'President N. Eldon Tanner',
        authorityImage: 'https://kywsocmgkrckwhnmhtfz.supabase.co/storage/v1/object/public/archives/images/n-eldon-tanner.jpg',
        authorityRole: 'Second Counselor in the First Presidency',
      },
      {
        year: '2026',
        label: 'Announced for sale',
        detail: 'Farewell open house held August 15, 2026.',
      },
    ],
  },
  {
    id: '1500-s-600-e',
    name: 'East',
    address: '1500 S 600 E, Bountiful UT',
    dedicatedDate: '',
    imageUrl: '',
    documents: [],
  },
]
