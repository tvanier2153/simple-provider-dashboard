# simple-provider-dashboard

A minimal Ruby on Rails application skeleton for a simple provider dashboard.

## Getting started

Prerequisites: Ruby version from `.ruby-version` (`ruby -v` to check).

```sh
bundle install # once to start, and then every time Gemfile is updated
bin/rails db:prepare # creates DB, runs migrations, and seeds (idempotent — safe to re-run anytime)
bin/rails server
```

## Run Queries of interest

```sh
bin/rails c # enter the rails console
Client.for_provider(some_provider_id) # All clients for a given provider
Provider.for_client(some_client_id) # All providers for a given client
HealthJournalEntry.for_client(some_client_id).newest_first # All journal entries for a given client, sorted by date DESC (oldest_first for ASC)
HealthJournalEntry.for_provider(some_provider_id).newest_first # All journal entries across all clients of a given provider, sorted by date DESC
```

## Run tests

```sh
bin/rails test
```
