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
      (schedule[m])[context[:guard]] += 1
    end

  end

end

def exec_file(filename)

  # schedule is an array of minute, in each minute a hash where k=guard_number, v=number of times that guard was asleep at that minute
  schedule = Array.new(60){Hash.new(0)}

  # context will keep the current guard at the minute they last fell asleep
  context = Hash.new

  File.open(File.join('data', filename)).map(&:strip).select{|line| !line.empty?}
    .sort.each{|line| parse(line, schedule, context)}

  minutes_asleep = Hash.new(0)
  guard_minute_times = Hash.new{|h,k| h[k] = Hash.new}

  schedule.each_with_index{|minute, index|
    minute.each{|guard,times_asleep|
      minutes_asleep[guard] += times_asleep

      guard_minute_times[guard][index] = times_asleep
    }
  }
  guard_most_minutes_asleep = minutes_asleep.max_by{|k,v| v}.first

  guard_most_minutes_asleep_most_asleep_at = guard_minute_times[guard_most_minutes_asleep].max_by{|k,v| v}.first

  guard_most_frequently_asleep_on_same_minute = ([:guard, :minute].zip(
    guard_minute_times.map{|guard, minute_times|
      minute, times = minute_times.max_by{|_, _times| _times}
      [times, [guard, minute]]
    }.max_by{|times, guard_minute| times}.each{|x| puts "!!! #{x} !!!"}.last)
  ).to_h

 return guard_most_minutes_asleep, guard_most_minutes_asleep_most_asleep_at, guard_most_frequently_asleep_on_same_minute
end
