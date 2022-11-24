require './person'
require './capitalize_decorator'
require './trimmer_decorator'

person = Person.new(22, name: 'maximilianus')
puts person.correct_name
puts person.can_use_services?
capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name

 # puts person.correct_name