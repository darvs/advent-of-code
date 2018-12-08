# frozen_string_literal: true

def parse_int(nodes, index = 0)
  [nodes[index], index + 1]
end

def parse(nodes, index = 0)
  children = []
  metadata = []
  metadata_total = 0
  value = 0

  n_children, index = parse_int(nodes, index)
  n_metadata, index = parse_int(nodes, index)

  puts "n_children #{n_children} n_metadata #{n_metadata}"

  (1..n_children).each do
    child_node, metadata_children_total, index = parse(nodes, index)
    puts "child_node #{child_node} index #{index}"
    children += [child_node]
    metadata_total += metadata_children_total
  end
  puts "children #{children}"

  (1..n_metadata).each do
    entry, index = parse_int(nodes, index)
    metadata += [entry]
    metadata_total += entry

    if children.empty?
      value += entry
    elsif entry.positive? && entry <= children.size
      puts "entry #{entry} children #{children}"
      value += children[entry - 1][2]
    end
  end

  puts "returning [[#{children}, #{metadata}, #{value}], #{metadata_total}, #{index}]"
  [[children, metadata, value], metadata_total, index]
end

def exec_file(filename)
  input = File.open(File.join('data', filename))
              .map(&:strip)
              .reject(&:empty?)
              .first
              .split(" ")
              .map(&:to_i)

  puts input

  parsed, total, = parse(input)

  value = parsed[2]

  [total, value]
end
