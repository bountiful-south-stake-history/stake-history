# Stake History Project - Cursor Development Guide

## Project Overview

This is a historical records application for the Bountiful Utah South Stake of The Church of Jesus Christ of Latter-day Saints. It displays leadership calling records from 1958 to present, with member-contributed photos, stories, and memorials.

### Tech Stack
- **Frontend:** React 18 + Vite + TypeScript
- **Styling:** Tailwind CSS
- **Visualization:** React Flow (org charts), D3.js (timelines)
- **Backend:** Supabase (PostgreSQL + Auth + Storage)
- **Hosting:** Vercel

### Key Features (Phase 1 - MVP)
1. Interactive org chart visualization (family-tree style)
2. Person detail pages showing all callings
3. Organization pages showing leadership history
4. Search by name
5. Public read access (no login required for historical data)
6. Admin login for data management
7. Full data export capability

### Key Features (Phase 2)
1. Member authentication via magic email links
2. Photo uploads with moderation queue
3. Story/memory submissions (visible only to authenticated users)
4. Memorial tributes

---

## Project Structure

```
stake-history/
├── public/
│   └── favicon.ico
├── src/
│   ├── components/
│   │   ├── layout/
│   │   │   ├── Header.tsx
│   │   │   ├── Footer.tsx
│   │   │   └── Layout.tsx
│   │   ├── visualization/
│   │   │   ├── OrgChart.tsx          # Main family-tree view
│   │   │   ├── OrgNode.tsx           # Individual node in chart
│   │   │   ├── PresidencyCard.tsx    # Expandable presidency display
│   │   │   └── TimelineView.tsx      # Future: Gantt-style timeline
│   │   ├── people/
│   │   │   ├── PersonCard.tsx        # Summary card for a person
│   │   │   ├── PersonDetail.tsx      # Full person page
│   │   │   └── CallingList.tsx       # List of callings for a person
│   │   ├── organizations/
│   │   │   ├── OrgDetail.tsx         # Organization history page
│   │   │   └── PresidencyList.tsx    # List of presidencies
│   │   ├── search/
│   │   │   ├── SearchBar.tsx
│   │   │   └── SearchResults.tsx
│   │   ├── admin/
│   │   │   ├── AdminDashboard.tsx
│   │   │   ├── DataExport.tsx
│   │   │   └── RedactionManager.tsx
│   │   └── ui/
│   │       ├── Button.tsx
│   │       ├── Card.tsx
│   │       ├── Modal.tsx
│   │       └── Loading.tsx
│   ├── pages/
│   │   ├── HomePage.tsx              # Landing page with org chart
│   │   ├── PersonPage.tsx            # /person/:id
│   │   ├── OrganizationPage.tsx      # /org/:id
│   │   ├── SearchPage.tsx            # /search
│   │   ├── AboutPage.tsx             # /about
│   │   └── AdminPage.tsx             # /admin (protected)
│   ├── hooks/
│   │   ├── useSupabase.ts            # Supabase client hook
│   │   ├── usePeople.ts              # People data queries
│   │   ├── useOrganizations.ts       # Org data queries
│   │   ├── useCallings.ts            # Callings data queries
│   │   └── useAuth.ts                # Authentication hook
│   ├── lib/
│   │   ├── supabase.ts               # Supabase client init
│   │   ├── types.ts                  # TypeScript interfaces
│   │   └── utils.ts                  # Helper functions
│   ├── styles/
│   │   └── globals.css               # Tailwind imports + custom styles
│   ├── App.tsx                       # Main app with routing
│   └── main.tsx                      # Entry point
├── supabase/
│   ├── schema.sql                    # Database schema
│   └── seed.sql                      # Initial data (generated)
├── .env.example                      # Environment variables template
├── .env.local                        # Local env vars (gitignored)
├── package.json
├── tsconfig.json
├── vite.config.ts
├── tailwind.config.js
├── postcss.config.js
└── README.md
```

---

## Database Schema

The database has these core tables:

