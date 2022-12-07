# frozen_string_literal: true

# Shell
class Shell
  def initialize(list)
    @current_dir = []
    @fs = Hash.new{|h, k| h[k] = Hash.new(0)}
    @du = Hash.new(0)

    list.each{|line| parse(line)}

  end

  def parse(str)
    p str
    case str
    #when /\$ cd \//
    when %r{\$ cd /}
      #p '  GO ROOT'
      @current_dir = []
    when /\$ cd \.\./
      #p '  GO BACK'
      @current_dir.pop
    when /\$ cd (\w+)/
      #p "  CAUGHT #{::Regexp.last_match(1)}"
      @current_dir.append(::Regexp.last_match(1))
    when /(\d+) (\S+)/
      size = ::Regexp.last_match(1).to_i
      file = ::Regexp.last_match(2)
      #p "  FILE bytes:#{size} name:#{file}"

      path_name = Array.new(@current_dir)

      @fs[Array.new(@current_dir)][file] = size

      until path_name.empty?
        @du[dir_name(path_name)] += size
        path_name.pop
      end
      @du['/'] += size

      #p @fs
    else
      p '  SKIPPIN\''
    end
  end

  def dir_name(dir)
    return '/' if dir.empty?

    "/#{dir.join('/')}/"
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:chomp))
  end

  def sum_of_total_sizes
    p 'fs ------------------------'
    @fs.each_key{|k|
      p [dir_name(k), @fs[k]]
    }

    p 'du ------------------------'
    @du.each_key{|k|
      p [k, @du[k]]
    }

    @du.each_key.select{|k| @du[k] <= 100_000}.map{|k| @du[k]}.sum
  end

  def space_to_free
    space_needed = 30000000 - ( 70000000 - @du['/'])
    p "Space needed #{space_needed}"

    @du.each_key.select{|k| @du[k] >= space_needed }.map{|k| @du[k]}.min
  end

end
