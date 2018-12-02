import Foundation

let inputPath = "input1.txt"
guard let inputFile = try? Data(contentsOf: URL(fileURLWithPath: inputPath)) else {
    fatalError("Could not open input file")
}

let boxIdentifiers = inputFile.split(separator: 0x0A).map { data -> String in
    guard let string = String(data: data, encoding: .ascii) else { fatalError() }
    return string
}

let repeats = boxIdentifiers.map { string -> (Bool, Bool) in
    let chars = string.map { $0 }
    let hasTwice = chars.contains { search in chars.filter({ $0 == search }).count == 2 }
    let hasThrice = chars.contains { search in chars.filter({ $0 == search }).count == 3 }
    return (hasTwice, hasThrice)
}

let counts = repeats.reduce((0, 0)) { (lhs, rhs) -> (Int, Int) in
    return (lhs.0 + (rhs.0 ? 1 : 0), lhs.1 + (rhs.1 ? 1 : 0))
}

print(counts.0 * counts.1)