### people
- `id` (UUID, primary key)
- `full_name` (text, required) - e.g., "F. Burton Howard"
- `display_name` (text, optional) - shorter display version
- `suffix` (text, optional) - "Jr.", "III", etc.
- `birth_date` (date, optional)
- `death_date` (date, optional)
- `bio` (text, optional)
- `photo_url` (text, optional)
- `redacted` (boolean, default false)
- `redacted_at` (timestamp, optional)
- `redacted_by` (UUID, optional)
- `redaction_reason` (text, optional)
- `created_at`, `updated_at` (timestamps)

### organizations
- `id` (UUID, primary key)
- `name` (text, required) - e.g., "Bountiful 14th Ward"
- `short_name` (text, optional) - e.g., "14th Ward"
- `org_type` (enum: 'stake', 'ward', 'branch', 'auxiliary')
- `parent_org_id` (UUID, optional, self-reference)
- `organized_date` (date, optional)
- `discontinued_date` (date, optional)
- `notes` (text, optional)
- `sort_order` (integer) - for display ordering
- `created_at`, `updated_at`

### positions
- `id` (UUID, primary key)
- `title` (text, required) - e.g., "Bishop", "1st Counselor"
- `short_title` (text, optional) - e.g., "1st"
- `position_type` (enum: 'president', 'counselor', 'secretary', 'clerk', 'member', 'other')
- `org_types` (text array) - which org types use this position
- `sort_order` (integer) - for display ordering

### callings
- `id` (UUID, primary key)
- `person_id` (UUID, FK to people)
- `position_id` (UUID, FK to positions)
- `organization_id` (UUID, FK to organizations)
- `presidency_number` (integer) - groups callings into presidencies
- `sustained_date` (date, required)
- `sustained_precision` (enum: 'exact', 'month', 'year')
- `released_date` (date, optional, null = current)
- `released_precision` (enum: 'exact', 'month', 'year')
- `notes` (text, optional)
- `created_at`, `updated_at`

### media (Phase 2)
- `id` (UUID, primary key)
- `file_url` (text, required)
- `file_type` (enum: 'photo', 'document', 'audio')
- `caption` (text, optional)
- `uploaded_by` (UUID, FK to auth.users)
- `redacted` (boolean, default false)
- `approved` (boolean, default false)
- `created_at`

### media_people (junction table)
- `media_id` (UUID, FK)
- `person_id` (UUID, FK)

### stories (Phase 2)
- `id` (UUID, primary key)
- `title` (text, required)
- `content` (text, required)
- `story_type` (enum: 'memory', 'recognition', 'memorial', 'historical')
- `author_id` (UUID, FK to auth.users)
- `published` (boolean, default false)
- `created_at`, `updated_at`

### story_people (junction table)
- `story_id` (UUID, FK)
- `person_id` (UUID, FK)

---

## TypeScript Interfaces

```typescript
// src/lib/types.ts

export interface Person {
  id: string;
  full_name: string;
  display_name?: string;
  suffix?: string;
  birth_date?: string;
  death_date?: string;
  bio?: string;
  photo_url?: string;
  redacted: boolean;
  created_at: string;
  updated_at: string;
}

export interface Organization {
  id: string;
  name: string;
  short_name?: string;
  org_type: 'stake' | 'ward' | 'branch' | 'auxiliary';
  parent_org_id?: string;
  organized_date?: string;
  discontinued_date?: string;
  notes?: string;
  sort_order: number;
}

export interface Position {
  id: string;
  title: string;
  short_title?: string;
  position_type: 'president' | 'counselor' | 'secretary' | 'clerk' | 'member' | 'other';
  sort_order: number;
}

export interface Calling {
  id: string;
  person_id: string;
  position_id: string;
  organization_id: string;
  presidency_number: number;
  sustained_date: string;
  sustained_precision: 'exact' | 'month' | 'year';
  released_date?: string;
  released_precision?: 'exact' | 'month' | 'year';
  notes?: string;
  // Joined fields
  person?: Person;
  position?: Position;
  organization?: Organization;
}

export interface Presidency {
  number: number;
  organization: Organization;
  start_date: string;
  end_date?: string;
  callings: Calling[];
}

export interface PersonWithCallings extends Person {
  callings: Calling[];
}

export interface OrganizationWithHistory extends Organization {
  presidencies: Presidency[];
}
```

