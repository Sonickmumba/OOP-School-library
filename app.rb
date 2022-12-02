require './person'
require './student'
require './teacher'
require './classroom'
require './book'
require './data_store'
require './rental'
require 'json'

# rubocop:disable all
class App
  attr_accessor :people, :books, :rentals

  def initialize
    @book = []
    @people = []
    @rentals = []
    @people_file = DataStore.new('person')
    @people = @people_file.read.map do |pn|
      if pn['type'] == 'Student'
        Student.new(pn['classroom'], pn['age'], pn['name'], parent_permission: pn['parent_permission'])
      else
        Teacher.new(pn['age'], pn['specialization'], pn['name'], parent_permission: pn['parent_permission'])
      end
    end
    @book_file = DataStore.new('book')
    @book = @book_file.read.map { |book| Book.new(book['title'], book['author']) }
    @rentals_file = DataStore.new('rentals')
    def result(para)
      if para['personObj']['type'] == 'Student'
        Student.new(para['personObj']['classroom'], para['persObj']['age'], para['persObj']['name'], parent_permission: para['persObj']['parent_permission'])
      else
        Teacher.new(para['personObj']['specialization'], para['personObj']['age'], para['personObj']['name'], parent_permission: para['personObj']['parent_permission'])
      end
    end
    @rentals = @rentals_file.read.map do |rentals|
      Rental.new(rentals['date'], Book.new(rentals['bookObj']['title'], rentals['bookObj']['author']), result(rentals))
    end
  end

  def choose_action
    option = gets.chomp
    case option
    when '1'
      list_books
    when '2'
      list_people
    when '3'
      create_person
    when '4'
      create_book
    when '5'
      create_rental
    when '6'
      list_rentals_for_person_id
    when '7'
      puts 'File successfully saved'
      puts 'Thank you for using this app!'
      close_app
      exit 0
    end
  end

  def create_person
    print 'Do you want to create a student (1) or a teacher (2)? [Input the number]: '
    person_category = gets.chomp
    case person_category
    when '1'
      create_student
    when '2'
      create_teacher
    else
      puts 'Invalid input'
    end
  end

  def create_teacher
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Specialization: '
    specialization = gets.chomp
    @people.push(Teacher.new(age, specialization, name, parent_permission: true))
    puts 'Teacher created successfully'
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @book.push(Book.new(title, author))
    puts 'Book created successfully'
  end

  def create_student
    print 'Age: '
    age = gets.chomp
    print 'Name: '
    name = gets.chomp
    print 'Class room: '
    classroom = gets.chomp
    print 'Has parent permission? [Y/N]: '
    parent_permission = gets.chomp.downcase
    case parent_permission
    when 'y'
      @people.push(Student.new(classroom, age, name, parent_permission: true))
    when 'n'
      @people.push(Student.new(classroom, age, name, parent_permission: false))
    else
      puts 'Invalid input'
    end
    puts 'Student created successfully'
  end

  def create_rental
    puts 'Select a book from the following list by number'
    @book.each_with_index do |book, index|
      puts "#{index}) Title: #{book.title}, Author: #{book.author}"
    end
    book_index = gets.chomp
    puts 'Select a person from the following list by number (not id)'
    @people.each_with_index do |person, index|
      puts "#{index}) [#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
    person_index = gets.chomp
    print 'Date: '
    date = gets.chomp
    @rentals.push(Rental.new(date, @book[book_index.to_i], @people[person_index.to_i]))
    puts 'Rental successfully created'
  end

  def list_books
    if @book.empty?
      puts 'No books in store'
    else
      @book.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    end
  end

  def list_people
    if @people.empty?
      puts 'No people found'
    else
      @people.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    end
  end

  def list_rentals_for_person_id
    print 'ID of person: '
    id = gets.chomp.to_i
    puts 'Rentals: '
    @rentals.each do |rental|
      if rental.person.id == id
        puts "Date: #{rental.date}, Book: #{rental.book.title} by #{rental.book.author}"
      else
        puts 'No rentals found for that ID'
      end
    end
  end

  def start_app
    loop do
      puts
      welcome
      choose_action
    end
  end

  def close_app
    @book_file.write(@book.map(&:create_json))
    @people_file.write(@people.map(&:create_json))
    @rentals_file.write(@rentals.map(&:create_json))
  end
end
# rubocop:disable all
