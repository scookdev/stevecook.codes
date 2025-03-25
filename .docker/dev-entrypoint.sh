#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails
rm -f /rails/tmp/pids/server.pid

# Add bundle's bin directory to PATH
export PATH="$BUNDLE_PATH/bin:$PATH"

# Wait for the database to be ready
until pg_isready -h db -U postgres -q; do
  echo "Waiting for database..."
  sleep 2
done

# Check if the database exists using a SQL query
if bundle exec rails runner "ActiveRecord::Base.connection" >/dev/null 2>&1; then
  echo "Database exists, running migrations..."
  bundle exec rails db:migrate
else
  echo "Database doesn't exist, creating and setting up..."
  bundle exec rails db:prepare
fi

# Then exec the container's main process (what's set as CMD in the Dockerfile)
exec "$@"
