require 'csv'
require 'time'

class RosterBuilder
  
  def initialize(filename)
    @filename = filename
  end
  
  def write_rosters
    StudentGroup.new(build_students).write_rosters
  end

  def build_students
    get_students(get_rows)
  end

  def get_rows
    rows = CSV.table(@filename)
  end

  def get_students(rows)
    [].tap do |students|
      rows.each do |row|
        students << Student.new(row[0], build_timeslots(row[1], "Tuesday"), build_timeslots(row[2], "Thursday"))
      end
    end
  end

  def build_timeslots(raw, next_day)
    times = raw.split(", ")
    [].tap do |slots|
      times.each do |raw|
        slots << Timeslot.new(Time.parse(raw), next_day).to_s
      end
    end
  end
  
end