# Use TDD principles to build out name functionality for a Person.
# Here are the requirements:

# - Add a method to return the full name as a string. A full name includes
#   first, middle, and last name. If the middle name is missing, there shouldn't
#   have extra spaces.

# - Add a method to return a full name with a middle initial. If the middle name
#   is missing, there shouldn't be extra spaces or a period.

# - Add a method to return all initials. If the middle name is missing, the
#   initials should only have two characters.
#
# We've already sketched out the spec descriptions for the #full_name. Try
# building the specs for that method, watch them fail, then write the code to
# make them pass. Then move on to the other two methods, but this time you'll
# create the descriptions to match the requirements above.

class Person
  attr_reader :first_name, :middle_name, :last_name

  def initialize(first_name:, middle_name: nil, last_name:)
    @first_name = first_name
    @middle_name = middle_name
    @last_name = last_name
  end

  # removes names with nil values
  def clean_name
    [first_name, middle_name, last_name].compact
  end

  def full_name
    clean_name.join(' ')
  end

  def initials
    clean_name.map(&:chr).join('')
  end

  def full_name_with_middle_initial
    if clean_name.size == 3
      first_name + ' ' + middle_name.chr + '. ' + last_name
    else
      full_name # clean_name gets repeated
    end
  end
end

RSpec.describe Person do
  let(:person) {Person.new(first_name: 'Oscar', middle_name: 'M', last_name: 'Romero')}
  let(:person_no_middle_name) {Person.new(first_name: 'Oscar', last_name: 'Romero')}

  describe "#full_name" do
    it "concatenates first name, middle name, and last name with spaces" do
      expect(person.full_name).to eq('Oscar M Romero')
    end

    it "does not add extra spaces if the middle name is missing" do
      expect(person_no_middle_name.full_name).to eq('Oscar Romero')
    end
  end

  describe "#full_name_with_middle_initial" do
    it 'returns a string with the first and last names concatenated, with the middle name as an initial with a period' do
      expect(person.full_name_with_middle_initial).to eq('Oscar M. Romero')
    end

    it 'returns a string with only the first and last names concatenated if the middle name is missing' do
      expect(person_no_middle_name.full_name_with_middle_initial).to eq('Oscar Romero')
    end
  end

  describe "#initials" do
    it 'returns a string with the first char of each subname' do
      expect(person.initials).to eq('OMR')
    end

    it 'returns a string with the first char of each subname without the middle initial if the middle name is missing' do
        expect(person_no_middle_name.initials).to eq('OR')
    end

    it 'it returns a string with a length of three if the middle initial not missing' do
      expect(person.initials.length).to eq(3)
    end

    it 'it returns a string with a length of two if the middle initial is missing' do
      expect(person_no_middle_name.initials.length).to eq(2)
    end
  end
end
