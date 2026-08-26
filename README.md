# Bountiful Utah South Stake History

An interactive historical records application displaying leadership callings from 1958 to present.

## 🌳 Features

- **Interactive Org Chart** - Family-tree style visualization of stake organization
- **Leadership History** - Complete records of every presidency and bishopric
- **Person Profiles** - See each individual's full service history
- **Search** - Find people by name
- **Member Stories** - Authenticated members can view shared memories and memorials (Phase 2)
- **Photo Archive** - Community-contributed photos (Phase 2)

## 🛠 Tech Stack

- **Frontend:** React + TypeScript + Vite
- **Styling:** Tailwind CSS
- **Visualization:** React Flow
- **Backend:** Supabase (PostgreSQL + Auth + Storage)
- **Hosting:** Vercel

## 🚀 Getting Started

### Prerequisites
- Node.js 18+
- npm or yarn
- Supabase account

### Installation

```bash
# Clone the repository
git clone https://github.com/bountiful-south-stake-history/stake-history.git
cd stake-history

# Install dependencies
npm install

# Copy environment variables
cp .env.example .env.local
# Edit .env.local with your Supabase credentials

# Start development server
npm run dev
```

### Database Setup

1. Create a new Supabase project
2. Go to SQL Editor in Supabase Dashboard
3. Run `supabase/schema.sql` to create tables
4. Run `supabase/seed_callings.sql` to import historical data

## 📊 Data Summary

- **1,492** calling records
- **738** unique individuals
- **22** organizations tracked
- **67** years of history (1958-2025)

## 🔐 Privacy

- Historical calling data is publicly viewable (same as sustained in stake conference)
- Stories, memories, and photos require member authentication
- Individuals may request redaction of their records
- No sensitive personal information is stored

## 👥 Contributing

This project is maintained by the Bountiful Utah South Stake. Contact the Stake Executive Secretary for access.

**Maintainers and successors:** read [docs/OPERATIONS.md](docs/OPERATIONS.md) first — it records the continuity facts (hosting, admin access, account recovery, the shared database, and what requires a developer) that are not discoverable from the running site.

## 📄 License

MIT License - See LICENSE file for details.

---

*"And also those to whom these commandments were given, might have power to lay the foundation of this church, and to bring it forth out of obscurity."* - D&C 1:30
