# TMJOBS - Complete System Design & Plan

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────┐
│                      Vercel (Frontend)                       │
│                    Next.js 14 + TypeScript                    │
│                                                              │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌────────────┐  │
│  │ Login    │  │Dashboard │  │Profiles  │  │  MCP       │  │
│  │ Page     │  │          │  │Manager   │  │  Connector │  │
│  └──────────┘  └──────────┘  └──────────┘  └────────────┘  │
│       │              │              │              │         │
│       └──────────────┴──────┬───────┘              │         │
│                             │                      │         │
│                    ┌────────▼────────┐             │         │
│                    │  Supabase SDK   │             │         │
│                    │  (Auth + DB)    │             │         │
│                    └────────┬────────┘             │         │
└─────────────────────────────┼──────────────────────┘         │
                              │                                │
┌─────────────────────────────┼──────────────────────────────┐ │
│                      Supabase (Backend)                     │ │
│                                                             │ │
│  ┌─────────┐  ┌─────────┐  ┌───────────┐  ┌────────────┐  │ │
│  │  Auth   │  │Database │  │Edge       │  │  Storage   │  │ │
│  │         │  │(Postgres)│ │ Functions │  │            │  │ │
│  └─────────┘  └────┬────┘  └───────────┘  └────────────┘  │ │
│                    │                                      │ │
│  ┌─────────────────▼──────────────────────────────────┐   │ │
│  │              PostgreSQL Tables                      │   │ │
│  │  users │ clients │ job_profiles │ candidates        │   │ │
│  │  referrals │ tracking_events │ payments             │   │ │
│  └────────────────────────────────────────────────────┘   │ │
└───────────────────────────────────────────────────────────┘ │
```

## Database Schema Design

### Tables (all in `public` schema)

#### 1. `users` (extends auth.users)
```sql
CREATE TABLE users (
  id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  email TEXT NOT NULL,
  full_name TEXT,
  avatar_url TEXT,
  referral_code TEXT UNIQUE,
  role TEXT DEFAULT 'referrer' CHECK (role IN ('referrer', 'admin')),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

#### 2. `clients`
```sql
CREATE TABLE clients (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name TEXT NOT NULL,        -- e.g., "Major Turing", "Micro1"
  logo_url TEXT,
  description TEXT,
  website_url TEXT,
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

#### 3. `job_profiles`
```sql
CREATE TABLE job_profiles (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  title TEXT NOT NULL,       -- Job title
  description TEXT,
  location TEXT,
  salary_range TEXT,
  referral_bonus_amount DECIMAL(10,2) NOT NULL,  -- $ per hire
  status TEXT DEFAULT 'active' CHECK (status IN ('active', 'closed', 'draft')),
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

#### 4. `candidates`
```sql
CREATE TABLE candidates (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  job_profile_id UUID REFERENCES job_profiles(id) ON DELETE CASCADE,
  first_name TEXT NOT NULL,
  last_name TEXT NOT NULL,
  email TEXT NOT NULL,
  phone TEXT,
  linkedin_url TEXT,
  resume_url TEXT,
  notes TEXT,
  source TEXT,              -- where candidate was found
  created_by UUID REFERENCES users(id),
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(job_profile_id, email)
);
```

#### 5. `referrals`
```sql
CREATE TABLE referrals (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  candidate_id UUID REFERENCES candidates(id) ON DELETE CASCADE,
  referrer_id UUID REFERENCES users(id) ON DELETE CASCADE,
  job_profile_id UUID REFERENCES job_profiles(id) ON DELETE CASCADE,
  status TEXT DEFAULT 'applied' CHECK (status IN ('applied', 'signed_up', 'hired', 'not_hired')),
  applied_at TIMESTAMPTZ DEFAULT now(),
  signed_up_at TIMESTAMPTZ,
  hired_at TIMESTAMPTZ,
  not_hired_at TIMESTAMPTZ,
  hired_by TEXT,            -- who hired them
  notes TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

#### 6. `tracking_events`
```sql
CREATE TABLE tracking_events (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  referral_id UUID REFERENCES referrals(id) ON DELETE CASCADE,
  event_type TEXT NOT NULL CHECK (event_type IN ('applied', 'signed_up', 'hired', 'not_hired', 'emailed')),
  event_date TIMESTAMPTZ DEFAULT now(),
  metadata JSONB,           -- additional data about the event
  created_at TIMESTAMPTZ DEFAULT now()
);
```

#### 7. `payments`
```sql
CREATE TABLE payments (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  referral_id UUID REFERENCES referrals(id) ON DELETE CASCADE,
  candidate_id UUID REFERENCES candidates(id) ON DELETE CASCADE,
  job_profile_id UUID REFERENCES job_profiles(id) ON DELETE CASCADE,
  client_id UUID REFERENCES clients(id) ON DELETE CASCADE,
  referrer_id UUID REFERENCES users(id) ON DELETE CASCADE,
  amount DECIMAL(10,2) NOT NULL,  -- $ receivable
  status TEXT DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'overdue')),
  paid_at TIMESTAMPTZ,
  payment_method TEXT,
  invoice_number TEXT,
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);
```

### RLS Policies
- Users can only see their own data
- Admins can see all data
- Clients can see their own job profiles and candidates

## Dashboard Design

### Section 1: Major Turing
### Section 2: Micro1

Each section shows:
1. **Number of Profiles** - Active job profiles under this client
2. **Number of Referrals** - Total candidates referred across profiles
3. **Number Signed Up** - Candidates who signed up
4. **Number Hired** - Candidates who got hired
5. **Number NOT Hired** - Candidates who were rejected
6. **Number Emailed** - Candidates contacted via email
7. **Applied to Hired Ratio** - (Hired / Applied) × 100
8. **$ Receivable** - Total referral bonus owed
9. **$ Per Profile** - Breakdown by job profile
10. **$ Per Hire** - Breakdown by hired candidate

### Filters Available:
- **Date Range Filter** - Filter all metrics by date range
- **Hired Filter** - Show only hired candidates
- **Per Profile Hired Filter** - Show hires grouped by profile
- **Status Filter** - Filter by candidate status
- **Client Filter** - Toggle between Major Turing / Micro1

### Additional Metrics:
- Conversion funnel visualization
- Top performing profiles
- Recent activity feed
- Earnings summary
- Weekly/Monthly trends

## MCP Connector Design

### What is MCP?
Model Context Protocol - allows Claude to interact with external tools/data.

### Implementation:
- Create an MCP server that connects to Supabase
- Expose tools for:
  - `get_dashboard_summary` - Get overall dashboard stats
  - `get_client_metrics` - Get metrics for a specific client
  - `get_candidate_status` - Get candidate tracking info
  - `get_earnings` - Get referral earnings
  - `add_candidate` - Add a new candidate
  - `update_referral_status` - Update referral status

## Project Structure

```
TMJOBS/
├── supabase/
│   ├── migrations/
│   │   ├── 001_create_users.sql
│   │   ├── 002_create_clients.sql
│   │   ├── 003_create_job_profiles.sql
│   │   ├── 004_create_candidates.sql
│   │   ├── 005_create_referrals.sql
│   │   ├── 006_create_tracking_events.sql
│   │   └── 007_create_payments.sql
│   ├── functions/
│   │   └── (Edge Functions)
│   └── config.toml
├── src/
│   ├── app/
│   │   ├── layout.tsx
│   │   ├── page.tsx              # Login page
│   │   ├── dashboard/
│   │   │   ├── page.tsx          # Main dashboard
│   │   │   ├── major-turing/
│   │   │   │   └── page.tsx
│   │   │   ├── micro1/
│   │   │   │   └── page.tsx
│   │   │   └── components/
│   │   │       ├── MetricCard.tsx
│   │   │       ├── ReferralTable.tsx
│   │   │       ├── FilterBar.tsx
│   │   │       ├── EarningsChart.tsx
│   │   │       └── FunnelChart.tsx
│   │   ├── candidates/
│   │   │   └── page.tsx
│   │   ├── profiles/
│   │   │   └── page.tsx
│   │   ├── mcp/
│   │   │   └── page.tsx
│   │   └── api/
│   │       └── auth/
│   │           └── [...nextauth].ts
│   ├── components/
│   │   ├── ui/
│   │   │   ├── Button.tsx
│   │   │   ├── Card.tsx
│   │   │   ├── Input.tsx
│   │   │   ├── Select.tsx
│   │   │   └── Dialog.tsx
│   │   ├── Layout.tsx
│   │   ├── Sidebar.tsx
│   │   └── Header.tsx
│   ├── lib/
│   │   ├── supabase.ts           # Supabase client
│   │   ├── types.ts              # TypeScript types
│   │   └── utils.ts              # Utility functions
│   ├── hooks/
│   │   ├── useAuth.ts
│   │   ├── useDashboard.ts
│   │   └── useReferrals.ts
│   └── mcp/
│       └── server.ts             # MCP server
├── public/
│   └── favicon.ico
├── package.json
├── tsconfig.json
├── tailwind.config.ts
├── next.config.js
├── .env.local
├── .gitignore
└── README.md
```

## Tech Stack
- **Frontend**: Next.js 14 (App Router), TypeScript, Tailwind CSS, shadcn/ui
- **Backend**: Supabase (PostgreSQL, Auth, Storage, Edge Functions)
- **Deployment**: Vercel (frontend), Supabase Cloud (backend)
- **MCP**: @modelcontextprotocol/sdk
- **Charts**: Recharts
- **Date**: date-fns
- **Forms**: React Hook Form + Zod

## Deployment Plan
1. Create Supabase project
2. Set up database schema
3. Configure Supabase Auth
4. Build Next.js app
5. Deploy to Vercel
6. Set up MCP connector
7. Configure environment variables

## What Else Can Be Added
- Email integration (send candidate emails from dashboard)
- Resume/CV parsing
- Candidate scoring/AI ranking
- Team management (invite other referrers)
- Commission payout history
- PDF reports generation
- Mobile responsive PWA
- Push notifications
- LinkedIn integration
- Calendar integration for follow-ups
- Candidate pipeline Kanban board
