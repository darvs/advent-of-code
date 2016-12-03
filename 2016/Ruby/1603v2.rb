#!/usr/bin/env ruby

def check(a, b, c)
  correct = ((a+b) > c) && ((a+c) > b) && ((b+c) > a)

  puts("#{if correct then 'YES' else 'NO ' end}     #{'%03d' % a}, #{'%03d' % b}, #{'%03d' % c}")

  if correct then 1 else 0 end
end



def AoC1603(input_file, mode)

  correct_counter = 0

  data = []

  File.open(input_file).readlines.each do |line|

    # strip will remove the spaces at the beginning and end
    # split will split the lines in words at white spaces
    # map will convert each word to an integer

    arr = line.strip.split(/\W+/).map(&:to_i)

    data.push(arr)
  end

  count = 0
  while count < data.length do
    (0..2).each do |i|

      if mode == :line_by_line
        correct_counter += check(data[count+i][0], data[count+i][1], data[count+i][2])

      else
        # We're reading in Stupid Mode.
        correct_counter += check(data[count][i], data[count+1][i], data[count+2][i])

      end

    end
    count += 3
  end

  puts("")
  puts("\n#{correct_counter} correct triangles in #{mode} Mode")
  puts("----------------------")


end



AoC1603('1603.input', :line_by_line)
AoC1603('1603.input', :by_columns_like_a_stupid)
