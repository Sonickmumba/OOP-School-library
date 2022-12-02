require './person'

describe Person do
  let(:person) { Person.new(30, 'Soni') }
  context 'when creating a new person' do
    it 'has an age' do
      expect(person.age).to eq(30)
    end
    it 'has a name' do
      expect(person.name).to eq('Soni')
    end
  end
end
