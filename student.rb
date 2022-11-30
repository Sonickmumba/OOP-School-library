require './person'

class Student < Person
  def initialize(classroom, age, name = 'unknown', parent_permission: true)
    super(name, age, parent_permission: parent_permission)
    @classroom = classroom
  end

  def play_hooky
    '¯\(ツ)/¯'
  end

  def classroom(classroom)
    @classroom = classroom
    classroom.students.push(self) unless classroom.students.include?(self)
  end

  def create_json
    super.merge({ type: self.class, classroom: @classroom })
  end
end
