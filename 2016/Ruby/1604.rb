#!/usr/bin/env ruby


def AoC1604(input_file)

  total = 0
  decrypted_list = []

  File.open(input_file).readlines.each do |line|

    *words, sector, checksum = line.strip.split(/[\[\],\-]/)
    str = words.join

    occurrences = str.each_char.map{|char| [char, str.scan(char).count]}.to_h.sort_by{|char, frequency| [-frequency, char]}

    calculated_checksum = occurrences.map{|pair| pair[0]}.take(5).join

    ok = (calculated_checksum == checksum)

    if ok
      total += sector.to_i

      decrypted_list.push([sector, words.map{|word| word.each_char.map{|char| (((char.ord - 'a'.ord + sector.to_i) % 26) + 'a'.ord).chr}.join}.join(' ')])
    end


    puts("#{'%3s' % if ok then 'OK' else 'NOT' end} String: #{words.join('-')} Sector: #{sector} Checksum: #{checksum} Occurrences: #{occurrences} Calculated Checksum: #{calculated_checksum}")

  end

  puts('')
  puts("Total Correct Checkum: #{total}")

  puts('-----------------')
  puts('Decryption')
  puts('-----------------')

  decrypted_list.map{|sector, decrypted| puts("#{sector} | #{decrypted}")}

end



#AoC1604('1604.test.input')
#AoC1604('1604.test2.input')
AoC1604('1604.real.input')
