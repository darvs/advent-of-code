#!/usr/bin/env ruby
require 'set'
seen = Set[]
freq = 0
while File.readlines('input').map(&:to_i).each{|delta| break if !seen.add?(freq += delta)} do; end
puts freq
