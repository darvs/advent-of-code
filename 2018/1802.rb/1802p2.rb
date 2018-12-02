#!/usr/bin/env ruby
print File.readlines('input').map(&:strip).combination(2).map{|e| e[0].each_char.zip(e[1].each_char)}.select{|v| v.select{|sub| sub[0] != sub[1]}.count == 1}[0].select{|w| w[0]==w[1]}.map{|x| x[0]}.join

