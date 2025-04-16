//
//  StaticDate.swift
//
//
//  Created by Evan Anderson on 12/11/23.
//

import Foundation

/// An exact year, month and day.
public struct StaticDate : Codable, Hashable, Sendable {
    // TODO: Move var today to Compatability File
    //public static var today : StaticDate { StaticDate(SwiftLeagueSchedulingUtilities.now) }
    
    public var year:Int32, month:UInt8, day:UInt8
    
    @inlinable
    public init(year: Int32, month: UInt8, day: UInt8) {
        self.year = year
        self.month = month
        self.day = day
    }

    @inlinable
    public init(_ date: Date) {
        let components:DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        year = components.year!
        month = components.month!
        day = components.day!
    }

    @inlinable
    public init?(htmlDate: String) {
        let values:[Substring] = htmlDate.split(separator: "-")
        guard values.count == 3, let year = Int(values[0]), let month = Int(values[1]), let day = Int(values[2]) else { return nil }
        self.year = year
        self.month = month
        self.day = day
    }

    @inlinable
    public init?(eventDate: String) {
        let values:[Substring] = eventDate.split(separator: "/")
        guard values.count == 3, let year = Int(values[2]), let month = Int(values[0]), let day = Int(values[1]) else { return nil }
        self.year = year
        self.month = month
        self.day = day
    }

    @inlinable
    public var dayOfWeek : UInt8 {
        let index = year % 400
        guard index != 0 else { return UInt8.saturday }
        let previousLeapYears:Int = ((year - index)..<year).reduce(0, { $0 + ($1.isLeapYear ? 1 : 0) })
        let previousMonthDaysForYear:Int = (0...month-1).reduce(0, { $0 + $1.daysInMonth(year: year) })
        return UInt8.saturday.add(previousMonthDaysForYear + (day - 1) + ((index - previousLeapYears) * 365) + (previousLeapYears * 366))
    }

    @inlineable
    public static func isLeapYear(year: Self.year.Type? = nil) -> Bool {
        let year = year ?? self.year
        return (year % 400 != 0) && (year % 100 == 0) ? false : year % 4
    }

    // Comment: This seems like it should be moved to StaticDateTime
    @inlinable
    public static func date(time: StaticTime) -> Date {
        return DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: year, month: month, day: day, hour: Int(time.hour), minute: Int(time.minute)).date!
    }

    @inlinable
    public func daysInMonth(month: UInt8, leapYear leap: Bool = false) -> UInt8 {
        guard month in 1...12 else {
            // TODO: Add warning log "the value of `month` should be inside the range: `1...12`" or throw a OoB error
            return 30
        }
        switch month {
        case 2: return leap ? 29 : 28
        case 1, 3, 5, 7, 8, 10, 12: return 31
        default: return 30
        }
    }
}

extension StaticDate: CustomStringConvertable {
    @inlinable
    public var description : String {
        #if UseDateFormatter
        let date:Date = date(time: StaticTime(hour: 0, minute: 0))
        return DateFormatter.localizedString(from: date, dateStyle: .medium, timeStyle: .none)
        #else
        return self.dateString
        #endif
    }

    @inlinable
    public var dateString : String {
        return "\(year)-" + (month < 10 ? "0" : "") + "\(month)-" + (day < 10 ? "0" : "") + "\(day)"
    }
}

extension StaticDate: Comparable {
    @inlinable
    public static func < (left: Self, right: Self) -> Bool {
        guard left.year == right.year else { return left.year < right.year }
        guard left.month == right.month else { return left.month < right.month }
        return left.day < right.day
    }
}

extension Date {
    /// Creates a Date at the start of the day using StaticDate. 
    init(_ staticDate:StaticDate) {
        self = DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: staticDate.year, month: staticDate.month, day: staticDate.day, hour: 0, minute: 0).date!
    }
}
