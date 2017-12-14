require_relative '../../1710.rb/lib/1710.rb'

def calc_bin_hash(key, index)
  keyname = format('%<k>s-%<i>i', k: key, i: index)
  h = Hashf.new(256, 0)
  h.set_binary_input_lengths(keyname)
  h.calc(64)
  hash = h.hash

  hash.chars.map{|c| format('%<hc>04b', hc: c.to_i(16))}.reduce(:+)
end

def calc_all_hashes(key)
  (0..127).map{|i| calc_bin_hash(key, i)}
end

def used(hashes)
  hashes.map{|h| h.chars.select{|c| c == '1'}.length}.reduce(:+)
end

def are_neighbours(a, b)
  [[0, 1], [1, 0]].include?([a, b].transpose.map{|p, q| (p - q)})
end

def touches_set(set, p)
  set.each{|p0| return true if are_neighbours(p, p0)}
  false
end

def add_to_sets(sets, p)
  merged = Set.new([p])

  sets.select{|s| touches_set(s, p)}.each{|s|
    merged = merged.merge(s)
    sets.delete(s)
  }

  sets << merged
end

def regions(hashes)
  sets = Set.new

  hashes.each.with_index.flat_map{|h, y| h.chars.each.with_index.select{|c, _| c == '1'}.map{|_, x| [x, y]}}
        .each{|p| sets = add_to_sets(sets, p)}

  sets.length
end
