class Timeslot
  
  def initialize(slot, next_day)
    @slot = slot
    @next_day = next_day
  end
  
  def to_s
    "#{@slot.strftime("%l:%M %p %Z")} (#{@slot.getutc.strftime("%H:%M %Z")}#{@slot.day != @slot.getutc.day ? " #{@next_day}" : ""})".lstrip
  end
end