#!/usr/bin/env ruby


def AoC1603(input_file)

  correct_counter = 0

  File.open(input_file).readlines.each do |line|

    # strip will remove the spaces at the beginning and end
    # split will split the lines in words at white spaces
    # map will convert each word to an integer

    arr = line.strip.split(/\W+/).map(&:to_i)

    (a,b,c) = arr

    correct = ((a+b) > c) && ((a+c) > b) && ((b+c) > a)
    if correct
      correct_counter += 1
    end

    puts("#{if correct then 'YES' else 'NO ' end}     #{'%03d' % a}, #{'%03d' % b}, #{'%03d' % c}")

  end

  puts("\n#{correct_counter} correct triangles")

end



AoC1603('1603.input')