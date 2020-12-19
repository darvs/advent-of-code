# frozen_string_literal: true

# Monster Grammar
class Grammar
  def initialize(lines)
    @rules = {}
    @messages = []
    parse(lines)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(lines)
    until lines.empty? || lines.first.empty?
      m = /\A(?<lhs>\d+): (?<rhs>.+)\Z/.match(lines.first)
      #puts "lines.first #{lines.first} m #{m}"
      rhs_lst = m[:rhs].split('|')
                       .map{|rhs|
                         rhs.split(' ').map{|e| e[0] == '"' ? e[1..-2] : e.to_i}
                       }
      #puts "#{m[:lhs]} is #{m[:rhs]}"
      #puts "rhs_lst #{rhs_lst}"
      @rules[m[:lhs].to_i] = rhs_lst
      lines.slice!(0)
    end

    until lines.empty?
      @messages += [lines.first]
      lines.slice!(0)
    end

    puts "rules #{@rules}"
  end

  def check_message(msg)
    puts "----------------------------"
    puts "  #{msg}"
    puts "----------------------------"
    @msg = msg.dup
    ans = check_rule(0, @msg) && @msg.empty? ? 1 : 0
    puts ans.to_s
    ans
  end

  def check_rule(num, msg)
    rule = @rules[num]
    @msg = msg.dup

    puts "rule #{rule}"
    if rule.length == 1

      # A character
      if rule.flatten.first.is_a? String
        #puts "num #{num} rule #{rule} string @msg #{@msg} rule.f.f #{rule.flatten.first}"
        if @msg[0] == rule.flatten.first
          puts "#{num} TRUE rule #{rule} string @msg #{@msg} rule.f.f #{rule.flatten.first}"
          @msg = @msg[1..-1]
          return true
        else
          puts "#{num} FALSE rule #{rule} string @msg #{@msg} rule.f.f #{rule.flatten.first}"
          return false
        end
      else
        # A concatenation
        puts "#{num} concat #{rule.first}"
        try = rule.first.all?{|r| check_rule(r, @msg)}
        @msg = msg.dup if !try
        return try
      end

    else

      # several parts separated with "|"
      return rule.any?{|r|
        puts "#{num} any #{rule} r #{r}"
        @msg = msg.dup
        try = r.all?{|r2| check_rule(r2, @msg)}
        @msg = msg.dup if !try
        try
      }
    end
  end

  def check_all_messages
    @messages.map{|msg| check_message(msg)}.sum
  end
end
