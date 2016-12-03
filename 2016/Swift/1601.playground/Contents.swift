import Foundation


enum Orientation: Int, CustomStringConvertible {
    case North = 0
    case East
    case South
    case West
    
    //
    // CustomStringConvertible
    //
    var description: String {
        switch self {
        case .North : return "North"
        case .East  : return "East"
        case .South : return "South"
        case .West  : return "West"
        }
    }
}

enum Direction: Int {
    case Left
    case Right
}

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

    func walk(_ orientation:Orientation) {
        switch orientation {
            case .North : y = y + 1
            case .South : y = y - 1
            case .East  : x = x + 1
            case .West  : x = x - 1
        }
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
    // CustomStringConvertible
    //
    var description: String { return "(" + String(x) + "," + String(y) + ")" }
}


class Heading: CustomStringConvertible {
    
    public var orientation = Orientation.North
    
    init(_ orientation:Orientation) {
        self.orientation = orientation
    }
    
    func turn(_ direction:Direction) {
        
        var orientationChange = 0
        
        if direction == Direction.Left {
            orientationChange = -1
        } else {
            orientationChange = 1
        }
        
        orientation = Orientation(rawValue:(((orientation.rawValue + orientationChange) + 4) % 4))!
        
    }
    
    //
    // CustomStringConvertible
    //
    var description: String {
        return orientation.description
    }
}

func AoC1601(_ path:String) {
    
    let pos = Point(0,0)
    let heading = Heading(.North)
    
    var prevPositions = Set<Point>()
    var firstDuplicatePosition:Point?
    
    
    for str in path.components(separatedBy: ", ") {
        
        if str.hasPrefix("L") {
            heading.turn(Direction.Left)
        } else {
            heading.turn(Direction.Right)
        }
        
        let len = Int(String(str.characters.dropFirst()))!
        
        let oldPos = pos
        
        for _ in 0..<len {
            
            pos.walk(heading.orientation)
            
            if prevPositions.contains(pos) {
                
                if firstDuplicatePosition == nil {
                    print("Duplicate Position")
                    firstDuplicatePosition = Point(pos)
                }
                
            } else {
                prevPositions.insert(Point(pos))
            }
            
        }
        
        print("\(oldPos) + \(str) [\(heading), \(len)] = \(pos)")
        
    }
    
    print("\n Total Distance: \(String(pos.distance()))\n")
    
    if let dupe = firstDuplicatePosition {
        print("\n First Duplicate Position: \(dupe) at distance: \(String(dupe.distance()))\n")
    }
}


AoC1601("L4, L3, R1, L4, R2, R2, L1, L2, R1, R1, L3, R5, L2, R5, L4, L3, R2, R2, L5, L1, R4, L1, R3, L3, R5, R2, L5, R2, R1, R1, L5, R1, L3, L2, L5, R4, R4, L2, L1, L1, R1, R1, L185, R4, L1, L1, R5, R1, L1, L3, L2, L1, R2, R2, R2, L1, L1, R4, R5, R53, L1, R1, R78, R3, R4, L1, R5, L1, L4, R3, R3, L3, L3, R191, R4, R1, L4, L1, R3, L1, L2, R3, R2, R4, R5, R5, L3, L5, R2, R3, L1, L1, L3, R1, R4, R1, R3, R4, R4, R4, R5, R2, L5, R1, R2, R5, L3, L4, R1, L5, R1, L4, L3, R5, R5, L3, L4, L4, R2, R2, L5, R3, R1, R2, R5, L5, L3, R4, L5, R5, L3, R1, L1, R4, R4, L3, R2, R5, R1, R2, L1, R4, R1, L3, L3, L5, R2, R5, L1, L4, R3, R3, L3, R2, L5, R1, R3, L3, R2, L1, R4, R3, L4, R5, L2, L2, R5, R1, R2, L4, L4, L5, R3, L4")


