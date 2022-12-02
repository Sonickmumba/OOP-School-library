require './book'

describe Book do
  before :each do
    @book = Book.new('The other Woman', 'Daniel Steel')
  end

  it 'Book title should be The other Woman' do
    expect(@book.title).to eq('The other Woman')
  end

  it 'Book author should be Daniel Steel' do
    expect(@book.author).to eq('Daniel Steel')
  end

  it '@book need to be an instance of Book' do
    expect(@book).to be_instance_of(Book)
  end
end
