# frozen_string_literal: true

# Tickets
class Tickets
  def initialize(list)
    @list = list
    @rules = []
    @tickets = []
    parse
    puts list.to_s
    @rules.each{|r| puts r.to_s}
    puts @tickets.to_s
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse
    parse_rules
    @list = @list.drop(2)
    parse_ticket
    @list = @list.drop(2)
    parse_ticket until @list.empty?
    0
  end

  def parse_rules
    puts "first #{@list.first}"
    m = @list.first.match(/\A(?<name>[A-Za-z ]+): (?<lower1>\d+)-(?<upper1>\d+) or (?<lower2>\d+)-(?<upper2>\d+)/)
    return if m.nil?

    @rules += [Rule.new(m[:name], m[:lower1], m[:upper1], m[:lower2], m[:upper2])]

    @list = @list.drop(1)
    parse_rules
  end

  def parse_ticket
    @tickets += [@list.first.split(',').map(&:to_i)]
    @list = @list.drop(1)
  end


  def invalid_ticket_rate
    puts "i_t_r"
    all_numbers = @tickets.drop(1).reduce(&:+)
    puts "all_num #{all_numbers}"
    inv = all_numbers.select{|n| @rules.none?{|r| r.invalid_value(n)}}
    puts inv.to_s
    inv.sum
  end

  # A Rule definition
  class Rule
    def initialize(name, lower1, upper1, lower2, upper2)
      @name = name
      @lower1 = lower1.to_i
      @upper1 = upper1.to_i
      @lower2 = lower2.to_i
      @upper2 = upper2.to_i
    end

    def to_s
      "#{@name}: #{@lower1}-#{@upper1} || #{@lower2}-#{@upper2}"
    end

    def all_invalid_values(ticket)
      ticket.reject{|v| invalid_value(v)}
    end

    def invalid_value(v)
      (v >= @lower1 && v <= @upper1) || (v >= @lower2 && v <= @upper2)
    end
  end

end
