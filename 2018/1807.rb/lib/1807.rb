# frozen_string_literal: true

def parse(rules, str)
  str.scan(/(\w) must be finished before step (\w) can begin/){|prec, step|
    rules[step].add(prec)
    rules[prec] = Set.new unless rules.key?(prec)
  }
end

def exec(rules, n_workers = 2, time_completion_base = 0)
  order = []
  time = 0
  jobs = []
  #Array.new(n_workers, ends: 0, payload: "")

  puts "jobs #{jobs} n_workers #{n_workers} time #{time}"

  until rules.empty? && jobs.empty?
    time = jobs.map{|j| j[:ends]}.min || 0

    puts "time #{time}"

    jobs.select{|j| j[:ends] == time}
        .map{|j| j[:payload]}
        .sort
        .each{|payload| order += [payload]}

    jobs.delete_if{|h,_| h[:ends] == time}
                 
    #.reject{|r| rules[r].to_a.any?{|prec| rules.key?(prec)}}
    candidates = rules
                 .select{|r| rules[r].to_a.all?{|prec| order.include?(prec)}}
                 .map{|k, _| k}
                 .sort

    puts "candidates #{candidates}"

    candidates.each{|c|
      if jobs.size < n_workers
        puts "time #{time} time_completion_base #{time_completion_base}"
        puts "c #{c}"
        puts "'A'.ord #{'A'.ord}"
        puts "c.ord #{c.ord}"
        jobs += [{ ends: time + time_completion_base + c.ord - 'A'.ord + 1, payload: c }]
        rules.delete(c)
      end
    }
    puts "rules #{rules}"
    puts "jobs #{jobs}"
    #if time.positive? then rules = [] end
  end
  puts "time #{time}"

  [order.join, time]
end

def exec_file(filename, n_workers, time_completion_base)
  puts "exec_file filename #{filename} n_workers #{n_workers} time_completion_base #{time_completion_base}"
  rules = Hash.new{|k, v| k[v] = Set.new}

  File.open(File.join('data', filename))
      .map(&:strip)
      .reject(&:empty?)
      .each{|str| parse(rules, str)}

  puts "rules #{rules}"

  order, time = exec(rules, n_workers, time_completion_base)
  [order, time]
end
