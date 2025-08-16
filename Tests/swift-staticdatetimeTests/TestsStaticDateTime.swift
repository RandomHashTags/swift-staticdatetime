
import Testing
@testable import StaticDateTimes

struct TestsStaticDateTime {
    @Test func date_time_addition() {
        var dt = StaticDateTime(year: 2024, month: 1, day: 1, hour: 0, minute: 0)
        dt.add(Double.days(1))
        #expect(dt == StaticDateTime(year: 2024, month: 1, day: 2, hour: 0, minute: 0))

        dt.add(Double.days(30))
        #expect(dt == StaticDateTime(year: 2024, month: 2, day: 1, hour: 0, minute: 0))

        dt.add(Double.days(28))
        #expect(dt == StaticDateTime(year: 2024, month: 2, day: 29, hour: 0, minute: 0))

        dt.add(Double.days(306))
        #expect(dt == StaticDateTime(year: 2024, month: 12, day: 31, hour: 0, minute: 0))
        
        dt.add(Double.days(1))
        #expect(dt == StaticDateTime(year: 2025, month: 1, day: 1, hour: 0, minute: 0))
        
        dt.add(Double.days(31))
        #expect(dt == StaticDateTime(year: 2025, month: 2, day: 1, hour: 0, minute: 0))

        dt.add(Double.days(28))
        #expect(dt == StaticDateTime(year: 2025, month: 3, day: 1, hour: 0, minute: 0))


        dt = StaticDateTime(year: 2024, month: 1, day: 31, hour: 0, minute: 0)
        dt.add(Double.days(1))
        #expect(dt == StaticDateTime(year: 2024, month: 2, day: 1, hour: 0, minute: 0))


        dt = StaticDateTime(year: 2024, month: 1, day: 5, hour: 0, minute: 0)
        dt.add(Double.weeks(3))
        #expect(dt == StaticDateTime(year: 2024, month: 1, day: 26, hour: 0, minute: 0))

        dt.add(Double.weeks(3))
        #expect(dt == StaticDateTime(year: 2024, month: 2, day: 16, hour: 0, minute: 0))
        

        dt = StaticDateTime(year: 2023, month: 5, day: 1, hour: 6, minute: 30)
        dt.add(Double.weeks(1))
        #expect(dt == StaticDateTime(year: 2023, month: 5, day: 8, hour: 6, minute: 30))

        dt.add(Double.days(365))
        #expect(dt == StaticDateTime(year: 2024, month: 5, day: 7, hour: 6, minute: 30)) // february gets an extra day (2024 is a leap year)

        dt.add(Double.days(365))
        #expect(dt == StaticDateTime(year: 2025, month: 5, day: 7, hour: 6, minute: 30))
    }

    @Test func date_time_day_of_week() {
        var dt:StaticDateTime = StaticDateTime(year: 0, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .saturday)

        dt = StaticDateTime(year: 400, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .saturday)

        dt = StaticDateTime(year: 800, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .saturday)

        
        dt = StaticDateTime(year: 1000, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .wednesday)

        dt = StaticDateTime(year: 1001, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .thursday)

        dt = StaticDateTime(year: 1002, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .friday)

        dt = StaticDateTime(year: 1003, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .saturday)

        dt = StaticDateTime(year: 1004, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .sunday)

        dt = StaticDateTime(year: 1005, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .tuesday)

        dt = StaticDateTime(year: 1006, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .wednesday)

        dt = StaticDateTime(year: 1007, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .thursday)

        dt = StaticDateTime(year: 1008, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .friday)

        dt = StaticDateTime(year: 1009, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .sunday)

        
        dt = StaticDateTime(year: 1300, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .friday)
        
        dt = StaticDateTime(year: 1400, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .wednesday)

        dt = StaticDateTime(year: 1800, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .wednesday)

        dt = StaticDateTime(year: 2200, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .wednesday)


        dt = StaticDateTime(year: 2000, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .saturday)

        dt = StaticDateTime(year: 2001, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .monday)

        dt = StaticDateTime(year: 2002, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .tuesday)

        dt = StaticDateTime(year: 2003, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .wednesday)
        
        dt = StaticDateTime(year: 2004, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .thursday)

        dt = StaticDateTime(year: 2005, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .saturday)

        dt = StaticDateTime(year: 2024, month: 1, day: 1, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .monday)

        dt = StaticDateTime(year: 2024, month: 1, day: 25, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .thursday)

        dt = StaticDateTime(year: 2023, month: 5, day: 31, hour: 0, minute: 0)
        #expect(dt.dayOfWeek == .wednesday)
    }
}

