# frozen_string_literal: true

# A class to check for safe passwords
class SecureContainer
  def self.check_range(first, last, part)
    (first..last).select{|n| check(n, part)}.count
  end

  def self.check(number, part = 1)
    digits = number.digits.reverse

    if part == 1
      never_decreasing_digits(digits) &&
        two_adjacent_digits_the_same(digits)
    else
      never_decreasing_digits(digits) &&
        two_but_not_more_adjacent_digits_the_same(digits)
    end
  end

  def self.two_adjacent_digits_the_same(digits)
    (1..digits.length - 1).each{|n| return true if digits[n] == digits[n - 1]}
    false
  end

  def self.two_but_not_more_adjacent_digits_the_same(digits)
    (1..digits.length - 1).each{|n|
      if (digits[n] == digits[n - 1]) &&
         ((n < 2) || (digits[n] != digits[n - 2])) &&
         ((n == digits.length - 1) || (digits[n + 1] != digits[n]))
        #puts "failed on #{n}"
        return true
      end
    }
    false
  end

  def self.never_decreasing_digits(digits)
    (1..(digits.length - 1)).each{|n| return false if digits[n] < digits[n - 1]}
    true
  end
end
