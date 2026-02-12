# Drink Tracker 2026

Personal drink tracking app with calorie monitoring and cost tracking. Built as a single-file React app with Supabase backend.

**Live App:** [Deployed URL - add when available]

## Features

- 📱 **Mobile-first design** - Optimized for iOS/Android browsers
- 🔐 **User authentication** - Secure sign-up/login via Supabase Auth
- 🍺 **Comprehensive drink database** - 50+ pre-populated drinks across categories
- 🎯 **Smart search** - Name variations for easy drink entry
- 🔒 **Row-level security** - Each user's data is completely isolated

### Coming Next
- 📊 **Calorie tracking** - Monitor consumption with built-in calorie data (TOP PRIORITY)
- 💰 **Cost tracking** - Optional cost tracking per drink

## Tech Stack

- **Frontend**: React 18 (via CDN), Tailwind CSS
- **Backend**: Supabase (PostgreSQL + Auth + RLS)
- **Deployment**: Static hosting (GitHub Pages, Netlify, or Vercel)
- **Architecture**: Single-file HTML app (~4,500 lines)

## Drink Categories

### Beer (18 varieties)
Guinness, Budweiser, Heineken, Corona, Stella Artois, IPA, Lager, Pilsner, Wheat Beer, Porter, Stout, Sour Beer, Modelo, Dos Equis, Blue Moon, Sam Adams, Sierra Nevada, Narragansett

### Wine (17 varieties)
Red Wine, White Wine, Rosé, Champagne, Prosecco, Pinot Noir, Cabernet Sauvignon, Merlot, Chardonnay, Sauvignon Blanc, Pinot Grigio, Riesling, Moscato, Malbec, Syrah, Zinfandel, Sangria

### Cocktails (20+ varieties)
Old Fashioned, Negroni, Martini, Manhattan, Moscow Mule, Mojito, Margarita, Cosmopolitan, Daiquiri, Whiskey Sour, Gin & Tonic, Vodka Soda, and more

## Setup Instructions

### 1. Clone the Repository

```bash
git clone https://github.com/srikarm11/drink-tracker-2026.git
cd drink-tracker-2026
```

### 2. Supabase Configuration

Follow the detailed setup in [`SUPABASE_SETUP.md`](./SUPABASE_SETUP.md):

1. Create a Supabase project at https://supabase.com
2. Create the `drinks` table with the schema:
   ```sql
   CREATE TABLE drinks (
     id BIGSERIAL PRIMARY KEY,
     user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE NOT NULL,
     name TEXT NOT NULL,
     category TEXT NOT NULL,
     calories INTEGER,
     cost NUMERIC,
     created_at TIMESTAMPTZ DEFAULT NOW()
   );
   ```
3. Enable Row Level Security (RLS) - see `SUPABASE_SETUP.md`
4. Create RLS policies for SELECT, INSERT, UPDATE, DELETE
5. Update `SUPABASE_URL` and `SUPABASE_KEY` in `index.html` (lines 27-28)

### 3. Local Development

Since this is a static HTML file, you can:

**Option A: Simple Python server**
```bash
python3 -m http.server 8000
# Visit http://localhost:8000
```

**Option B: VS Code Live Server**
- Install "Live Server" extension
- Right-click `index.html` → "Open with Live Server"

**Option C: Just open the file**
```bash
open index.html
```

### 4. Deployment

**GitHub Pages:**
```bash
# Enable GitHub Pages in repo settings → Pages → Deploy from main branch
# Your app will be at: https://srikarm11.github.io/drink-tracker-2026/
```

**Netlify:**
- Drag and drop the folder into Netlify
- Or connect the GitHub repo for auto-deploy

**Vercel:**
```bash
npm install -g vercel
vercel --prod
```

## Database Schema

### `drinks` table

| Column | Type | Description |
|--------|------|-------------|
| `id` | BIGSERIAL | Primary key |
| `user_id` | UUID | Foreign key to `auth.users` |
| `name` | TEXT | Drink name (e.g., "Guinness") |
| `category` | TEXT | Category (Beer/Wine/Cocktail) |
| `calories` | INTEGER | Calories per serving |
| `cost` | NUMERIC | Cost per drink (optional) |
| `created_at` | TIMESTAMPTZ | Timestamp of entry |

### RLS Policies

All policies use `auth.uid() = user_id` to ensure data isolation:
- **SELECT**: Users can view only their own drinks
- **INSERT**: Users can insert only their own drinks
- **UPDATE**: Users can update only their own drinks
- **DELETE**: Users can delete only their own drinks

See `SUPABASE_SETUP.md` for full RLS configuration.

## Project Structure

```
drink-tracker-2026/
├── index.html              # Main app (React + Supabase)
├── SUPABASE_SETUP.md       # Detailed backend setup guide
├── setup_rls.sql           # RLS policy creation
├── fix_rls_complete.sql    # RLS fixes and migrations
├── migration_v2.0.sql      # Version 2.0 migrations
├── diagnose_rls.sql        # RLS diagnostic queries
├── cleanup_and_reset.sql   # Database reset script
├── test_rls_setup.sql      # RLS testing queries
└── README.md               # This file
```

## Current Version

**v2.0.0** (as of Feb 2026)
- User authentication with Supabase
- Row-level security for multi-user support
- 50+ drink database with name variations
- Mobile-responsive UI

## Development Roadmap

See [`PRODUCT_ROADMAP.md`](./PRODUCT_ROADMAP.md) for planned features and priorities.

## Security & Privacy

- 🔒 **Authentication**: Secure email/password authentication via Supabase
- 🛡️ **RLS Policies**: Database-level security ensures users can only access their own data
- 🔑 **API Keys**: Supabase anon key is safe to expose (RLS protects data)
- 🚫 **No tracking**: No analytics, no third-party tracking

## Contributing

This is a personal project, but feedback and suggestions are welcome! Open an issue if you find bugs or have feature ideas.

## License

MIT License - feel free to fork and customize for your own use.

## Author

**Srikar Manjuluri** ([@srikarm11](https://github.com/srikarm11))
- Director of Growth @ Makai Labs
- Based in NYC
- Running enthusiast (Brooklyn Half Marathon 2026)

## Support

For issues or questions:
1. Check [`SUPABASE_SETUP.md`](./SUPABASE_SETUP.md) for setup troubleshooting
2. Open a GitHub issue
3. Review SQL diagnostic scripts in the repo
