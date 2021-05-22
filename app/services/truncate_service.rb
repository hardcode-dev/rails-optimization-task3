# frozen_string_literal: true

class TruncateService < ApplicationService
  def call
    # [2..-1] skip schema_migrations and ar_internal_metadata
    ActiveRecord::Base.connection.execute("TRUNCATE #{ActiveRecord::Base.connection.tables[2..-1].join(', ')};")
  end
end