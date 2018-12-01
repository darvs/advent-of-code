#!/usr/bin/env ruby
require 'set'
input = File.readlines('input').map(&:to_i)
seen = Set[]
freq = 0
i = 0
while !seen.include?(freq) do
	seen.add(freq)
	freq += input[i % input.length]
	i += 1
end
puts freq
