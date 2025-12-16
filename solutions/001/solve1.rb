#!/usr/bin/env ruby
# https://adventofcode.com/2025/day/1
# Run with: 'ruby solve1.rb'
# using Ruby 2.5.1
# by Zack Sargent

FILE_NAME = ARGV[0] || "input1.txt"
INPUT = File.readlines(FILE_NAME) # ignored by gitignore

DESIRED_NUMBER = 0
STARTING_POSITION = 50
DIAL_SIZE = 100

def parse_string line
  case line
  when /R(\d+)/
    [:rotate_right, $1.to_i]
  when /L(\d+)/
    [:rotate_left, $1.to_i]
  else
    raise "invalid line: #{line}"
  end
end

def next_value((rotation_direction, times_to_rotate), previous_value)
  # given 50L68 -> 50-68 -> 
  case rotation_direction
    when :rotate_right
      (previous_value + times_to_rotate) % DIAL_SIZE
    when :rotate_left # it feels like there must be a better way to do this
      if times_to_rotate > DIAL_SIZE
        times_to_rotate %= DIAL_SIZE
      end
      if times_to_rotate > previous_value
        DIAL_SIZE - (previous_value - times_to_rotate).abs
      else
        previous_value - times_to_rotate
      end
  end
end


previous_value = STARTING_POSITION
count_desired = 0
INPUT.map{parse_string _1}.each do |move|
  str_so_far = "given #{move}, #{previous_value} becomes"
  previous_value = next_value(move, previous_value)
  raise "uh oh: #{move}" if previous_value > DIAL_SIZE || previous_value < 0
  puts "#{str_so_far} #{previous_value}"
  if previous_value == DESIRED_NUMBER
    count_desired += 1
  end
end

puts "desired: #{count_desired}"




