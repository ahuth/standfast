# Standfast

Collect and share status reports via email.

## Prerequisites

1. [Ruby 2.3.3](https://www.ruby-lang.org/en/)
2. [Bundler 1.13.6](http://bundler.io/)
3. [Node 7.2+](https://nodejs.org/en/)
4. [Yarn 0.17+](https://yarnpkg.com/)
5. [PostgreSQL 9.6](https://www.postgresql.org/)
6. (Recommended) [rbenv](https://github.com/rbenv/rbenv) and [rbenv-gemset](https://github.com/jf/rbenv-gemset)

## Installation

Run `bundle install` to install the Ruby dependencies. Then run `yarn install` to install the Javascript dependencies.

Setup the database with `rake db:setup`. This command creates the database, loads the schema, and seeds the data.

Finally, run the app with `rails s`.

## Linting

Run all linters with `rake lint`. You can also run `rake lint:ruby`, `rake lint:js`, or `rake lint:style` for only the back end, front end, or styles.

## Testing

Run the Ruby tests with `rspec` and the Javascript tests with `yarn test`.
