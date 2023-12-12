# frozen_string_literal: true

# Stars
class Stars
  def initialize(lines)
    @galaxies = []
    @lines = Array.new(lines)
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def read_stars(lines, expansion_factor)
    @rows = Hash.new(expansion_factor)
    @columns = Hash.new(expansion_factor)

    @x_max = lines[0].length - 1
    @y_max = lines.length - 1

    # map the stars
    lines.each_with_index{|columns, y|
      columns.chars.each_with_index.map{|sym, x| [sym, x]}
             .select{|sym, _| sym == '#'}
             .each{|_, x| 
                @galaxies.append([x, y]) # Add galaxy
                @columns[x] = 1 # column has a galaxy
                @rows[y] = 1 # line has a galaxy
             }
    }
    #puts "galaxies #{@galaxies}"

    @x_empty = (0..@x_max).map{|x| [x, @columns[x]]}
                          .select{|_, val| val == 2}
                          .map{|x, _| x}

    @y_empty = (0..@y_max).map{|y| [y, @rows[y]]}
                          .select{|_, val| val == 2}
                          .map{|y, _| y}

    #puts "columns #{@columns}"
    #puts "rows #{@rows}"
    #puts "x_empty #{@x_empty}"
    #puts "y_empty #{@y_empty}"
  end

  def distance(expansion_factor)
    read_stars(@lines, expansion_factor)

    n = @galaxies.length
    (0..(n - 2)).map{|g1|
      ((g1 + 1)..(n - 1)).map{|g2|
        p1x, p1y = @galaxies[g1]
        p2x, p2y = @galaxies[g2]
        x_range = [p1x, p2x].sort
        y_range = [p1y, p2y].sort
        x_dist = ((x_range[0] + 1)..x_range[1]).map{|x| @columns[x]}.sum
        y_dist = ((y_range[0] + 1)..y_range[1]).map{|y| @rows[y]}.sum
        distance = x_dist + y_dist
        #puts "g1 #{@galaxies[g1]} g2 #{@galaxies[g2]} x_range #{x_range} x_dist #{x_dist} y_range #{y_range} y_dist #{y_dist} d #{distance}"
        distance
      }.sum
    }.sum
  end
end
