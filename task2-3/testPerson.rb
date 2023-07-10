require_relative "person"
require 'test/unit'

class PersonTest < Test::Unit::TestCase
  def setup
    @person = Person.new('Anna', 'Maria', 'AA1234567890', '1999-11-01')
  end

  def test_first_name
    assert_equal('Anna', @person.first_name)
  end

  def test_last_name
    assert_equal('Maria', @person.last_name)
  end

  def test_inn
    assert_equal('AA1234567890', @person.inn)
  end

  def test_birth_date
    assert_equal('1999-11-01', @person.birth_date)
  end

  def test_invalid_first_name
    assert_raise(ArgumentError) { @person.first_name = 'Ahh@' }
  end

  def test_invalid_last_name
    assert_raise(ArgumentError) { @person.last_name = 'Mar1a' }
  end

  def test_invalid_inn
    assert_raise(ArgumentError) { @person.inn = 'AA238667890' }
  end

  def test_invalid_birth_date
    assert_raise(ArgumentError) { @person.birth_date = '2002/12/23' }
  end
end