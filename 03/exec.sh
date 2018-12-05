echo "Part 1 - Swift Interpreted"
time swift part1.swift

echo ""

echo "Part 1 - Swift Compiled"
swiftc part1.swift
time ./part1
rm part1

echo ""

echo "Part 1 - Swift Compiled (-Ounchecked)"
swiftc -Ounchecked part1.swift
time ./part1
rm part1

echo ""

echo "Part 2 - Swift Interpreted"
time swift part2.swift

echo ""

echo "Part 2 - Swift Compiled"
swiftc part2.swift
time ./part2
rm part2

echo ""

echo "Part 2 - Swift Compiled (-Ounchecked)"
swiftc -Ounchecked part2.swift
time ./part2
rm part2
