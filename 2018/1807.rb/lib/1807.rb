# frozen_string_literal: true

def parse(rules, str)
  str.scan(/(\w) must be finished before step (\w) can begin/){|prec, step|
    rules[step].add(prec)
    rules[prec] = Set.new unless rules.key?(prec)
  }
end

def exec(rules)
  order = []
  until rules.empty?
    candidates = rules
                 .reject{|r| rules[r].to_a.any?{|prec| rules.key?(prec)}}
                 .map{|k, _| k}
                 .sort

    puts "candidates #{candidates}"
    order += [candidates.first]
    rules.delete(candidates.first)
  end

  order
end

def exec_file(filename)
  rules = Hash.new{|k, v| k[v] = Set.new}

  File.open(File.join('data', filename))
      .map(&:strip)
      .reject(&:empty?)
      .each{|str| parse(rules, str)}

  puts "rules #{rules}"

  order = exec(rules).join
  order
end
