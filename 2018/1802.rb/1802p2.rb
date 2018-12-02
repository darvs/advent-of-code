#!/usr/bin/env ruby
print File.readlines('input').map(&:strip) # read all labels
  .combination(2)                                   # for each possible pair of labels
  .map{|e| e[0].each_char.zip(e[1].each_char)}      # pair matching char pos in each label
  .select{|v| v.count{|sub| sub[0] != sub[1]} == 1} # select where only one char is different
  .flatten(1)             # From the list of (1) pair of words, get the (1) pair
  .select{|w| w[0]==w[1]} # select only matching characters
  .map{|x| x[0]}          # select first set of (now only matching) characters
  .join                   # concatenate
