# frozen_string_literal: true

# Only dump the schema when adding a new migration
ActiveRecord::Base.dump_schema_after_migration = Rails.env.development? &&
  `git status db/migrate/ --porcelain`.present?

# Analyze tables automatically (to update planner statistics) after an index is added.
StrongMigrations.auto_analyze = true
