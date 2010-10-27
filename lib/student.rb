class Student
  
  attr_reader :name
  
  def initialize(name, monday_slots, wednesday_slots)
    @name = name
    @monday_slots = monday_slots
    @wednesday_slots = wednesday_slots
  end
  
  def slots(day)
    if "Monday" == day
      @monday_slots
    elsif "Wednesday" == day
      @wednesday_slots
    end
  end
end