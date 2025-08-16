
extension FixedWidthInteger {
    /// - Returns: Whether or not this fixed width integer, as a year, is a leap year in the gregorian calendar.
    @inlinable
    public var isLeapYear: Bool {
        guard self % 4 == 0 else { return false }
        if self % 100 != 0 {
            return true
        } else if self % 400 == 0 {
            return true
        } else {
            return false
        }
    }

    @inlinable
    public func daysInMonth(year: some FixedWidthInteger) -> Int {
        switch self {
        case 1, 3, 5, 7, 8, 10, 12:
            return 31
        case 2:
            return year.isLeapYear ? 29 : 28
        case 4, 6, 9, 11:
            return 30
        default:
            return 0
        }
    }
}

// MARK: DayOfWeek
extension UInt8 {
    public static let sunday:Self = 0
    public static let monday:Self = 1
    public static let tuesday:Self = 2
    public static let wednesday:Self = 3
    public static let thursday:Self = 4
    public static let friday:Self = 5
    public static let saturday:Self = 6
}
extension UInt8 {
    /// - Parameters:
    ///   - to: The day of week you want the distance to.
    ///   - forward: Whether to look into the future or past for the given day of week.
    /// - Returns: Distance to the nearest given day of week.
    @inlinable
    public func dowDistance(to: UInt8, forward: Bool = true) -> Int {
        guard self != to else { return 7 }
        if self < to {
            return self.distance(to: to)
        } else {
            return 7 - to.distance(to: self)
        }
    }

    /// Day of week immediately after this one.
    @inlinable
    public var next: UInt8 {
        switch self {
        case .sunday:    .monday
        case .monday:    .tuesday
        case .tuesday:   .wednesday
        case .wednesday: .thursday
        case .thursday:  .friday
        case .friday:    .saturday
        case .saturday:  .sunday
        default:         .sunday
        }
    }

    /// - Returns: The day of week after adding the number of days.
    @inlinable
    public func add(_ days: some FixedWidthInteger) -> UInt8 {
        return UInt8((Int(self) + Int(days)) % 7)
    }
}