extension FixedWidthInteger {
    /// - Returns: Whether or not this `Int`, as a year, is a leap year in the gregorian calendar.
    @inlinable
    var isLeapYear : Bool {
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
    func daysInMonth(year: Int) -> Int {
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
    public static let sunday:UInt8 = 0
    public static let monday:UInt8 = 1
    public static let tuesday:UInt8 = 2
    public static let wednesday:UInt8 = 3
    public static let thursday:UInt8 = 4
    public static let friday:UInt8 = 5
    public static let saturday:UInt8 = 6
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
    public var next : UInt8 {
        switch self {
        case .sunday:    return .monday
        case .monday:    return .tuesday
        case .tuesday:   return .wednesday
        case .wednesday: return .thursday
        case .thursday:  return .friday
        case .friday:    return .saturday
        case .saturday:  return .sunday
        default: return .sunday
        }
    }

    /// - Returns: The day of week after adding the number of days.
    @inlinable
    public func add(_ days: Int) -> UInt8 {
        return UInt8((Int(self) + days) % 7)
    }
}