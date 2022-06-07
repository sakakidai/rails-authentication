class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    max = 255
    if value.length > max
      record.errors.add(attribute, :too_long, count: max)
    end

    format = /\A\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*\z/
    unless format =~ value
      record.errors.add(attribute, :invalid)
    end

    if record.email_activated?
      record.errors.add(attribute, :taken) 
    end
  end
end