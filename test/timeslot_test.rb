require 'test/unit'
require 'time'
require './lib/timeslot'

class TimeslotTest < Test::Unit::TestCase

  def test_display
    assert("12:00 AM EDT (4:00 UTC)", Timeslot.new(Time.parse("12:00 AM EDT"), "Tuesday").to_s)
    assert("1:00 AM EDT (5:00 UTC)", Timeslot.new(Time.parse("1:00 AM EDT"), "Tuesday").to_s)
    assert("2:00 AM EDT (6:00 UTC)", Timeslot.new(Time.parse("2:00 AM EDT"), "Tuesday").to_s)
    assert("3:00 AM EDT (7:00 UTC)", Timeslot.new(Time.parse("3:00 AM EDT"), "Tuesday").to_s)
    assert("4:00 AM EDT (8:00 UTC)", Timeslot.new(Time.parse("4:00 AM EDT"), "Tuesday").to_s)
    assert("5:00 AM EDT (9:00 UTC)", Timeslot.new(Time.parse("5:00 AM EDT"), "Tuesday").to_s)
    assert("6:00 AM EDT (10:00 UTC)", Timeslot.new(Time.parse("6:00 AM EDT"), "Tuesday").to_s)
    assert("7:00 AM EDT (11:00 UTC)", Timeslot.new(Time.parse("7:00 AM EDT"), "Tuesday").to_s)
    assert("8:00 AM EDT (12:00 UTC)", Timeslot.new(Time.parse("8:00 AM EDT"), "Tuesday").to_s)
    assert("9:00 AM EDT (13:00 UTC)", Timeslot.new(Time.parse("9:00 AM EDT"), "Tuesday").to_s)
    assert("10:00 AM EDT (14:00 UTC)", Timeslot.new(Time.parse("10:00 AM EDT"), "Tuesday").to_s)
    assert("11:00 AM EDT (15:00 UTC)", Timeslot.new(Time.parse("11:00 AM EDT"), "Tuesday").to_s)
    assert("12:00 PM EDT (16:00 UTC)", Timeslot.new(Time.parse("12:00 PM EDT"), "Tuesday").to_s)
    assert("1:00 PM EDT (17:00 UTC)", Timeslot.new(Time.parse("1:00 PM EDT"), "Tuesday").to_s)
    assert("2:00 PM EDT (18:00 UTC)", Timeslot.new(Time.parse("2:00 PM EDT"), "Tuesday").to_s)
    assert("3:00 PM EDT (19:00 UTC)", Timeslot.new(Time.parse("3:00 PM EDT"), "Tuesday").to_s)
    assert("4:00 PM EDT (20:00 UTC)", Timeslot.new(Time.parse("4:00 PM EDT"), "Tuesday").to_s)
    assert("5:00 PM EDT (21:00 UTC)", Timeslot.new(Time.parse("5:00 PM EDT"), "Tuesday").to_s)
    assert("6:00 PM EDT (22:00 UTC)", Timeslot.new(Time.parse("6:00 PM EDT"), "Tuesday").to_s)
    assert("7:00 PM EDT (23:00 UTC)", Timeslot.new(Time.parse("7:00 PM EDT"), "Tuesday").to_s)
    assert("8:00 PM EDT (0:00 UTC Tuesday)", Timeslot.new(Time.parse("8:00 PM EDT"), "Tuesday").to_s)
    assert("9:00 PM EDT (1:00 UTC Tuesday)", Timeslot.new(Time.parse("9:00 PM EDT"), "Tuesday").to_s)
    assert("10:00 PM EDT (2:00 UTC Tuesday)", Timeslot.new(Time.parse("10:00 PM EDT"), "Tuesday").to_s)
    assert("11:00 PM EDT (3:00 UTC Tuesday)", Timeslot.new(Time.parse("11:00 PM EDT"), "Tuesday").to_s)
  end
end
