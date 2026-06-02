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

**Authentication**: Devise handles all user sessions. `ApplicationController` has `before_action :authenticate_user!` globally; `PagesController#home` is the only public page (root path).

**Domain model**:
- A `User` (Devise) has one `Profile` (personal info + role) and many `Permanences`
- A `Permanence` is a recurring volunteer shift: it belongs to a `User` (organizer) and a `Location`, has many `Participations` (volunteers signing up) and `Reports` (post-shift summaries)
- `Participation` links a `User` to a `Permanence` for a given `week_number`; `substitute: true` marks fill-in volunteers

**Frontend**: Hotwire (Turbo + Stimulus) with Bootstrap 5 and Font Awesome. Forms use `simple_form`. Assets compiled via Sprockets + importmap (no webpack/esbuild).

**Stylesheets** follow a flat import tree in [application.scss](app/assets/stylesheets/application.scss): `config/` (fonts, colors, bootstrap variables) → `bootstrap` → `components/` → `pages/`. Add page-specific styles in `pages/` and component styles in `components/`, then register in the respective `_index.scss`.

**Infrastructure**: Solid Queue (jobs), Solid Cache, and Solid Cable all use the main PostgreSQL database in development; production uses separate databases for each. Deployment via Kamal.

**Testing**: Minitest with fixtures, parallelized. Controller and model test stubs exist for all resources in `test/`.
