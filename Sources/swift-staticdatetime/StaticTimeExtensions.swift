
// MARK: Codable
extension StaticTime: Codable {

    @inlinable
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hour = try container.decode(Int32.self, forKey: .hour)
        minute = try container.decode(Int32.self, forKey: .minute)
    }

    @inlinable
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(hour, forKey: .hour)
        try container.encode(minute, forKey: .minute)
    }

    public enum CodingKeys: CodingKey {
        case hour
        case minute
    }
}

// MARK: Comparable
extension StaticTime: Comparable {
    @inlinable
    public static func < (left: StaticTime, right: StaticTime) -> Bool {
        guard left.hour == right.hour else { return left.hour < right.hour }
        return left.minute < right.minute
    }
}

// MARK: CustomStringConvertible
extension StaticTime: CustomStringConvertible {
    @inlinable
    public var description: String {
        return "\(hour):\(minute >= 10 ? "\(minute)" : "0\(minute)")"
    }
}

// MARK: Hashable
extension StaticTime: Hashable {
}

// MARK: General
extension StaticTime {
    @inlinable
    public init(
        hour: some FixedWidthInteger,
        minute: some FixedWidthInteger
    ) {
        self.hour = Int32(hour)
        self.minute = Int32(minute)
    }

    @inlinable
    public init?(htmlTime: some StringProtocol) {
        let values = htmlTime.split(separator: ":")
        guard values.count == 2, let hour = Int32(values[0]), let minute = Int32(values[1]) else { return nil }
        self.hour = hour
        self.minute = minute
    }

    @inlinable
    public var dateString: String {
        return "\(hour < 10 ? "0" : "")\(hour):\(minute < 10 ? "0" : "")\(minute):00"
    }

    @inlinable
    public func adding(_ interval: Double) -> StaticTime {
        var copy = self
        let _ = copy.add(interval)
        return copy
    }

    @inlinable
    public func subtracting(_ interval: Double) -> StaticTime {
        var copy = self
        let _ = copy.subtract(interval)
        return copy
    }

    @discardableResult
    @inlinable
    public mutating func add(_ interval: Double) -> Int {
        var (days, hours, minutes, _) = interval.values
        hour += Int32(exactly: hours)!
        minute += Int32(exactly: minutes)!
        while minute >= 60 {
            minute -= 60
            hour += 1
        }
        while hour >= 24 {
            hour -= 24
            days += 1
        }
        return days
    }

    @discardableResult
    @inlinable
    public mutating func subtract(_ interval: Double) -> Int {
        var (days, hours, minutes, _) = interval.values
        days = 0
        let minutes_to_hours:Int = minutes / 60
        minutes -= minutes_to_hours * 60
        hours += minutes_to_hours
        
        hour -= Int32(exactly: hours)!
        minute -= Int32(exactly: minutes)!
        while hour < 0 {
            days += 1
            hour += 24
        }
        while minute < 0 {
            minute += 60
            hour -= 1
        }
        return days
    }

    @inlinable
    public func distance(to time: StaticTime) -> StaticTime {
        return StaticTime(hour: time.hour - hour, minute: time.minute - minute)
    }
}

@inlinable
public func abs(_ time: StaticTime) -> StaticTime {
    return StaticTime(hour: time.hour > 0 ? time.hour : -time.hour, minute: time.minute > 0 ? time.minute : -time.minute)
}