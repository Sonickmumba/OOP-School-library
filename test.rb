require './capitalize_decorator'
require './trimmer_decorator'
require './person'

person = Person.new(22, 'maximilianus')
p person.correct_name
p person.can_use_services?
p capitalized_person = CapitalizeDecorator.new(person)
p capitalized_person.correct_name
p capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
p capitalized_trimmed_person.correct_name
