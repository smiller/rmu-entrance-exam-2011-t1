require 'test/unit'
require 'time'
require './lib/student'
require './lib/student_group'
require './lib/timeslot'
require './lib/roster'

class StudentGroupTest < Test::Unit::TestCase
  
  MONDAY_7 = Timeslot.new(Time.parse("7:00 AM EDT"), "Tuesday")
  MONDAY_8 = Timeslot.new(Time.parse("8:00 AM EDT"), "Tuesday")
  MONDAY_11 = Timeslot.new(Time.parse("11:00 AM EDT"), "Tuesday")
  MONDAY_12 = Timeslot.new(Time.parse("12:00 PM EDT"), "Tuesday")
  MONDAY_13 = Timeslot.new(Time.parse("1:00 PM EDT"), "Tuesday")
  MONDAY_14 = Timeslot.new(Time.parse("2:00 PM EDT"), "Tuesday")
  MONDAY_15 = Timeslot.new(Time.parse("3:00 PM EDT"), "Tuesday")
  MONDAY_16 = Timeslot.new(Time.parse("4:00 PM EDT"), "Tuesday")
  
  WEDNESDAY_7 = Timeslot.new(Time.parse("7:00 AM EDT"), "Thursday")
  WEDNESDAY_9 = Timeslot.new(Time.parse("9:00 PM EDT"), "Thursday")
  WEDNESDAY_12 = Timeslot.new(Time.parse("12:00 PM EDT"), "Thursday")
  WEDNESDAY_13 = Timeslot.new(Time.parse("1:00 PM EDT"), "Thursday")
  WEDNESDAY_16 = Timeslot.new(Time.parse("4:00 PM EDT"), "Thursday")
  WEDNESDAY_17 = Timeslot.new(Time.parse("5:00 PM EDT"), "Thursday")
  WEDNESDAY_18 = Timeslot.new(Time.parse("6:00 PM EDT"), "Thursday")
  WEDNESDAY_19 = Timeslot.new(Time.parse("7:00 PM EDT"), "Thursday")
  WEDNESDAY_20 = Timeslot.new(Time.parse("8:00 PM EDT"), "Thursday")
  WEDNESDAY_21 = Timeslot.new(Time.parse("9:00 PM EDT"), "Thursday")
  
  # Rules:
  #
  # Rule 1: Ensure that as many students as possible can attend at least one of the two 
  # days, even if it reduces the number of students who can attend both.
  # 
  # Rule 2: If it does not lead to a contradiction with the previous requirement, try to 
  # pick the starting times which allow the most students to attend both 
  # sessions.

  # A | 8, 12 | 12, 16 |
  # B | 8, 13 | 12, 17 |
  # Monday: 8 (2), 12 (1), 13 (1)
  # Wednesday: 12 (2), 16 (1), 17 (1)
  # By rule 1, prefer Monday 8 (2) and Wednesday 12 (2)
  def test_rule1_more_can_attend_at_least_one
    student_a = Student.new("a", [MONDAY_8, MONDAY_12], [WEDNESDAY_12, WEDNESDAY_16])
    student_b = Student.new("b", [MONDAY_8, MONDAY_13], [WEDNESDAY_12, WEDNESDAY_17])
    group = StudentGroup.new([student_a, student_b])

    assert_equal "8:00 AM EDT (12:00 UTC)\n\na\nb", group.monday_roster.to_s
    assert_equal "12:00 PM EDT (16:00 UTC)\n\na\nb", group.wednesday_roster.to_s
  end

  # A | 8, 12 | 13, 18 |
  # B | 12, 14 | 18, 19 | 
  # C | 8, 15 | 7, 20 |
  # D | 8, 16 | 9, 21 |
  # Monday: 8 (3), 12 (2), 14 (1), 15 (1), 16 (1)
  # Wednesday: 7 (1), 13 (1), 18 (2), 19 (1), 20 (1), 21 (1)
  # Monday 8 (3), Wednesday 18 (2) -- 1 student can attend both
  # Monday 12 (2), Wednesday 18 (2) -- 2 students can attend both
  # By rule 1, prefer Monday 8 (3) and Wednesday 18 (2): 
  # since rule 1 over-rides rule 2, it doesn't matter that fewer can attend both
  def test_rule1_more_can_attend_one_even_if_fewer_can_attend_both
    student_a = Student.new("a", [MONDAY_8, MONDAY_12], [WEDNESDAY_13, WEDNESDAY_18])
    student_b = Student.new("b", [MONDAY_12, MONDAY_14], [WEDNESDAY_18, WEDNESDAY_19])
    student_c = Student.new("c", [MONDAY_8, MONDAY_15], [WEDNESDAY_7, WEDNESDAY_20])
    student_d = Student.new("d", [MONDAY_8, MONDAY_16], [WEDNESDAY_9, WEDNESDAY_21])
    group = StudentGroup.new([student_a, student_b, student_c, student_d])

    assert_equal "8:00 AM EDT (12:00 UTC)\n\na\nc\nd", group.monday_roster.to_s
    assert_equal "6:00 PM EDT (22:00 UTC)\n\na\nb", group.wednesday_roster.to_s
  end

  # A | 8, 12 | 13, 18 |
  # B | 12, 14 | 18, 19 |
  # C | 8, 15 | 7, 20 |
  # D | 7, 16 | 9, 21 |
  # Monday: 7 (1), 8 (2), 12 (2), 14 (1), 15 (1), 16 (1)
  # Wednesday: 7 (1), 9 (1), 13 (1), 18 (2), 19 (1), 20 (1), 21 (1)
  # Monday 8 (2), Wednesday 18 (2) -- 1 student can attend both
  # Monday 12 (2), Wednesday 18 (2) -- 2 students can attend both
  # No preference by rule 1 (2 each in either case),
  # by rule 2, prefer Monday 12 (2), Wednesday 18 (2), by which more can attend both
  def test_rule2_simpler
    student_a = Student.new("a", [MONDAY_8, MONDAY_12], [WEDNESDAY_13, WEDNESDAY_18])
    student_b = Student.new("b", [MONDAY_12, MONDAY_14], [WEDNESDAY_18, WEDNESDAY_19])
    student_c = Student.new("c", [MONDAY_8, MONDAY_15], [WEDNESDAY_7, WEDNESDAY_20])
    student_d = Student.new("d", [MONDAY_7, MONDAY_16], [WEDNESDAY_9, WEDNESDAY_21])
    group = StudentGroup.new([student_a, student_b, student_c, student_d])

    assert_equal "12:00 PM EDT (16:00 UTC)\n\na\nb", group.monday_roster.to_s
    assert_equal "6:00 PM EDT (22:00 UTC)\n\na\nb", group.wednesday_roster.to_s
  end

  # A | 8, 12 | 13, 18 |
  # B | 11, 14 | 18, 19 |
  # C | 11, 15 | 7, 19 |
  # D | 7, 12 | 9, 21 |
  # Monday: 7 (1), 8 (1), 11 (2), 12 (2), 14 (1), 15 (1)
  # Wednesday: 7 (1), 9 (1), 13 (1), 18 (2), 19 (2), 21 (1)
  # Monday 11 (2), Wednesday 18 (2) -- 1 can attend both
  # Monday 12 (2), Wednesday 18 (2) -- 1 can attend both
  # Monday 11 (2), Wednesday 19 (2) -- 2 can attend both
  # Monday 12 (2), Wednesday 19 (2) -- 0 can attend both
  # No preference by rule 1 (2 each in all four cases),
  # by rule 2, prefer Monday 11 (2), Wednesday 19 (2), by which more can attend both
  def test_rule2_more_complex
    student_a = Student.new("a", [MONDAY_8, MONDAY_12], [WEDNESDAY_13, WEDNESDAY_18])
    student_b = Student.new("b", [MONDAY_11, MONDAY_14], [WEDNESDAY_18, WEDNESDAY_19])
    student_c = Student.new("c", [MONDAY_11, MONDAY_15], [WEDNESDAY_7, WEDNESDAY_19])
    student_d = Student.new("d", [MONDAY_7, MONDAY_12], [WEDNESDAY_9, WEDNESDAY_21])
    group = StudentGroup.new([student_a, student_b, student_c, student_d])

    assert_equal "11:00 AM EDT (15:00 UTC)\n\nb\nc", group.monday_roster.to_s
    assert_equal "7:00 PM EDT (23:00 UTC)\n\nb\nc", group.wednesday_roster.to_s
  end  
end
