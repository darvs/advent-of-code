#!/usr/bin/env ruby
require 'set'
input = File.readlines('input').map(&:to_i)
seen = Set[]
freq = 0
while input.each{|x| freq += x; if !seen.add?(freq) then break; end} do; end
puts freq
