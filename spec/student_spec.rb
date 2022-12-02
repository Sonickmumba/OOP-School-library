require './student'

describe Student do
  let(:student) { Student.new('Classroom', 20, 'Sonka') }

  it 'has an age' do
    expect(student.name).to eq(20)
  end

  it 'has a name' do
    expect(student.age).to eq('Sonka')
  end
end
