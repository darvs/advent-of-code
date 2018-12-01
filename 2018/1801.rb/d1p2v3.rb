#!/usr/bin/env ruby
require 'set'
seen = Set[]
freq = 0
while File.readlines('input').map(&:to_i).each{|x| freq += x; break if !seen.add?(freq)} do; end
puts freq
