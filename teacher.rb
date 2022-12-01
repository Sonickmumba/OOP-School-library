require './person'

class Teacher < Person
  def initialize(age, specialization, name, parent_permission)
    super(age, name, parent_permission: parent_permission)
    @specialization = specialization
  end

  def can_use_service?
    true
  end

  def create_json
    super.merge({ type: self.class, specialization: @specialization })
  end
end
