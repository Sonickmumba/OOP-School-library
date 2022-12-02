require './classroom'

describe Classroom do
  let(:classroom) { Classroom.new('60') }
  context 'creating a new classroom' do
    it 'has a label' do
      expect(classroom.label).to eq('60')
    end
  end
end
