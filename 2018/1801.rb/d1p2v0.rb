#!/usr/bin/env ruby
require 'set'

s = Set[0]
input = File.readlines('input').map(&:to_i)
t = 0
i = 0
while true do
	t += input[i % input.length]
	if s.include?(t) == true then
		puts "Set: #{s}"
		puts t
		break
	end
	s.add(t)
	i += 1
end
