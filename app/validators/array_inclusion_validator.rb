class ArrayInclusionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value && included?(value)
      record.errors.add(attribute, "#{value} is not included in the list")
    end
  end

  private

  def included?(value)
    (value - options[:in]).empty?
  end
end