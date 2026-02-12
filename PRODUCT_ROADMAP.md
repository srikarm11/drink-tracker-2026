# Drink Tracker 2026 — Product Roadmap

**Last Updated:** Feb 12, 2026
**Current Version:** v2.0.0
**Vision:** Simple, fast drink tracking with calorie and cost monitoring for personal health awareness.

---

## 🎯 MVP Features (v2.0.0) — ✅ COMPLETE

- [x] User authentication (email/password via Supabase)
- [x] Row-level security for multi-user data isolation
- [x] 50+ drink database with name variations
- [x] Add/edit/delete drinks
- [x] Mobile-responsive design
- [x] Basic drink entry flow

---

## 🔥 v2.1.0 — Calorie Tracking (NEXT RELEASE)

**Goal:** Enable users to see total calories consumed per session, day, week, and month.

### Priority 1: Display Calorie Data

**Issue:** Calorie data exists in the drinks database but is not displayed or tracked.

**Tasks:**
1. **Display calories per drink**
   - Show calorie count on each drink card/row
   - Format: "125 cal" or similar
   - Pull from existing `DRINKS_DATABASE_SEED` calorie values

2. **Session total calories**
   - Calculate total calories for current drinking session
   - Display prominently at top of UI
   - Real-time updates as drinks are added

3. **Daily calorie totals**
   - Show total calories consumed today
   - Compare to previous days
   - Visual indicator (progress bar or chart?)

4. **Weekly/monthly views**
   - Aggregate calorie data by week and month
   - Simple bar chart or line graph
   - Identify high-consumption periods

**Technical Notes:**
- Calorie data already exists in seed data (lines 47-100+ in index.html)
- Need to ensure drinks table has calorie column populated
- May need to migrate seed data to `drinks_database` table in Supabase

**Success Criteria:**
- [ ] Calorie count visible on every drink entry
- [ ] Session total displayed and updates in real-time
- [ ] Daily total view accessible
- [ ] Weekly/monthly aggregation available

**Estimated Effort:** 2-3 hours

---

## 🚀 v2.2.0 — Cost Tracking

**Goal:** Track spending on drinks to increase financial awareness.

### Features:
1. **Cost per drink**
   - Optional cost field when adding drinks
   - Default to null if not entered
   - Display on drink cards

2. **Session total cost**
   - Calculate total spent in current session
   - Display next to calorie total

3. **Daily/weekly/monthly spend**
   - Aggregate spending over time
   - Compare to budgets (optional)
   - Identify expensive habits

4. **Average cost per category**
   - Show average cost for Beer vs Wine vs Cocktails
   - Help identify most expensive drink types

**Technical Notes:**
- `cost` column already exists in database schema
- Currently set to `null` in seed data
- Need UI for cost entry (text input, number pad)

**Success Criteria:**
- [ ] Cost entry available when adding drinks
- [ ] Session cost total displayed
- [ ] Daily/weekly/monthly spending reports
- [ ] Average cost per category calculated

**Estimated Effort:** 3-4 hours

---

## 💡 v3.0.0 — Advanced Analytics

**Goal:** Provide deeper insights into drinking habits and trends.

### Features:
1. **Drinking patterns**
   - Identify most common drinking days (e.g., Fridays/Saturdays)
   - Time-of-day trends
   - Seasonal patterns

2. **Favorite drinks**
   - Top 10 most consumed drinks
   - Category breakdown (% beer vs wine vs cocktails)
   - Calorie efficiency (lowest calorie drinks)

3. **Goals & limits**
   - Set weekly calorie limits
   - Set monthly spending limits
   - Visual progress toward goals
   - Notifications when approaching limits

4. **Streaks & milestones**
   - Longest streak without drinking
   - Total drinks logged
   - Total calories consumed (all-time)
   - Gamification elements

**Success Criteria:**
- [ ] Pattern analysis implemented
- [ ] Favorites view created
- [ ] Goal-setting UI built
- [ ] Streak tracking functional

**Estimated Effort:** 8-10 hours

---

## 🎨 v3.1.0 — UX Improvements

### Features:
1. **Quick-add favorites**
   - Pin frequently consumed drinks
   - One-tap add from favorites
   - Reorder favorites

