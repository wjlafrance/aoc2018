import Foundation

let inputPath = "input1.txt"
guard let inputFile = try? Data(contentsOf: URL(fileURLWithPath: inputPath)) else {
    fatalError("Could not open input file")
}

let records = inputFile.split(separator: 0x0A).map { data -> String in
    guard let string = String(data: data, encoding: .ascii) else { fatalError() }
    return string
}.filter { !$0.isEmpty }

let journalEntries = records.map { string -> (Date, String) in
    let components = string.components(separatedBy: "] ")
    let formatter = DateFormatter()
    formatter.dateFormat = "[YYYY-MM-dd HH:mm"
    guard let date = formatter.date(from: components[0]) else { fatalError() }
    return (date, components[1])
}.sorted { $0.0 < $1.0 }

struct SleepWake {
    let badgeNumber: Int
    let asleep: Date
    let awake: Date

    var minuteFellAsleep: Int {
        return Calendar.current.component(.minute, from: asleep)
    }

    var durationMinutes: Int {
        return Int(awake.timeIntervalSince(asleep) / 60)
    }

    func isAsleepDuring(minute: Int) -> Bool {
        return minute >= minuteFellAsleep
            && minute < minuteFellAsleep + durationMinutes
    }
}

var sleeps = [SleepWake]()

var badgeNumber = -1
var fellAsleep = Date.distantPast
for (date, entry) in journalEntries {
    if entry.hasPrefix("Guard") { // Guard #3229 begins shift
        let scanner = Scanner(string: entry)
        scanner.scanLocation = 7
        guard scanner.scanInt(&badgeNumber) else { fatalError() }
    } else if entry == "falls asleep" {
        fellAsleep = date
    } else {
        sleeps.append(SleepWake(badgeNumber: badgeNumber, asleep: fellAsleep, awake: date))
    }
}

let badgeNumbers = Set(sleeps.map { $0.badgeNumber })
let sleepByBadgeNumber = badgeNumbers.map { badgeNumber in
    return (
        badgeNumber,
        sleeps.filter { $0.badgeNumber == badgeNumber },
        sleeps.filter { $0.badgeNumber == badgeNumber }
            .reduce(0) { $0 + $1.durationMinutes }
    )
}

let mostAsleep = sleepByBadgeNumber.sorted { $0.2 > $1.2 }.first!

let totalSleepPerMinute = (0..<60).map { minute in
    return (minute, mostAsleep.1.reduce(0) { $1.isAsleepDuring(minute: minute) ? $0 + 1 : $0 })
}
let minuteMostAsleep = totalSleepPerMinute.sorted { $0.1 > $1.1 }.first!.0

print(mostAsleep.0 * minuteMostAsleep)
