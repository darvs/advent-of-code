import Foundation


class Point : Hashable, CustomStringConvertible {
    var x: Int = 0
    var y: Int = 0
    
    init(_ x:Int, _ y:Int) {
        self.x = x
        self.y = y
    }
    
    init(_ p:Point) {
        self.x = p.x
        self.y = p.y
    }
    
    func distance() -> Int {
        return abs(x) + abs(y)
    }
    
    //
    // Hashable (needs Equatable)
    //
    var hashValue: Int {
        return x.hashValue ^ y.hashValue
    }
    
    //
    // Equatable
    //
    static func == (lhs:Point, rhs:Point) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    //
    // Printable
    //
    var description: String { return "(" + String(x) + "," + String(y) + ")" }
}

func AoC1601(_ path:String) {
    
    enum orientations: Int {
        case North = 0
        case East
        case South
        case West
    }
    
    let orientationStrings = ["North", "East", "South", "West"]
    
    let pos = Point(0,0)
    
    var firstDuplicatePosition:Point?
    
    var prevPositions = Set<Point>()
    var orientation = orientations.North
    
    for str in path.components(separatedBy: ", ") {
        
        let len = Int(String(str.characters.dropFirst()))!
        
        var orientationChange = 0
        if str.hasPrefix("L") {
            orientationChange = -1
        } else {
            orientationChange = 1
        }
        
        orientation = orientations(rawValue:(((orientation.rawValue + orientationChange) + 4) % 4))!
        
        let oldPos = pos
        
        for _ in 0..<len {
            
            switch orientation {
                case orientations.North: pos.y = pos.y + 1
                case orientations.South: pos.y = pos.y - 1
                case orientations.East: pos.x = pos.x + 1
                case orientations.West: pos.x = pos.x - 1
            }
            
            if prevPositions.contains(pos) {
                print("Duplicate Position")
                
                if firstDuplicatePosition == nil {
                    firstDuplicatePosition = Point(pos)
                }
                
            } else {
                prevPositions.insert(Point(pos))
            }
            
        }
        
        
        print("\(oldPos) + \(str) [\(orientationStrings[orientation.rawValue]), \(len)] = \(pos)")
        
    }
    
    print("\n Total Distance: \(String(pos.distance()))\n")
    
    if let dupe = firstDuplicatePosition {
        print("\n First Duplicate Position: \(dupe) at distance: \(String(dupe.distance()))\n")
    }
}


AoC1601("L4, L3, R1, L4, R2, R2, L1, L2, R1, R1, L3, R5, L2, R5, L4, L3, R2, R2, L5, L1, R4, L1, R3, L3, R5, R2, L5, R2, R1, R1, L5, R1, L3, L2, L5, R4, R4, L2, L1, L1, R1, R1, L185, R4, L1, L1, R5, R1, L1, L3, L2, L1, R2, R2, R2, L1, L1, R4, R5, R53, L1, R1, R78, R3, R4, L1, R5, L1, L4, R3, R3, L3, L3, R191, R4, R1, L4, L1, R3, L1, L2, R3, R2, R4, R5, R5, L3, L5, R2, R3, L1, L1, L3, R1, R4, R1, R3, R4, R4, R4, R5, R2, L5, R1, R2, R5, L3, L4, R1, L5, R1, L4, L3, R5, R5, L3, L4, L4, R2, R2, L5, R3, R1, R2, R5, L5, L3, R4, L5, R5, L3, R1, L1, R4, R4, L3, R2, R5, R1, R2, L1, R4, R1, L3, L3, L5, R2, R5, L1, L4, R3, R3, L3, R2, L5, R1, R3, L3, R2, L1, R4, R3, L4, R5, L2, L2, R5, R1, R2, L4, L4, L5, R3, L4")


