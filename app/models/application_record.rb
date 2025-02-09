class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.enum_from_array(array)
    array.index_by(&:to_sym)
  end
end