// MARK: StaticTime
extension TestsStaticDateTime {
    @Test func time_addition() {
        var time = StaticTime(hour: 0, minute: 0)
        var days:Int = time.add(.hours(5))
        #expect(time == StaticTime(hour: 5, minute: 0))
        #expect(days == 0)

        days = time.add(.hours(19) + .minutes(30))
        #expect(time == StaticTime(hour: 0, minute: 30))
        #expect(days == 1)

        days = time.add(.minutes(35))
        #expect(time == StaticTime(hour: 1, minute: 5))
        #expect(days == 0)
    }

    @Test func time_subtraction() {
        var time:StaticTime = StaticTime(hour: 5, minute: 0)
        var days:Int = time.subtract(.hours(3))
        #expect(time == StaticTime(hour: 2, minute: 0))
        #expect(days == 0)

        days = time.subtract(.minutes(1))
        #expect(time == StaticTime(hour: 1, minute: 59))
        #expect(days == 0)

        days = time.subtract(.hours(2))
        #expect(time == StaticTime(hour: 23, minute: 59))
        #expect(days == 1)

        days = time.subtract(.minutes(30))
        #expect(time == StaticTime(hour: 23, minute: 29))
        #expect(days == 0)

        days = time.subtract(.minutes(29))
        #expect(time == StaticTime(hour: 23, minute: 0))
        #expect(days == 0)

        days = time.subtract(.minutes(60))
        #expect(time == StaticTime(hour: 22, minute: 0))
        #expect(days == 0)

        days = time.subtract(.minutes(61))
        #expect(time == StaticTime(hour: 20, minute: 59))
        #expect(days == 0)

        time = StaticTime(hour: 6, minute: 30)
        days = time.subtract(.minutes(30))
        #expect(time == StaticTime(hour: 6, minute: 0))
        #expect(days == 0)

        days = time.subtract(.minutes(1))
        #expect(time == StaticTime(hour: 5, minute: 59))
        #expect(days == 0)

        time = StaticTime(hour: 6, minute: 30)
        days = time.subtract(.minutes(31))
        #expect(time == StaticTime(hour: 5, minute: 59))
        #expect(days == 0)
    }

    @Test func time_distance() {
        var time:StaticTime = StaticTime(hour: 0, minute: 0)
        var distance:StaticTime = time.distance(to: StaticTime(hour: 2, minute: 30))
        #expect(distance == StaticTime(hour: 2, minute: 30))

        time = StaticTime(hour: 12, minute: 0)
        distance = time.distance(to: StaticTime(hour: 13, minute: 0))
        #expect(distance == StaticTime(hour: 1, minute: 0))

        distance = time.distance(to: StaticTime(hour: 11, minute: 0))
        #expect(distance == StaticTime(hour: -1, minute: 0))
    }
    
    @Test func time_abs() {
        var time:StaticTime = StaticTime(hour: 15, minute: 0)
        #expect(abs(time) == StaticTime(hour: 15, minute: 0))

        time = StaticTime(hour: -15, minute: 0)
        #expect(abs(time) == StaticTime(hour: 15, minute: 0))

        time = StaticTime(hour: 15, minute: -10)
        #expect(abs(time) == StaticTime(hour: 15, minute: 10))

        time = StaticTime(hour: -15, minute: -10)
        #expect(abs(time) == StaticTime(hour: 15, minute: 10))
    }
}