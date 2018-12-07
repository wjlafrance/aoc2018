import Foundation

let inputPath = "input1.txt"
guard
    let inputFile = try? Data(contentsOf: URL(fileURLWithPath: inputPath)),
    let string = String(data: inputFile, encoding: .ascii)?.trimmingCharacters(in: .whitespacesAndNewlines)
else {
    fatalError("Could not open input file")
}

let units = [
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m",
    "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"
]

extension String {
    var hasRemainingOppositePolarityUnits: Bool {
        for unit in units {
            if self.contains("\(unit)\(unit.uppercased())") || self.contains("\(unit.uppercased())\(unit)") {
                return true
            }
        }
        return false
    }

    var react: String {
        var polymer = self
        while polymer.hasRemainingOppositePolarityUnits {
            for unit in units {
                polymer = polymer.replacingOccurrences(of: "\(unit)\(unit.uppercased())", with: "")
                polymer = polymer.replacingOccurrences(of: "\(unit.uppercased())\(unit)", with: "")
            }
        }
        return polymer
    }
}

print(string.react.count)
