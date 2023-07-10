require "date"

module Validation
  MAX_NAME_LENGTH = 40
  
  NAME_REGEX = /^(?=.{1,30}$)(\p{Lu}\p{Ll}*(-\p{Lu}\p{Ll}*)*)$/
  INN_REGEX = /\A[A-Z]{2}\d{10}\z/

  def valid_name?(str)
    str.match?(NAME_REGEX)
  end

  def valid_inn?(str)
    str.match?(INN_REGEX)
  end

  def after_date?(date)
    date <= Date.today
  end
end