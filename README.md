## Standfast

Aggregate and share status reports via email

### Prerequisites

1. Ruby 2.3.3
2. Node 7.2
3. Yarn 0.17.9
4. PostgreSQL 9.6

### Installation

Run `bundle install` to install the Ruby dependencies. Then run `yarn install` to install the Javascript dependencies.

Setup the database with `rake db:create db:schema:load db:seed`.

Finally, run the app with `rails s`.

### Linting

Run all linters with `rake lint`. Additionally, you can run `rake lint:rubocop` or `rake lint:eslint` for only the back end or front end ones respectively.

### Testing

Run the Ruby tests with `rspec`. Run the Javascript tests with `yarn test`.