2. **Custom drinks**
   - Add drinks not in database
   - Save custom calorie/cost data
   - Edit drink database

3. **Dark mode**
   - Toggle dark/light theme
   - Persist preference in localStorage

4. **Export data**
   - Download drink history as CSV
   - Export for analysis in Excel/Sheets
   - Privacy-first data portability

5. **Undo/edit recent entries**
   - Quick undo last drink added
   - Edit timestamp of entry
   - Fix mistakes easily

**Success Criteria:**
- [ ] Favorites system implemented
- [ ] Custom drink creation works
- [ ] Dark mode functional
- [ ] CSV export available
- [ ] Undo last entry button

**Estimated Effort:** 6-8 hours

---

## 🔧 Technical Debt & Improvements

### High Priority
- [ ] Migrate `DRINKS_DATABASE_SEED` to Supabase `drinks_database` table
- [ ] Add loading states for async operations
- [ ] Error handling for network failures
- [ ] Form validation on drink entry

### Medium Priority
- [ ] Split index.html into components (if project grows)
- [ ] Add unit tests for core functions
- [ ] Optimize bundle size (currently loading entire React via CDN)
- [ ] Add service worker for offline support

### Low Priority
- [ ] Migrate from CDN React to bundled version
- [ ] Add TypeScript for type safety
- [ ] Set up CI/CD pipeline
- [ ] Add E2E tests with Playwright

---

## 🧪 Feature Ideas (Backlog)

### Social Features
- Share drink sessions with friends
- Compare consumption with friends (privacy-optional)
- Group session tracking for nights out

### Health Integrations
- Apple Health export
- Integration with fitness apps
- Hydration tracking (water between drinks)

### Gamification
- Badges for milestones
- Leaderboards (opt-in)
- Challenges (e.g., "sober week")

### Smart Features
- Drink recommendations based on calorie budget
- Budget-friendly drink suggestions
- Location tagging (which bar/restaurant)

---

## Decision Log

### Why single-file HTML app?
- **Fast iteration**: No build step, instant feedback
- **Simple deployment**: Static hosting anywhere
- **Low complexity**: Easy to understand and modify
- **Good enough**: For personal use, performance is fine

### When to refactor?
Consider refactoring to a proper build system when:
- File exceeds 10,000 lines
- Multiple contributors join
- Need proper testing infrastructure
- Performance becomes an issue

### Why Supabase?
- **Free tier**: Generous limits for personal projects
- **Auth built-in**: No need to roll own authentication
- **RLS**: Database-level security out of the box
- **Fast setup**: Under 30 minutes to production

---

## Success Metrics

### User Engagement (Personal Use)
- Track drinks at least 3x per week
- Use app consistently for 3+ months
- Find insights valuable for behavior change

### Technical Performance
- Page load under 2 seconds
- Zero data loss
- 99%+ uptime (Supabase reliability)

### Product Goals
- v2.1 (calorie tracking) shipped by **end of Feb 2026**
- v2.2 (cost tracking) shipped by **mid-March 2026**
- v3.0 (analytics) shipped by **end of March 2026**

---

## Questions & Open Decisions

1. **Should we add a drink database table in Supabase?**
   - Currently drinks are hardcoded in seed data
   - Pros: Easier to update, no code changes
   - Cons: Extra complexity, migration needed

2. **How to handle drink variations?**
   - e.g., "IPA" could be 180-250 calories depending on brewery
   - Option: Allow users to override calorie values
   - Option: Show calorie ranges instead of fixed values

3. **Privacy concerns with cost tracking?**
   - Some users may not want to track spending
   - Should cost tracking be opt-in?
   - How to make it feel non-judgmental?

4. **Should we build a PWA?**
   - Pros: Install to home screen, offline support
   - Cons: Extra complexity, service worker management
   - Decision: Wait until v3.0 to evaluate

---

## How to Contribute to This Roadmap

This roadmap is a living document. Update it when:
- Completing features (move to "Done" section)
- Discovering new requirements
- Changing priorities based on usage
- Learning new technical constraints

Keep the roadmap honest and realistic. Ship working features incrementally rather than planning too far ahead.
