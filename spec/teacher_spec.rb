require './teacher'

describe Teacher do
  let(:teacher) { Teacher.new(40, 'Math', 'Mane') }
  context 'when creating a new teacher' do
    it 'has a specialization' do
      expect(teacher.specialization).to eq('Math')
    end
    it 'has an age' do
      expect(teacher.age).to eq(40)
    end
    it 'has a name' do
      expect(teacher.name).to eq('Mane')
    end
  end
end
