# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Development server
bin/dev

# Database
bin/rails db:create db:migrate db:seed

# Tests
bin/rails test                      # all tests
bin/rails test test/models/user_test.rb  # single test file

# Full CI pipeline (lint + security + tests)
bin/ci

# Linting
bin/rubocop
bin/rubocop -a                      # auto-fix

# Security
bin/bundler-audit
bin/brakeman -q
```

## Architecture

Rails 8.1 app (Ruby 3.3.5) for Les Blouses Roses — a volunteer management platform for hospital animators.

**Authentication**: Devise handles all user sessions. `ApplicationController` has `before_action :authenticate_user!` globally; `PagesController#home` is the only public page (root path). There is no authorization layer (no Pundit/CanCanCan) — controllers do not currently verify resource ownership.

**Domain model**:
- A `User` (Devise) has one `Profile` (personal info + role) and many `Permanences`
- `Profile` has `has_one_attached :photo` via Active Storage
- A `Permanence` is a recurring volunteer shift: it belongs to a `User` (organizer) and a `Location`, has many `Participations` (volunteers signing up) and `Reports` (post-shift summaries)
- `Participation` links a `User` to a `Permanence` for a given `week_number`; `substitute: true` marks fill-in volunteers
- `Participation#date` computes an actual `Date` from `permanence.year`, `week_number`, and `permanence.week_day` via `Date.commercial` + the `FRENCH_WEEKDAYS` constant (`"Lundi" => 1` … `"Dimanche" => 7`)
- `Participation.sorted_by_date_desc` eager-loads `permanence: :location`, sorts by `date`, and filters out past entries (`>= Date.today`)

**Non-obvious schema choices**:
- `permanences.start_time` / `end_time` are plain integers representing hours (e.g., `14` = 14h00), not timestamps
- `permanences.week_day` is a French string (`"Lundi"`, `"Mardi"`, …), not an enum or date
- `permanences.year` is an integer year (e.g., `2026`)
- `participations.week_number` and `reports.week_number` are integers 1–52 (ISO week number)
- `profile.role` is a free-form string; seed values are `"benevole en integration"`, `"benevole en formation"`, `"benevole confirmé"`, `"benevole référent"`

**Route state**: Only `profiles` and `participations` (with nested `reports`) are currently routed. `PermanencesController` and `LocationsController` exist as empty stubs with no routes yet. `participations` routes include `update` and `create`, but those controller actions are not yet implemented.

**Frontend**: Hotwire (Turbo + Stimulus) with Bootstrap 5 and Font Awesome. Forms use `simple_form` (loaded from GitHub HEAD, not rubygems). Assets compiled via Sprockets + importmap (no webpack/esbuild).

**Stylesheets** follow a flat import tree in [application.scss](app/assets/stylesheets/application.scss): `config/` (fonts, colors, bootstrap variables) → `bootstrap` → `components/` → `pages/`. Add page-specific styles in `pages/` and component styles in `components/`, then register in the respective `_index.scss`.

**Infrastructure**: Solid Queue (jobs), Solid Cache, and Solid Cable all use the main PostgreSQL database in development; production uses separate databases for each. Deployment via Kamal.

**Testing**: Minitest with fixtures, parallelized. Controller and model test stubs exist for all resources in `test/`.

## Seed data

`faker` gem is in the `development` group only — `db:seed` must run in development. Demo account created by the seed:

```
Email:    demo@blousesroses.fr
Password: password123
```
