# Page Scrapper Eduardo

A modern Rails 8 web application to scrape pages and extract links, built with:

- ✅ Devise for user authentication
- ✅ Turbo + Stimulus (Hotwire) for interactivity
- ✅ Sidekiq for background jobs
- ✅ SQLite for local database
- ✅ TailwindCSS for styling
- ✅ Kaminari for pagination
- ✅ Minitest + Capybara for testing

---

## 🚀 Requirements

- Ruby 3.4.4
- Rails 8.0.2
- Node.js (for Tailwind)
- Redis (for Sidekiq)

---

## 🔧 Setup Instructions

### 1. Clone the repository

```bash
git clone https://github.com/your_username/page_scrapper_eduardo.git
cd page_scrapper_eduardo
```

### 2. Install dependencies

```bash
bundle install
```

### 3. Install JavaScript dependencies (for Tailwind)
```bash
bin/importmap
bin/rails tailwindcss:install
```

### 4. Set up the database
```bash
bin/rails db:setup
```
This creates, migrates, and seeds the SQLite database.

### 5. Start Redis (required for Sidekiq)
If installed via Homebrew:
```bash
brew services start redis
```
Or manually:

```bash
redis-server
```

## 🧪 Running the App

### Start Rails server:
```bash
bin/rails server
```

### Start Sidekiq (for background jobs):
```bash
bundle exec sidekiq
```

## 🔐 Admin & Auth
Devise is used for user authentication.
Only authenticated users can access the scraping interface.
Sidekiq web UI is mounted at /sidekiq and protected by Devise:
```bash
http://localhost:3000/sidekiq
```

## 🧪 Testing

### Run all tests:
```bash
bin/rails test
```

### Run system tests (Capybara):
```bash
bin/rails test:system
```

Tests use:

DatabaseCleaner for isolation

Capybara with rack_test (or switch to selenium_chrome_headless)

Devise::Test::IntegrationHelpers for login during integration tests

## ⚙️ Core Features
Submit a URL → background job (ScrapePageJob) fetches the HTML.

Extracts links (<a href="">) with visible text.

Displays results paginated (Kaminari).

Turbo Streams update list in real-time on creation.

Rescan feature to re-run scraping.

## 📦 Tech Stack Summary
Feature	Tool
Language	Ruby 3.4.4
Framework	Rails 8.0.2
CSS	TailwindCSS
Auth	Devise
Jobs	Sidekiq
Pagination	Kaminari
DB	SQLite (dev/test)
JavaScript	Hotwire (Turbo + Stimulus)
Testing	Minitest, Capybara
## 🧠 Notes
TailwindCSS is used via tailwindcss-rails.

Asset pipeline uses propshaft.

Paginates ScrapedPage and its links.

ScrapePageJob uses Nokogiri to parse HTML and extract links.

