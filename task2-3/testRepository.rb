require_relative "personRepository"
require_relative "person"
require 'test/unit'




class PersonRepositoryTest < Test::Unit::TestCase
  def setup
    @repository = PersonRepository.new
    @person1 = Person.new('Adam', 'Smith', 'BB1234567890', '1995-03-15')
    @person2 = Person.new('Eve', 'Johnson', 'BB0987654321', '1988-09-20')
    @repository.add_person(@person1)
  end

  def test_add_person
    person3 = Person.new('Alex', 'Brown', 'BB1357924680', '1990-07-10')
    @repository.add_person(person3)
    assert_equal(2, @repository.get_all.length)
    assert_includes(@repository.get_all, person3)
  end

  def test_add_existing_person
    assert_raise(ArgumentError) { @repository.add_person(@person1) }
  end

  def test_add_invalid_person
    assert_raise(ArgumentError) { @repository.add_person('Invalid Person') }
  end

  def test_edit_person_by_inn
    new_first_name = "Updated"
    new_last_name = "Name"
    new_birth_date = "2000-12-31"
    edited_inn = "BB1234567890"
    new_person = Person.new(new_first_name, new_last_name, edited_inn, new_birth_date)
    @repository.edit_person_by_inn("BB1234567890", new_person)
    updated_person = @repository.get_by_inn("BB1234567890")
    assert_equal(new_first_name, updated_person.first_name)
    assert_equal(new_last_name, updated_person.last_name)
    assert_equal(Date.parse(new_birth_date), updated_person.birth_date)
  end

  def test_edit_nonexistent_person
    assert_raise { @repository.edit_person_by_inn('nonexistent_inn', 'New', 'Person', '1999-06-15') }
  end

  def test_delete_person_by_inn
    assert_raise { @repository.delete_person_by_inn('BB1234567890') }
  end

  def test_delete_nonexistent_person
    assert_raise { @repository.delete_person_by_inn('nonexistent_inn') }
  end

  def test_get_all
    assert_equal([@person1], @repository.get_all)
  end

  def test_get_by_inn
    assert_equal(@person1, @repository.get_by_inn('BB1234567890'))
  end

  def test_get_by_inn_nonexistent
    assert_nil(@repository.get_by_inn('nonexistent_inn'))
  end

  def test_get_by_part_name
    matching_people = @repository.get_by_part_name('Ad')
    assert_equal([@person1], matching_people)

    non_matching_people = @repository.get_by_part_name('Xyz')
    assert_empty(non_matching_people)
  end

  def test_get_by_date_range
    date_from = '1980-01-01'
    date_to = '1995-12-31'
    people_in_range = @repository.get_by_date_range(date_from, date_to)
    assert_equal([@person1], people_in_range)

    date_from = '1990-01-01'
    date_to = '2000-12-31'
    people_in_range = @repository.get_by_date_range(date_from, date_to)
    assert_equal([@person1], people_in_range)

    date_from = nil
    date_to = '1989-12-31'
    people_in_range = @repository.get_by_date_range(date_from, date_to)
    assert_empty(people_in_range)

    date_from = '1990-01-01'
    date_to = nil
    people_in_range = @repository.get_by_date_range(date_from, date_to)
    assert_equal([@person1], people_in_range)

    date_from = nil
    date_to = nil
    all_people = @repository.get_by_date_range(date_from, date_to)
    assert_equal([@person1], all_people)
  end
end