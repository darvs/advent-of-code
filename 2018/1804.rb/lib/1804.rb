def parse(line, schedule, context)

  minute = /\[\d{4}-\d{2}-\d{2} \d{2}:(?<minute>\d{2})\]/.match(line)['minute'].to_i

  case line
  when /Guard #(\d+) begins shift/
    context[:guard] = $~[1].to_i
    context[:fell_asleep_at] = -1

  when /falls asleep/
    context[:fell_asleep_at] = minute

  when /wakes up/
    # The guard was asleep in all the minutes between the last time he fell asleep and the minute before the current minute

    for m in context[:fell_asleep_at] .. ((minute - 1) % 60)
      (schedule[context[:guard]])[m] += 1
    end

  end

end

def exec_file(filename)

  # guard_minute_times is the schedule formatted as {guard=>{minute=>times_asleep}}]
  guard_minute_times = Hash.new{|h,k| h[k] = Hash.new(0)}

  # context will keep the current guard at the minute they last fell asleep
  context = Hash.new

  File.open(File.join('data', filename)).map(&:strip).select{|line| !line.empty?}
    .sort.each{|line| parse(line, guard_minute_times, context)}

  guard_most_frequently_asleep = guard_minute_times.map{|guard, minute_times|
    [guard, minute_times.map{|_,times| times}.sum]
  }.max_by{|guard, times| times}.first

  guard_most_frequently_asleep_most_frequently_asleep_at = guard_minute_times[guard_most_frequently_asleep].max_by{|_minutes, times| times}.first

  guard_most_frequently_asleep_on_same_minute = ([:guard, :minute].zip(
    guard_minute_times.map{|guard, minute_times|
      minute, times = minute_times.max_by{|_, _times| _times}
      [times, [guard, minute]]
    }.max_by{|times, guard_minute| times}.last)
  ).to_h

 return guard_most_frequently_asleep, guard_most_frequently_asleep_most_frequently_asleep_at, guard_most_frequently_asleep_on_same_minute

end
