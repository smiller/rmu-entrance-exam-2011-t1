class Roster

  def initialize(day, timeslot, students)
    @day = day
    @timeslot = timeslot
    @students = students
  end
  
  def to_s
    list = [@timeslot.to_s, ""]
    @students.each do |student|
      list << student.name
    end
    list.join("\n")
  end
  
  def to_file
    File.open("#{@day.downcase}-roster.txt", "w") { |f| f.write to_s }
  end
end
