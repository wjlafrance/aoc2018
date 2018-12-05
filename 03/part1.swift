import Foundation

struct Rectangle {
    let x: Int, y: Int, width: Int, height: Int

    var points: [IntPoint] {
        var points = [IntPoint]()
        for x in (x..<x + width) {
            for y in (y..<y + height) {
                points.append(IntPoint(x: x, y: y))
            }
        }
        return points
    }
}

struct IntPoint: Hashable, Equatable {
    let x: Int, y: Int

    static func ==(lhs: IntPoint, rhs: IntPoint) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }
}

let inputPath = "input1.txt"
guard let inputFile = try? Data(contentsOf: URL(fileURLWithPath: inputPath)) else {
    fatalError("Could not open input file")
}

let records = inputFile.split(separator: 0x0A).map { data -> String in
    guard let string = String(data: data, encoding: .ascii) else { fatalError() }
    return string
}

let rectangles = records.map { record -> (Int, Rectangle) in
    var index = 0, originX = 0, originY = 0, width = 0, height = 0
    let scanner = Scanner.init(string: record)
    scanner.scanLocation += 1
    guard scanner.scanInt(&index) else { fatalError() }
    scanner.scanLocation += 3
    guard scanner.scanInt(&originX) else { fatalError() }
    scanner.scanLocation += 1
    guard scanner.scanInt(&originY) else { fatalError() }
    scanner.scanLocation += 2
    guard scanner.scanInt(&width) else { fatalError() }
    scanner.scanLocation += 1
    guard scanner.scanInt(&height) else { fatalError() }

    return (index, Rectangle(x: originX, y: originY, width: width, height: height))
}

var occupiedPoints = Set<IntPoint>()
var twiceOccupiedPoints = Set<IntPoint>()

for (_, rectangle) in rectangles {
    for point in rectangle.points {
        if occupiedPoints.contains(point) {
            twiceOccupiedPoints.insert(point)
        }
        occupiedPoints.insert(point)
    }
}

print(twiceOccupiedPoints.count)
