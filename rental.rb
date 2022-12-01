# require './person'
# require './book'

class Rental
  attr_accessor :date, :book, :person, :rentals

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    @rentals = []
    person.rentals << self
    book.rentals << self
  end

  def create_json
    {
      date: @date,
      id: @person.id,
      bookObj: { title: @book.title, author: @book.author },
      personObj: { age: @person.age, name: @person.name }
    }
  end
end
