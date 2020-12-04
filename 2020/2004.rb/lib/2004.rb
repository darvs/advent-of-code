# frozen_string_literal: true

# Passports
class Passports
  def initialize(file)
    @file = file
    @list = []
    parse
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse
    pass = {}
    @file.each{|line|
      if line.empty?
        @list += [pass]
        pass = {}
      end

      line.split(' ').map{|kv|
        k, v = kv.split(':')
        pass[k] = v
      }
    }
    @list += [pass]

    #puts @list
  end

  def keys?(h)
    h.key?('byr') &&
      h.key?('iyr') &&
      h.key?('eyr') &&
      h.key?('hgt') &&
      h.key?('hcl') &&
      h.key?('ecl') &&
      h.key?('pid')
  end

  def year_between(year, from, to)
    valid = year.match?(/\d{4}/) && year.to_i.between?(from, to)
    puts "validate #{year} #{from},#{to} #{valid}"
    valid
  end

  def validate_height(height)
    valid = (height.match?(/\d+cm/) && height.to_i.between?(150, 193)) ||
      (height.match(/\d+in/) && height.to_i.between?(59, 76))
    puts "validate height #{height} #{valid}"
    valid
  end

  def validate_hcl(hcl)
    valid = hcl.match?(/#[0-9a-f]{6}/)
    puts "validate hcl #{hcl} #{valid}"
    valid
  end

  def validate_ecl(ecl)
    valid = ['amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth'].include?(ecl)
    puts "validate ecl #{ecl} #{valid}"
    valid
  end

  def validate_pid(pid)
    valid = pid.match?(/\d{9}/)
    puts "validate pid #{pid} #{valid}"
    valid
  end

  def validation(h)
    year_between(h['byr'], 1920, 2002) &&
      year_between(h['iyr'], 2010, 2020) &&
      year_between(h['eyr'], 2020, 2030) &&
      validate_height(h['hgt']) &&
      validate_hcl(h['hcl']) &&
      validate_ecl(h['ecl']) &&
      validate_pid(h['pid'])
  end

  def run(validate)
    @list.select{|h|
      keys?(h) && (!validate || validation(h))
    }.count
  end
end
