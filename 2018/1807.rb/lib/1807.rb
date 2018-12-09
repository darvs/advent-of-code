# frozen_string_literal: true

def parse(rules, str)
  str.scan(/(\w) must be finished before step (\w) can begin/){|prec, step|
    rules[step].add(prec)
    rules[prec] = Set.new unless rules.key?(prec)
  }
end

def exec(rules, n_workers = 2, base = 0)
  order = []
  time = 0
  jobs = []

  until rules.empty? && jobs.empty?

    # skip to the next time at least one job ends.
    time = jobs.map{|j| j[:ends]}.min unless jobs.empty?

    # deliver payloads finished at this second
    order += jobs.select{|j| j[:ends] == time}
                 .map{|j| j[:payload]}
                 .sort

    # delete jobs whose payloads have just been delivered
    jobs.delete_if{|j| j[:ends] == time}

    # examine candidates, create as many new jobs as possible
    jobs += rules.select{|r| rules[r].to_a.all?{|prec| order.include?(prec)}}
                 .sort
                 .take(n_workers - jobs.size)
                 .map{|c, _|
                   rules.delete(c)
                   { ends: time + base + c.ord - 'A'.ord + 1, payload: c }
                 }
  end

  [order.join, time]
end

def exec_file(filename, n_workers, time_completion_base)
  rules = Hash.new{|h, k| h[k] = Set.new}

  File.open(File.join('data', filename))
      .map(&:strip)
      .reject(&:empty?)
      .each{|str| parse(rules, str)}

  exec(rules, n_workers, time_completion_base)
end
