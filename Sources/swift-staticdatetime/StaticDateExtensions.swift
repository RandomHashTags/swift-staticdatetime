

// MARK: Codable
extension StaticDate: Codable {

    @inlinable
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        year = try container.decode(Int64.self, forKey: .year)
        month = try container.decode(Int64.self, forKey: .month)
        day = try container.decode(Int64.self, forKey: .day)
    }

    @inlinable
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(year, forKey: .year)
        try container.encode(month, forKey: .month)
        try container.encode(day, forKey: .day)
    }

    public enum CodingKeys: CodingKey {
        case year
        case month
        case day
    }
}

// MARK: Comparable
extension StaticDate: Comparable {
    @inlinable
    public static func < (left: Self, right: Self) -> Bool {
        guard left.year == right.year else { return left.year < right.year }
        guard left.month == right.month else { return left.month < right.month }
        return left.day < right.day
    }
}

// MARK: Hashable
extension StaticDate: Hashable {
}

// MARK: General
extension StaticDate {
    @inlinable
    public init(year: Int, month: Int, day: Int) {
        self.year = Int64(year)
        self.month = Int64(month)
        self.day = Int64(day)
    }

    @inlinable
    public init?(htmlDate: some StringProtocol) {
        let values = htmlDate.split(separator: "-")
        guard values.count == 3, let year = Int64(values[0]), let month = Int64(values[1]), let day = Int64(values[2]) else { return nil }
        self.year = year
        self.month = month
        self.day = day
    }

    @inlinable
    public init?(eventDate: some StringProtocol) {
        let values = eventDate.split(separator: "/")
        guard values.count == 3, let year = Int64(values[2]), let month = Int64(values[0]), let day = Int64(values[1]) else { return nil }
        self.year = year
        self.month = month
        self.day = day
    }

    @inlinable
    public var dateString: String {
        return "\(year)-\(month < 10 ? "0" : "")\(month)-\(day < 10 ? "0" : "")\(day)"
    }

    @inlinable
    public var dayOfWeek: UInt8 {
        let index = year % 400
        guard index != 0 else { return UInt8.saturday }
        let previousLeapYears:Int64 = ((year - index)..<year).reduce(0, { $0 + ($1.isLeapYear ? 1 : 0) })
        let previousMonthDaysForYear = (0...month-1).reduce(0, { $0 + $1.daysInMonth(year: year) })
        return UInt8.saturday.add(Int64(previousMonthDaysForYear) + Int64(day - 1) + ((index - previousLeapYears) * 365) + (previousLeapYears * 366))
    }

    
}

#if canImport(Foundation)

import Foundation

extension StaticDate: CustomStringConvertible {
    @inlinable
    public init(_ date: Date) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
        year = Int64(components.year!)
        month = Int64(components.month!)
        day = Int64(components.day!)
    }

    @inlinable
    public func date(time: StaticTime) -> Date? {
        return DateComponents(
            calendar: Calendar.current,
            timeZone: TimeZone.current,
            year: Int(year),
            month: Int(month),
            day: Int(day),
            hour: Int(time.hour),
            minute: Int(time.minute)
        ).date
    }

    @inlinable
    public var description: String {
        guard let date = date(time: StaticTime(hour: 0, minute: 0)) else { return "nil" }
        return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
    }
}

#else

extension StaticDate: CustomStringConvertible {
    @inlinable
    public var description: String {
        guard let date = date(time: StaticTime(hour: 0, minute: 0)) else { return "nil" }
        return "\(date)" // TODO: fix
    }
}

#endif