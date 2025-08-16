
@testable import StaticDateTimes
import Testing

struct TestsDayOfWeek {
    @Test func test_distance() {
        #expect(UInt8.sunday.dowDistance(to: UInt8.monday) == 1)
        #expect(UInt8.sunday.dowDistance(to: UInt8.saturday) == 6)
        #expect(UInt8.sunday.dowDistance(to: UInt8.sunday) == 7)

        #expect(UInt8.saturday.dowDistance(to: UInt8.sunday) == 1)
        #expect(UInt8.saturday.dowDistance(to: UInt8.friday) == 6)
        #expect(UInt8.saturday.dowDistance(to: UInt8.saturday) == 7)
    }
    @Test func test_addition() {
        #expect(UInt8.sunday.add(1) == UInt8.monday)
        #expect(UInt8.sunday.add(6) == UInt8.saturday)
        #expect(UInt8.sunday.add(7) == UInt8.sunday)

        #expect(UInt8.saturday.add(1) == UInt8.sunday)
        #expect(UInt8.saturday.add(2) == UInt8.monday)
        #expect(UInt8.saturday.add(6) == UInt8.friday)
        #expect(UInt8.saturday.add(7) == UInt8.saturday)
    }
}