# frozen_string_literal: true

# A Monkey
class Monkey
  attr_accessor :items,
                :new_items
  attr_writer :operation,
              :divisible,
              :if_true,
              :if_false

  attr_reader :inspected

  def initialize(number)
    # Do nothink?
    @number = number
    @items = []
    @new_items = []
    @operation = []
    @divisible = 0
    @if_true = 0
    @if_false = 0

    @inspected = 0
  end

  def to_s
    "Monkey #{@number}: #{@items.join(', ')} inspected: #{@inspected}"
  end

  def run_op(item)
    lhs, op, rhs = @operation.map{|p| p == 'old' ? item : p}
    #p "run_op l: #{lhs.to_i} o: #{op} r: #{rhs.to_i}"
    case op
    when '+'
      lhs.to_i + rhs.to_i
    when '*'
      lhs.to_i * rhs.to_i
    end
  end

  def run(worry_divider)
    #p "RUN Monkey #{@number} -------------------"
    count = @items.length
    @items.each{|i|
      value = run_op(i) / worry_divider
      #target = (value % @divisible).zero? ? @if_true : @if_false
      #p "monkeys #{$monkeys}"
      #p "check #{value} % #{@divisible} ? #{@if_true} : #{@if_false}"
      #p "target #{target}"
      #p "monkey[2] #{$monkeys[2]}"
      #p "target monkey #{$monkeys[target]}"
      @items = @items.drop(count)
      $monkeys[(value % @divisible).zero? ? @if_true : @if_false].items.append(value)

      @inspected += 1
    }
  end

  def end_turn
  end
end

# All the Monkeys
$monkeys = {}

# The Business
class Business
  def initialize(list)
    @list = list

    @current_monkey = nil

    list.each{|line| parse(line)}
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename)).map(&:chomp))
  end

  def parse(line)
    case line

    when /Monkey (\d+):/
      monkey_number = ::Regexp.last_match(1).to_i
      @current_monkey = Monkey.new(monkey_number)
      $monkeys[monkey_number] = @current_monkey

    when /Starting items: (.*)/
      starting = ::Regexp.last_match(1).split(', ').map(&:to_i)
      @current_monkey.items = starting

    when /Operation: new = (\w+) (\S) (\w+)/
      @current_monkey.operation = [::Regexp.last_match(1), ::Regexp.last_match(2), ::Regexp.last_match(3)]

    when /divisible by (\d+)/
      @current_monkey.divisible = ::Regexp.last_match(1).to_i

    when /true: throw to monkey (\d+)/
      @current_monkey.if_true = ::Regexp.last_match(1).to_i

    when /false: throw to monkey (\d+)/
      @current_monkey.if_false = ::Regexp.last_match(1).to_i

    end
  end

  def debug
    #p "Monkeys #{$monkeys}"

    $monkeys.each{|_, m| puts m}
    puts "---"
  end

  def level_of_monkey_business(rounds, worry_divider)
    debug
    rounds.times{|r|
      $monkeys.each{|_, m| m.run(worry_divider)}
      #$monkeys.each{|_, m| m.end_turn}
      if (r % 10).zero?
        p '-----------------------------'
        p " End of Round #{r}"
        p '-----------------------------'
      end
      #debug
    }
    $monkeys.map{|_, m| m.inspected}.sort.reverse.take(2).reduce(&:*)
  end
end
