def process_claim(claim_ids, inches, claim)
  id = claim['id'].to_i
  x0 = claim['x'].to_i
  y0 = claim['y'].to_i
  w  = claim['w'].to_i
  h  = claim['h'].to_i

  claim_ids.add(id)

  for y in    y0 .. y0 + h - 1
    for x in  x0 .. x0 + w - 1
      inches[x][y].add(id)
    end
  end
end

def parse(str)
  # Sample format :  #1 @ 1,3: 4x4
  regexp=/#(?<id>[0-9]+) @ (?<x>[0-9]+),(?<y>-?[0-9]+): (?<w>[0-9]+)x(?<h>[0-9]+)/

  #print "STR #{str} "
  #print "SCAN #{str.scan(regexp)}\n"

  return str.scan(regexp).map{|match|
    Hash[regexp.names.zip(match)]
  }.first
end

def exec_file(filename)
  # inches[x][y] = Set of claims over x,y
  inches = Hash.new {|h,k| h[k] = Hash.new {|h1,k1| h1[k1] = Set.new}}
  claim_ids = Set.new
  conflicted_claims = Set.new

  File.open(File.join('data', filename)).map(&:strip).select{|line| !line.empty?}
    .map {|str| parse(str)}
    .map {|claim| process_claim(claim_ids, inches, claim)}

  #puts "INCHES:: #{inches}"

  count = inches.map{|x,y_claims| 
    y_claims.map{|y,claims| 
      if (claims.size() > 1 ) then
        claims.each{|c| conflicted_claims.add(c)}
        1
      else
        0
      end
    }
  }.flatten.reduce(&:+)

  unconflicted_claims = claim_ids - conflicted_claims

  return count, unconflicted_claims
end
