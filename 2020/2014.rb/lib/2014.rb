# frozen_string_literal: true

# Program
class Program
  def initialize(list)
    @mask = ''
    @pgm = parse(list)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def parse(list)
    list.map{|line|
      lhs, val = line.split('=')
      ins = lhs.split(/[ \[\]]/)
      [ins, val.strip]
    }
  end

  def run
    @pgm.each.with_object(Hash.new(0)){|line, mem|
      #puts line.to_s

      ins, arg = line

      case ins.first
      when 'mask'
        @mask = arg
      when 'mem'
        set_mem(mem, ins.last.to_i, arg.to_i)
      end
    }.map{|_, val| val}.sum
  end

  def set_mem(mem, addr, val)
    #init = val
    @mask.each_char.with_index{|ch, index|
      bit = 2**(35 - index)

      #puts "#{index} #{ch} #{bit} #{val}"
      case ch
      when '0'
        val -= bit if val & bit != 0
      when '1'
        val |= bit
      end
    }
    #puts "val #{init} => #{val}"

    mem[addr] = val
  end
end

# MAD: Memory Address Decoder
class MAD < Program
  def set_mem(mem, addr, val)
    # To set the 1s
    #puts "addr #{addr.to_s(2).rjust(36, '0')}"

    @mask.each_char.with_index{|ch, index|
      bit = 2**(35 - index)
      addr |= bit if ch == '1'
    }

    xpos = @mask.chars.map.with_index{|x, i| [x, i]}
                .select{|x, _| x == 'X'}.map{|_, i| i}
    xs = (0..(2**xpos.length) - 1).map{|s| s.to_s(2).rjust(xpos.length, '0')}

    #puts "xpos #{xpos} xs #{xs}"
    #puts "mask #{@mask}"
    #puts "addr #{addr.to_s(2).rjust(36, '0')}"

    addr_list = []
    (0..xs.length - 1).each{|n|
      new_addr = addr.dup.to_s(2).rjust(36, '0')
      xpos.each_with_index{|pos, index|
        new_addr[pos] = xs[n][index]
      }
      addr_list += [new_addr]
    }
    #puts "addr_list #{addr_list}"

    addr_list.each{|a|
      mem[a.to_i(2)] = val
    }
  end
end
