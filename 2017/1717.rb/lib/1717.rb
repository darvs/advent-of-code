def exec_spinlock(filename)

  step = File.open(File.join('data', filename)).map(&:strip).select{|line| !line.empty?}
    .first.to_i

  spinlock = Array.new

  spinlock.insert(0,0)
  pos = 0

  (1..2017).each{|x|

    pos = ((pos + step) % spinlock.size) + 1

    if pos > spinlock.size then
      spinlock.insert(-1, x)
    else
      spinlock.insert(pos, x)
    end

  }

  puts "spinlock #{spinlock}"

  return spinlock[pos+1]
end


# We actually don't want to run the angry spinlock for 50 million times as that
# would use up a lot of resources.
#
# So, let's think a bit.
#
# We need to find the value after 0. 
# Because of the algorithm (we add 1 to the current position, extending the list if needed)
# the 0 will actually always stay in position 0.
#
# So to find out what's after 0, we just need to do is find out what is the last 
# number to be put in position 1 in the array.
#
# And so we can dispense with actually manipulating the array (which is expensive)
# and just concentrate on calculating positions (which is much cheaper)
#

def angry_spinlock(filename)

  step = File.open(File.join('data', filename)).map(&:strip).select{|line| !line.empty?}
    .first.to_i

  pos = 0
  size = 1
  last_at_1 = 0

  (1..50000000).each{|x|

    pos = ((pos + step) % size) + 1
    size += 1

    # Was this number (x) the latest to want to be written at position 1?
    if (pos == 1) then last_at_1 = x end

  }

  return last_at_1
end

