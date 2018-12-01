import Foundation

let inputPath = "input1.txt"
guard let d = try? Data(contentsOf: URL(fileURLWithPath: inputPath)) else {
  fatalError("Could not open input file")
}

let total = d.split(separator: 0x0A).map {
  guard let string = String(data: $0, encoding: .ascii), let int = Int(string) else {
    fatalError("Could not parse integer from \($0)")
  }
  return int
}.reduce(0, +)

print(total)
