# frozen_string_literal: true

# Wasteland
class Wasteland
  def initialize(lines)
    @lines = Array.new(lines)
    @nodes = Hash.new({})

    read_instructions
    read_nodes
  end

  def self.from_file(filename)
    new(File.readlines(File.join('data', filename))
      .map(&:strip))
  end

  def read_instructions
    @instructions = @lines.first.chars
  end

  def read_nodes
    @lines.drop(2).map{|line| line.scan(/\w+/)}.each{|node, left, right|
      @nodes[node] = { 'L' => left, 'R' => right }
    }
  end

  def steps(starting_point)
    #puts "instructions #{@instructions}"
    #puts "nodes #{@nodes}"

    n = 0
    current = starting_point.nil? ? @nodes.select{|k, _| k[2] == 'A'}.map{|_, v| v} : [@nodes[starting_point]]

    puts "#{current.length} starting points."

    loop do
      n += 1
      instruction = @instructions[(n - 1) % @instructions.length]
      # puts "n #{n} current #{current} instruction #{instruction}"
      break if current.all?{|cur| starting_point.nil? ? cur[instruction][2] == 'Z' : cur[instruction] == 'ZZZ'}

      current = current.map{|cur| @nodes[cur[instruction]]}
    end

    n
  end
end
