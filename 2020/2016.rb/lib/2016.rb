# frozen_string_literal: true

# Tickets
class Tickets
  def initialize(list)
    @list = list
    @rules = []
    @tickets = []
    parse
    #@rules.each{|r| puts r.to_s}
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

  def invalid_numbers
    all_numbers = @tickets.drop(1).reduce(&:+)
    all_numbers.select{|n| @rules.all?{|r| r.invalid_value(n)}}
  end

  def invalid_ticket_rate
    inv = invalid_numbers
    #puts "invalid_numbers #{inv}"
    inv.sum
  end

  def departure_values
    inv = invalid_numbers
    valid_tickets = @tickets.drop(1).select{|t| t.none?{|n| inv.include?(n)}}
    #puts "valid_tickets #{valid_tickets}"

    known = {}
    unknown = {}

    num_fields = @tickets[0].length
    (0..num_fields - 1).each{|field|
      values = valid_tickets.map{|t| t[field]}
      #puts "values #{field} #{values}"
      r_names = @rules.select{|r| values.all?{|v| r.valid_value(v)}}.map(&:name)
      #puts "#{field} valid for: #{r_names}"
      unknown[field] = r_names
    }
    #puts unknown.to_s

    #(1..10).each{|_|
    until unknown.empty?
      unknown.select{|_, v| v.length == 1}.each{|k, v|
        unknown.delete(k)
        known[v.first] = k
      }
      unknown.each{|k, v|
        unknown[k] = v.reject{|name| known.keys.include?(name)}
      }
      #puts "unknown #{unknown} known #{known}"
    end
    #}

    known.select{|k, _| k.match?(/\Adeparture/)}.values.map{|v| @tickets.first[v]}.reduce(&:*)
  end

  # A Rule definition
  class Rule
    attr_reader :name

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

    def valid_value(v)
      test = (v >= @lower1 && v <= @upper1) || (v >= @lower2 && v <= @upper2)
      #puts "valid_value #{v} #{test} #{self}"
      test
    end

    def invalid_value(v)
      !valid_value(v)
    end
  end

end
