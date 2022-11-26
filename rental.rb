class Rental
  attr_accessor :date, :book, :person, :rentals

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    @rentals = []
    book.rentals.push(self) unless book.rentals.include?(self)
    person.rentals.push(self) unless person.rentals.include?(self)
  end
end
