#!/usr/bin/env ruby
puts File.readlines('input').map(&:to_i).reduce(:+)
