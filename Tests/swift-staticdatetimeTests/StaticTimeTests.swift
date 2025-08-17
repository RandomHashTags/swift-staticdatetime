
import StaticDateTimes
import Testing

@Suite
struct StaticTimeTests {

    @Test
    func staticTimeInit() {
        var time = StaticTime(hour: 0, minute: 0)
        #expect(time == .init(hour: 0, minute: 0))

        time = .init(hour: UInt64.max, minute: UInt64.max)
        #expect(time == .init(hour: Int32.max, minute: Int32.max))

        time = .init(hour: Int64.min, minute: Int64.min)
        #expect(time == .init(hour: Int32.min, minute: Int32.min))
    }
}