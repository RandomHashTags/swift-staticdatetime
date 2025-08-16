
import StaticDateTimes
import Testing

@Suite
struct MiscTests {
    @Test
    func time_interval_values() {
        var (days, hours, minutes, seconds) = 34567.values
        #expect(days == 0)
        #expect(hours == 9)
        #expect(minutes == 36)
        #expect(seconds == 7)

        (days, hours, minutes, seconds) = 61.values
        #expect(days == 0)
        #expect(hours == 0)
        #expect(minutes == 1)
        #expect(seconds == 1)
    }

    @Test
    func excluded_days() async throws {
        let excluded:Set<StaticDate> = [
            StaticDate(year: 2024, month: 5, day: 2),
            StaticDate(year: 2024, month: 7, day: 4)
        ]
        #expect(excluded.contains(StaticDate(year: 2024, month: 5, day: 2)))
        #expect(excluded.contains(StaticDateTime(date: StaticDate(year: 2024, month: 5, day: 2), time: StaticTime(hour: 0, minute: 0)).staticDate))

        let starts = StaticDateTime(date: StaticDate(year: 2024, month: 4, day: 25), time: StaticTime(hour: 18, minute: 30))
        let ends = StaticDate(year: 2024, month: 8, day: 1)
        var event_days = 0
        var league_starts = starts
        while league_starts.staticDate <= ends {
            event_days += excluded.contains(league_starts.staticDate) ? 0 : 1
            league_starts.add(.days(7))
        }
        #expect(event_days == 13)
    }
}