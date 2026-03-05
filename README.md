# Personal Website

A Ruby on Rails 8 personal website with blog, project showcase, and contact form.

## Requirements

- Ruby 3.3.6
- SQLite3 3.8.0+
- Node.js (for asset pipeline)

## Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd personal-website
```

2. Install dependencies:
```bash
bundle install
```

3. Set up the database:
```bash
bin/rails db:create db:migrate
```

4. Set up environment variables (optional):
Create `config/credentials.yml.enc` or set the following environment variables:
- `ADMIN_ALLOWED_IPS` - Comma-separated list of IPs allowed to access admin panel (defaults to 127.0.0.1)

5. Start the server:
```bash
bin/dev
```

Visit http://localhost:3000

## Configuration

### Admin Access

Admin routes are IP-restricted for security. Configure allowed IPs in:
- `config/credentials.yml.enc`: `admin:allowed_ips`
- Or via environment variable (not yet implemented, see config/application.rb)

The first admin can be created via console:
```bash
bin/rails console
Admin.create!(email: "admin@example.com", password: "yourpassword")
```

### Sitemap

The sitemap is automatically generated when blog posts are created/updated/destroyed.
To manually refresh:
```bash
bin/rails sitemap:refresh
```

## Running Tests

```bash
bundle exec rspec
```

## Linting & Security

```bash
bin/rubocop              # Check code style
bin/rubocop -A           # Auto-fix issues
bin/brakeman             # Security scan
bin/importmap audit      # JS dependency audit
```

## Deployment

This application is configured for deployment with Kamal. See `.kamal/` directory for configuration.

CI/CD is handled via GitHub Actions (`.github/workflows/`):
- Automated testing on PRs
- Security scanning (Brakeman, importmap audit)
- Linting checks
- Auto-deployment on main branch merges

## Features

- **Blog**: Markdown-based posts with tagging, scheduling, and SEO-friendly URLs
- **Admin Panel**: IP-restricted access for managing content
- **Projects**: Static project showcase pages
- **Contact Form**: Email integration with spam protection (Rack::Attack)
- **Sitemap**: Auto-generated XML sitemap for search engines
- **Hotwire**: Turbo + Stimulus for SPA-like interactions

## Project Structure

```
app/
  controllers/
    admin_panel/     # Admin dashboard and blog management
    blog.rb          # Public blog views
    contact.rb       # Contact form handling
    projects.rb      # Project showcase
  models/
    blog_post.rb     # Blog posts with slug-based URLs
    tag.rb           # Tagging system
    admin.rb         # Devise authentication
  views/             # ERB templates
  jobs/              # Background jobs (sitemap refresh)

spec/                # RSpec test suite
config/
  sitemap.rb         # Sitemap configuration
```
