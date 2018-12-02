import Foundation

let inputPath = "input1.txt"
guard let inputFile = try? Data(contentsOf: URL(fileURLWithPath: inputPath)) else {
    fatalError("Could not open input file")
}

let sequence = inputFile.split(separator: 0x0A).map { data -> Int in
    guard let string = String(data: data, encoding: .ascii), let int = Int(string) else {
        fatalError()
    }
    return int
}

var frequency = 0
var previouslySeenFrequencies = Set<Int>()

while true {
    for x in sequence {
        previouslySeenFrequencies.insert(frequency)
        frequency += x
        if previouslySeenFrequencies.contains(frequency) {
            print(frequency)
            exit(0)
        }
    }
}
