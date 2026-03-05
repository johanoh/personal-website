# Agent Guidelines for Personal Website

This document contains instructions for AI agents (and humans) working on this codebase.
It is intended to provide context on the environment, conventions, and workflows to ensure high-quality contributions.

## 1. Project Overview

- **Framework**: Ruby on Rails 8.0.1
- **Language**: Ruby 3.3.6
- **Database**: SQLite3
- **Frontend**: Hotwire (Turbo + Stimulus), Importmaps, Propshaft
- **Testing**: RSpec (Primary), Capybara (System tests)
- **Linting**: RuboCop (Omakase), Brakeman

## 2. Build & Run Commands

Always use the `bin/` wrappers where available to ensure the correct environment is used.

### Setup & Server
- **Setup**: `bin/setup`
  *Installs dependencies and sets up the database.*
- **Start Server**: `bin/dev` (or `bin/rails server`)
  *Starts the Puma server and any background processes.*
- **Console**: `bin/rails console`
  *Opens the Rails REPL.*

### Database Operations
- **Migrate**: `bin/rails db:migrate`
- **Seed**: `bin/rails db:seed`
- **Reset**: `bin/rails db:reset`
  *Drops, creates, migrates, and seeds the database.*

## 3. Testing & Linting

**Note**: The project uses `spec/` (RSpec) for testing. `test/` (Minitest) is present but not the primary suite.

### Running Tests (RSpec)
Always verify changes by running relevant tests.

- **Run All Specs**:
  ```bash
  bundle exec rspec
  ```

- **Run Specific File**:
  ```bash
  bundle exec rspec spec/models/blog_post_spec.rb
  ```

- **Run Specific Test (Line Number)**:
  ```bash
  bundle exec rspec spec/models/blog_post_spec.rb:15
  ```
  *Use this when fixing a specific bug or TDDing a feature.*

- **Run System Tests**:
  ```bash
  bundle exec rspec spec/system
  ```

### Testing Context & Gotchas
- **Fixtures**: The project uses `spec/fixtures` for test data.
- **Devise**: `Devise::Test::IntegrationHelpers` are included for request specs. Use `sign_in user` in tests.
- **Sitemaps**: `BlogPost#refresh_sitemap` is globally mocked in `rails_helper.rb` to prevent sitemap generation during tests.
  ```ruby
  # configured in spec/rails_helper.rb
  allow_any_instance_of(BlogPost).to receive(:refresh_sitemap).and_return(true)
  ```

### Linting & Security
Run these before committing code.

- **RuboCop**: `bin/rubocop`
  *Run `bin/rubocop -A` to auto-correct issues.*
- **Brakeman**: `bin/brakeman`
  *Static analysis for security vulnerabilities.*

## 4. Code Style & Conventions

Follow the existing conventions found in the codebase.

### Ruby / Rails
- **Style Guide**: Follow `rubocop-rails-omakase` defaults.
- **Naming**:
  - variables/methods: `snake_case`
  - classes/modules: `CamelCase`
  - constants: `SCREAMING_SNAKE_CASE`
- **Controllers**: Keep them thin. Move complex logic to Models or specialized Service objects.
- **Models**: Use Active Record validations and associations effectively.
- **Routes**: Use resourceful routing defined in `config/routes.rb`.
- **Views**: Use ERB (`.html.erb`). Keep logic minimal in views; use Helpers or ViewComponents if logic becomes complex.

### Frontend (Hotwire)
- **Architecture**: Server-side rendering with Turbo Frames and Turbo Streams for interactivity.
- **JavaScript**: Use Stimulus controllers located in `app/javascript/controllers/`.
  - Naming: `kebab-case` for file names and controller identifiers (e.g., `hello-controller.js` -> `data-controller="hello"`).
- **CSS**: Located in `app/assets/stylesheets/`.

### RSpec Guidelines
- **Syntax**: Use the `expect(...)` syntax.
- **Structure**:
  ```ruby
  RSpec.describe Post, type: :model do
    describe 'validations' do
      it { should validate_presence_of(:title) }
    end

    describe '#published?' do
      context 'when published_at is present' do
        it 'returns true' do
          # ...
        end
      end
    end
  end
  ```
- **Contexts**: Use `context` blocks to describe states (start with "when" or "with").
- **Cleanliness**: Do not leave `binding.pry` or `console.log` in committed code.

## 5. File System & Paths

When creating or referencing files, adhere to the Rails structure:

- `app/controllers/`: Controllers
- `app/models/`: ActiveRecord Models
- `app/views/`: View templates
- `app/javascript/`: JS entry points and controllers
- `app/assets/`: Images and Stylesheets
- `config/`: Configuration files (routes, database, etc.)
- `db/migrate/`: Database migrations
- `spec/`: Tests (mirrors `app/` structure)
  - `spec/models/`
  - `spec/requests/`
  - `spec/system/`
  - `spec/fixtures/`

## 6. Git & Workflow Rules

1.  **Atomic Commits**: Group related changes. Use clear commit messages.
2.  **Safety**: Never commit secrets or API keys. Check `config/master.key` usage.
3.  **Verification**: Always run tests and linter before marking a task as complete.