---

## Environment Variables

```bash
# .env.local (copy from .env.example)

# Supabase
VITE_SUPABASE_URL=https://your-project-id.supabase.co
VITE_SUPABASE_ANON_KEY=your-anon-key-here

# Optional: For admin features
VITE_ADMIN_EMAIL=bountifulsouthstake@gmail.com
```

---

## Key Implementation Notes

### 1. Org Chart Visualization

Use React Flow to create an interactive org chart. The structure should be:

```
Stake Presidency (top)
├── High Council
├── Stake Auxiliaries
│   ├── Relief Society
│   ├── Young Men
│   ├── Young Women
│   ├── Primary
│   └── Sunday School
├── Wards
│   ├── Bountiful 4th Ward
│   ├── Bountiful 7th Ward
│   └── ... (all wards)
└── Branches
    └── Heritage Branch
```

Each node should be clickable to:
- Expand/collapse children
- Show current leadership
- Click through to full history

### 2. Public vs. Authenticated Content

```typescript
// Pattern for conditionally showing content
const PersonDetail = ({ personId }) => {
  const { user } = useAuth();
  const { person, callings } = usePerson(personId);
  const { stories } = usePersonStories(personId, { enabled: !!user });
  
  return (
    <div>
      {/* Always visible */}
      <h1>{person.full_name}</h1>
      <CallingList callings={callings} />
      
      {/* Only visible when logged in */}
      {user ? (
        <StoriesList stories={stories} />
      ) : (
        <SignInPrompt message="Sign in to view stories and memories" />
      )}
    </div>
  );
};
```

### 3. Redaction Handling

```typescript
// When displaying people, filter based on user role
const { data: people } = useQuery({
  queryKey: ['people'],
  queryFn: async () => {
    let query = supabase.from('people').select('*');
    
    // Non-admins don't see redacted people's details
    if (!isAdmin) {
      query = query.eq('redacted', false);
    }
    
    return query;
  }
});

// For redacted records in lists, show placeholder
const displayName = person.redacted && !isAdmin 
  ? '[Record removed at family request]' 
  : person.full_name;
```

### 4. Date Display Formatting

```typescript
// Handle date precision in display
function formatDate(date: string, precision: 'exact' | 'month' | 'year'): string {
  const d = new Date(date);
  switch (precision) {
    case 'exact':
      return d.toLocaleDateString('en-US', { 
        year: 'numeric', 
        month: 'long', 
        day: 'numeric' 
      });
    case 'month':
      return d.toLocaleDateString('en-US', { 
        year: 'numeric', 
        month: 'long' 
      });
    case 'year':
      return d.getFullYear().toString();
  }
}

// Display calling date range
function formatCallingRange(calling: Calling): string {
  const start = formatDate(calling.sustained_date, calling.sustained_precision);
  const end = calling.released_date 
    ? formatDate(calling.released_date, calling.released_precision)
    : 'present';
  return `${start} – ${end}`;
}
```

### 5. Search Implementation

```typescript
// Use Supabase full-text search
const searchPeople = async (query: string) => {
  const { data } = await supabase
    .from('people')
    .select('*')
    .eq('redacted', false)
    .ilike('full_name', `%${query}%`)
    .order('full_name')
    .limit(20);
  
  return data;
};
```

### 6. Admin Data Export

```typescript
// Export all data as JSON
const exportAllData = async () => {
  const [people, organizations, positions, callings] = await Promise.all([
    supabase.from('people').select('*'),
    supabase.from('organizations').select('*'),
    supabase.from('positions').select('*'),
    supabase.from('callings').select('*'),
  ]);
  
  const exportData = {
    exported_at: new Date().toISOString(),
    people: people.data,
    organizations: organizations.data,
    positions: positions.data,
    callings: callings.data,
  };
  
  // Download as JSON file
  const blob = new Blob([JSON.stringify(exportData, null, 2)], { type: 'application/json' });
  const url = URL.createObjectURL(blob);
  const a = document.createElement('a');
  a.href = url;
  a.download = `stake-history-export-${new Date().toISOString().split('T')[0]}.json`;
  a.click();
};
```

