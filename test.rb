require './capitalize_decorator'
require './trimmer_decorator'
require './person'

person = Person.new(22, name: 'maximilianus')
person.correct_name
person.can_use_services?
capitalized_person = CapitalizeDecorator.new(person)
capitalized_person.correct_name
capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
capitalized_trimmed_person.correct_name
