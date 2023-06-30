require 'date'

module Validation
    def self.valid_name?(str)
      return false if str.nil? || str.empty? || str.length > 40
  
      words = str.split("-")
      return false unless words.all? { |word| word == word.capitalize && word.match?(/^([A-Z]{1}[a-z]*|[А-ЯІЇЄҐ]{1}[а-яіїєґ]*)$/) }
      return false if words.size <= 1 && str.include?("-")
  
      true
    end
  
    def self.valid_inn?(str)
      /[A-Z]{2}\d{10}$/ === str
    end
  
    def self.after_date?(date)
        date <= Date.today
      end
    end

puts Validation.valid_name?("Anna")
puts Validation.valid_name?("Anna-Maria")
puts Validation.valid_name?("Каріна-Ірина")
puts Validation.valid_inn?("AZ1234543456")
puts Validation.after_date?(Date.today.prev_day)

puts Validation.valid_name?("An-")
puts Validation.valid_name?("-")
puts Validation.valid_name?("aN")
puts Validation.valid_name?("AnnA")

puts Validation.valid_inn?("AЯ6787787654")
puts Validation.valid_inn?("az1234567898")
puts Validation.valid_inn?("5676567656AZ")
puts Validation.valid_inn?("AZ78987")

