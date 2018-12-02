#!/usr/bin/env ruby
require 'set'
h=Hash.new(0)
has=Hash.new(nil)
File.readlines('input').map(&:strip).each{|s| s.each_char.each{|c| h[s+"."+c] += 1}}
h.select{|_,x| [2,3].include? x}.each{|z,v| has[v].nil? ? has[v]=Set[z.split('.')[0]] : has[v].add(z.split('.')[0])}
puts "#{has[2].count}*#{has[3].count}=\n#{has[2].count*has[3].count}"
