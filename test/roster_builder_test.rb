require 'test/unit'
require 'time'
require './lib/roster_builder'
require './lib/timeslot'

class RosterBuilderTest < Test::Unit::TestCase
  
  MONDAY_8 = Timeslot.new(Time.parse("8:00 AM EDT"), "Tuesday")
  MONDAY_12 = Timeslot.new(Time.parse("12:00 PM EDT"), "Tuesday")

  def setup
    @builder = RosterBuilder.new("test")
  end

  def test_build_timeslots_none
    ts = @builder.build_timeslots("", "Tuesday")
    assert_equal 0, ts.length
  end

  def test_build_timeslots_one
    ts = @builder.build_timeslots("8:00 am EDT (12:00 UTC)", "Tuesday")
    assert_equal 1, ts.length
    assert MONDAY_8.to_s, ts[0].to_s
  end

  def test_build_timeslots_two
    ts = @builder.build_timeslots("8:00 am EDT (12:00 UTC), 12:00 pm EDT (16:00 UTC)", "Tuesday")
    assert_equal 2, ts.length
    assert MONDAY_8.to_s, ts[0].to_s
    assert MONDAY_12.to_s, ts[1].to_s
  end
  
end