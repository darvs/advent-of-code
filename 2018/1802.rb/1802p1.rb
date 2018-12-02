#!/usr/bin/env ruby
require 'set'
h=Hash.new(0)
has_2=Set.new()
has_3=Set.new()
File.readlines('input').map(&:strip).each{|s| s.each_char.each{|c| h[s+"."+c] += 1}}
puts h
h.select{|_,x| [2].include? x}.each{|z,_| puts z; has_2.add(z.split('.')[0])}
h.select{|_,x| [3].include? x}.each{|z,_| puts z; has_3.add(z.split('.')[0])}
puts "#{has_2.count}+#{has_3.count}=\n#{has_2.count*has_3.count}"
