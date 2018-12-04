def parse(line, schedule, context)

  minute = /\[\d{4}-\d{2}-\d{2} \d{2}:(?<minute>\d{2})\]/.match(line)['minute'].to_i
  #puts "minute #{minute}"

  case line
  when /Guard #(\d+) begins shift/
    context[:guard] = $~[1].to_i
    context[:fell_asleep_at] = -1
    #puts "guard #{context[:guard]}"

  when /falls asleep/
    context[:fell_asleep_at] = minute
    #puts "falls asleep at #{minute}"

  when /wakes up/
    # The guard was asleep in all the minutes between the last time he fell asleep and the minute before the current minute

    #puts "wakes up at #{minute}"

    for m in context[:fell_asleep_at] .. ((minute - 1) % 60)
      #puts "schedule #{schedule}"
      #puts "schedule[m] #{schedule[m]}"
      #puts "context[:guard] #{context[:guard]}"
      #puts "schedule[m][context[:guard]] #{schedule[m][context[:guard]]}"
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

  #puts "schedule #{schedule}"

  minutes_asleep = Hash.new(0)
  guard_minute_asleep_times = Hash.new{|h,k| h[k] = Hash.new}

  schedule.each_with_index{|minute, index|
    minute.each{|guard,times_asleep|
      minutes_asleep[guard] += times_asleep

      #puts "guard #{guard} index #{index} times_asleep #{times_asleep}"

      guard_minute_asleep_times[guard][index] = times_asleep
      #puts "tmp g_m_a_t #{guard_minute_asleep_times}"
      
    }
  }
  guard_most_minutes_asleep = minutes_asleep.max_by{|k,v| v}.first

  puts "g_m_a_t #{guard_minute_asleep_times}"

  guard_most_minutes_asleep_most_asleep_at = guard_minute_asleep_times[guard_most_minutes_asleep].max_by{|k,v| v}.first

  #puts "minutes #{minutes_asleep}"

  print "---->"
  guard_most_frequently_asleep_on_same_minute = ([:guard, :minute].zip(guard_minute_asleep_times.map{|guard, minute_asleep_times| [minute_asleep_times.max_by{|minute, asleep_times| asleep_times}.last,[guard, minute_asleep_times.max_by{|minute, asleep_times| asleep_times}.first]]}.max_by{|asleep_times, guard_minute| asleep_times}.last)).to_h

  print guard_most_frequently_asleep_on_same_minute
  print "<----"

  return guard_most_minutes_asleep, guard_most_minutes_asleep_most_asleep_at, guard_most_frequently_asleep_on_same_minute
end
