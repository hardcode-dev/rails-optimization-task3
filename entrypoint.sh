#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /rails-optimization-task3/tmp/pids/server.pid

whenever --update-crontab

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"
