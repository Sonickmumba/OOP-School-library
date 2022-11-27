require './person'
require './student'
require './teacher'
require './classroom'
require './book'
require './rental'

class App
  attr_accessor :people, :books, :rentals

  def initialize
    @people = []
    @book = []
    @rentals = []
  end

  def welcome
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all people'
    puts '3 - Create a person'
    puts '4 - Create a book'
    puts '5 - Create a rental'
    puts '6 - List all rentals for a given person id'
    puts '7 - Exit'
  end

  def quit_app
    puts 'Thank you for using this app!'
    exit 0
  end

  # rubocop:disable Metrics/CyclomaticComplexity
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
      quit_app
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
    puts
    welcome
    choose_action
  end

  def create_book
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    @book.push(Book.new(title, author))
    puts 'Book created successfully'
    puts
    welcome
    choose_action
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
    puts
    welcome
    choose_action
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
    puts 'Rental created successfully'
    puts
    welcome
    choose_action
  end

  def list_books
    if @book.empty?
      puts 'No books in store'
    else
      @book.each { |book| puts "Title: #{book.title}, Author: #{book.author}" }
    end
    puts
    welcome
    choose_action
  end

  def list_people
    if @people.empty?
      puts 'No people found'
    else
      @people.each { |person| puts "[#{person.class}] Name: #{person.name}, ID: #{person.id}, Age: #{person.age}" }
    end
    puts
    welcome
    choose_action
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
    puts
    welcome
    choose_action
  end
end

# rubocop:enable Metrics/CyclomaticComplexity
