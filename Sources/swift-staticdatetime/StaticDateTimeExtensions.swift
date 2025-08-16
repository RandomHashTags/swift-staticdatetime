
import FoundationEssentials

// MARK: Codable
extension StaticDateTime: Codable {

    @inlinable
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        staticDate = try container.decode(StaticDate.self, forKey: .staticDate)
        staticTime = try container.decode(StaticTime.self, forKey: .staticTime)
    }

    @inlinable
    public func encode(to encoder: any Encoder) throws {
        var encoder = encoder.container(keyedBy: CodingKeys.self)
        try encoder.encode(staticDate, forKey: .staticDate)
        try encoder.encode(staticTime, forKey: .staticTime)
    }

    public enum CodingKeys: CodingKey {
        case staticDate
        case staticTime
    }
}

// MARK: Comparable
extension StaticDateTime: Comparable {
    @inlinable
    public static func < (left: StaticDateTime, right: StaticDateTime) -> Bool {
        guard left.staticDate == right.staticDate else { return left.staticDate < right.staticDate }
        return left.staticTime < right.staticTime
    }
}

// MARK: Hashable
extension StaticDateTime: Hashable {
}

// MARK: General
extension StaticDateTime {
    @inlinable
    public init(_ date: Date) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        staticDate = StaticDate(year: components.year!, month: components.month!, day: components.day!)
        staticTime = StaticTime(hour: Int8(components.hour!), minute: Int8(components.minute!))
    }

    @inlinable
    public init(year: Int, month: Int, day: Int, hour: Int8, minute: Int8) {
        staticDate = StaticDate(year: year, month: month, day: day)
        staticTime = StaticTime(hour: hour, minute: minute)
    }

    @inlinable
    public init(date: StaticDate, time: StaticTime) {
        self.staticDate = date
        self.staticTime = time
    }

    @inlinable
    public var dayOfWeek : UInt8 {
        return staticDate.dayOfWeek
    }

    @inlinable
    public var dateString : String {
        return "\(staticDate.dateString)T\(staticTime.dateString)"
    }

    @inlinable
    public func adding(_ interval: TimeInterval) -> StaticDateTime {
        var copy = self
        copy.add(interval)
        return copy
    }

    @inlinable
    public mutating func add(_ interval: TimeInterval) {
        guard interval > 0 else { return }
        add(interval.values)
    }

    @inlinable
    public mutating func add(_ interval: (days: Int, hours: Int, minutes: Int, seconds: Int)) {
        staticDate.day += Int64(interval.days)
        var days_for_month = staticDate.month.daysInMonth(year: staticDate.year)
        while staticDate.day > days_for_month {
            staticDate.month += 1
            staticDate.day -= Int64(days_for_month)
            if staticDate.month > 12 {
                staticDate.year += 1
                staticDate.month = 1
            }
            days_for_month = staticDate.month.daysInMonth(year: staticDate.year)
        }
    }

    @inlinable
    public func date() -> Date? {
        return DateComponents(
            calendar: Calendar.current,
            timeZone: TimeZone.current,
            year: Int(staticDate.year),
            month: Int(staticDate.month),
            day: Int(staticDate.day),
            hour: Int(staticTime.hour),
            minute: Int(staticTime.minute)
        ).date
    }
}