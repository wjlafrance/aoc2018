import Foundation

let inputPath = "input1.txt"
guard let inputFile = try? Data(contentsOf: URL(fileURLWithPath: inputPath)) else {
    fatalError("Could not open input file")
}

let boxIdentifiers = inputFile.split(separator: 0x0A).map { data -> [Character] in
    guard let string = String(data: data, encoding: .ascii) else { fatalError() }
    return string.map { $0 }
}

for left in boxIdentifiers {
    for right in boxIdentifiers {
        let similar = zip(left, right).filter(==).map { $0.0 }
        if similar.count == left.count - 1 {
            print(String(similar))
        }
    }
}
