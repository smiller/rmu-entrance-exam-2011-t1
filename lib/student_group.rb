class StudentGroup
  
  attr_reader :monday_roster, :wednesday_roster
  
  def initialize(students)
    @students = students
    @monday_roster = build_roster("Monday", "Wednesday")
    @wednesday_roster = build_roster("Wednesday", "Monday")
  end
  
  def build_roster(day, alternate_day)
    timeslot = best_timeslot(@students.collect { |s| s.slots(day) }.flatten, day, alternate_day)
    Roster.new(day, timeslot, students_available(timeslot, day))
  end
  
  def write_rosters
    @monday_roster.to_file
    @wednesday_roster.to_file
  end
  
  def best_timeslot(timeslots, choice_day, alternate_day)
    unique_timeslots = timeslots.uniq
    class_sizes = unique_timeslots.map { |uts| timeslots.select { |ts| ts == uts}.length }
    best = unique_timeslots.select { |uts| class_sizes[unique_timeslots.index(uts)] == class_sizes.max }
    best.length == 1 ? best[0] : break_tie(best, choice_day, alternate_day)
  end

  def break_tie(timeslots, choice_day, alternate_day)
    other_day_sizes = reckon_other_day_sizes(timeslots, choice_day, alternate_day)
    timeslots[other_day_sizes.index(other_day_sizes.max)]
  end
  
  def reckon_other_day_sizes(timeslots, choice_day, alternate_day)
    [].tap do |other_day_sizes| 
      timeslots.each do |timeslot|
        other_day_slots = reckon_other_day_slots(timeslot, choice_day, alternate_day)
        other_day_sizes << (other_day_slots.flatten.length - other_day_slots.flatten.uniq.length)
      end
    end
  end
  
  def reckon_other_day_slots(timeslot, choice_day, alternate_day)
    [].tap do |other_day_slots|
      students_available(timeslot, choice_day).each do |student|
        other_day_slots << student.slots(alternate_day)
      end
    end
  end

  def students_available(timeslot, day) 
    @students.select { |s| s.slots(day).include? timeslot }
  end
end