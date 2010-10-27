require "rake/testtask" 

require './lib/roster_builder'
require './lib/timeslot'
require './lib/student'
require './lib/student_group'
require './lib/roster'

task :default => [:schedule] 

desc "Creates monday-roster.txt and wednesday-roster.txt from input file"
task :schedule do |t|
  puts "writing monday-roster.txt and wednesday-roster.txt"
  RosterBuilder.new("student_availability.csv").write_rosters
end

Rake::TestTask.new do |test| 
  test.test_files = Dir[ "test/*_test.rb" ] 
  test.verbose = true 
end 