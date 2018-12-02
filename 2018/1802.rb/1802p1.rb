#!/usr/bin/env ruby
require 'set'

# label_c_n[label][character] = number of occurrence of character in label
#   that {|h,k|...} expression creates a new hash inside each new item
label_c_n=Hash.new {|h,k| h[k] = Hash.new(0)}

# n_label[number] = set of labels which have n occurences of any character
#   that {|h,k|...} expression creates a new set for the labels
n_label=Hash.new {|h,k| h[k] = Set.new}

# for each label, count the occurrences of each character
File.readlines('input').map(&:strip).each{|label| label.each_char{|c| label_c_n[label][c] += 1};}

# gather the sets of labels for each number of occurrences of a character
label_c_n.each{|label,c_n| c_n.each{|_,n| n_label[n].add(label)}}

# print it all out
puts "#{n_label[2].count}*#{n_label[3].count}=\n#{n_label[2].count*n_label[3].count}"