---

## Styling Guidelines

Use Tailwind CSS with a clean, professional aesthetic appropriate for church-related content.

### Color Palette
```javascript
// tailwind.config.js
module.exports = {
  theme: {
    extend: {
      colors: {
        // Primary - Navy blue (trust, tradition)
        primary: {
          50: '#f0f4f8',
          100: '#d9e2ec',
          500: '#2c5282',
          600: '#2a4365',
          700: '#1a365d',
        },
        // Accent - Warm gold (heritage, sacred)
        accent: {
          50: '#fffbeb',
          100: '#fef3c7',
          500: '#d97706',
          600: '#b45309',
        },
      },
    },
  },
};
```

### Typography
- Headers: Clean sans-serif (system fonts or Inter)
- Body: Readable, generous line height
- Names: Slightly larger, medium weight

### Components
- Cards with subtle shadows and rounded corners
- Clear visual hierarchy
- Generous whitespace
- Accessible contrast ratios

---

## Getting Started Commands

```bash
# Install dependencies
npm install

# Start development server
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview
```

---

## Initial Prompts for Cursor

When starting development, use these prompts in order:

### Prompt 1: Project Setup
```
Initialize this React project with Vite and TypeScript. Set up:
1. Tailwind CSS with the color palette defined in CURSOR_INSTRUCTIONS.md
2. React Router v6 for navigation
3. Supabase client configuration
4. Basic folder structure as outlined in the instructions

Create the initial files but leave components mostly empty - we'll build them incrementally.
```

### Prompt 2: Database Connection
```
Set up the Supabase connection:
1. Create src/lib/supabase.ts with client initialization
2. Create src/lib/types.ts with all TypeScript interfaces from the instructions
3. Create basic hooks: useSupabase.ts, usePeople.ts, useOrganizations.ts, useCallings.ts
4. Test the connection by fetching and logging the people count
```

### Prompt 3: Layout & Navigation
```
Create the basic layout components:
1. Header with site title, navigation links, and search icon
2. Footer with credits and export link
3. Layout wrapper that includes Header and Footer
4. Set up React Router with placeholder pages: Home, Person, Organization, Search, Admin
```

### Prompt 4: Org Chart Visualization
```
Implement the main org chart visualization using React Flow:
1. Create OrgChart.tsx as the main visualization component
2. Create custom node components for different org types (stake, ward, auxiliary)
3. Fetch organizations from Supabase and transform into React Flow nodes/edges
4. Make nodes clickable to expand/collapse and navigate to detail pages
5. Start with Stake Presidency at top, branching down to wards and auxiliaries
```

### Prompt 5: Person & Organization Pages
```
Build the detail pages:
1. PersonPage.tsx - shows person's full name, photo placeholder, bio, and complete calling history
2. OrganizationPage.tsx - shows organization history with all presidencies listed chronologically
3. Create reusable components: PersonCard, CallingList, PresidencyCard
4. Implement proper date formatting with precision handling
```

### Prompt 6: Search
```
Implement search functionality:
1. SearchBar component with real-time search
2. SearchResults component showing matching people
3. Use Supabase ilike for fuzzy matching
4. Show calling count and date range for each result
5. Link results to person detail pages
```

---

## Deployment

When ready to deploy:

1. Push code to GitHub (main branch)
2. In Vercel dashboard, import the `stake-history` repo
3. Configure environment variables in Vercel:
   - `VITE_SUPABASE_URL`
   - `VITE_SUPABASE_ANON_KEY`
4. Deploy
5. Add custom domain `history.bountifulsouthstake.org` in Vercel settings

Vercel will automatically redeploy when you push to main.

---

## Questions?

This document should give Cursor (and any future developer) complete context for building and maintaining this application. The goal is a respectful, accessible memorial of stake service that can be maintained and handed off for generations.
