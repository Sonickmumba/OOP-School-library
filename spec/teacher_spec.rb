require './teacher'

describe Teacher do
  before :each do
    @teacher = Teacher.new(40, 'Math', 'Mane', parent_permission: true)
  end

  it 'Teacher name should be Mane' do
    expect(@teacher.name).to eq('Mane')
    expect(@teacher.name).not_to eq('John')
    expect(@teacher.age).to be > 20
  end

  it 'Teacher can use services' do
    expect(@teacher.can_use_service?).to be true
  end
end
