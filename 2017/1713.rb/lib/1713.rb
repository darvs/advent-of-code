def read_line(firewall, str)
  return unless (m = str.match(/(?<depth>[0-9]+): (?<range>[0-9]+)/))
  firewall[m[:depth].to_i] = m[:range].to_i
end

def read_file(filename)
  firewall = Hash.new 0
  File.open(File.join('data', filename)).each{|line| read_line(firewall, line)}
  firewall
end

def is_collision(depth, range, delay=0)
  ((depth + delay) % ((range - 1) * 2)) == 0
end

def severity(firewall)
  firewall.select{|depth, range| is_collision(depth, range)}
          .map{|depth, range| depth * range}
          .reduce(:+)
end

def safe_with_delay(firewall)
  delay = 0
  delay += 1 until firewall.find{|depth, range| is_collision(depth, range, delay)}.nil?
  delay
end
