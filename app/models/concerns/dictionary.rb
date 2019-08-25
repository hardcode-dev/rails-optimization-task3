# frozen_string_literal: true

module Dictionary
  class NoRecord < RuntimeError; end

  extend ActiveSupport::Concern

  module ClassMethods

    def [](key_s)
      key = key_s.to_sym
      cached[key] if cached.key?(key)
    end

    def cached
      @cached ||= get_cached_by_names
      return @cached unless cache_expired?

      @cached = get_cached_by_names
    end

    def all_cached
      cached_by_id.values
    end

    def cached_by_id
      return @cached_by_id unless cache_expired?

      @cached_by_id = select([:id, :name]).order(:id).index_by(&:id).each do |_, val|
        [:id, :name].each { |attr| val.public_send(attr).freeze }
        val.freeze
      end.freeze

      @cached_at = Time.current
      @cached_by_id
    end

    def cache_expired?
      !(@cached_at && Time.current - @cached_at <= 15.minutes)
    end

    def get_cached_by_names
      cached_by_id.values.select { |row| row.name.present? }.index_by { |row| row.name.to_sym }.freeze
    end
  end
end
