//
//  StaticDateTime.swift
//
//
//  Created by Evan Anderson on 2/7/24.
//

import Foundation

/// An exact date and time.
public struct StaticDateTime : Codable, Comparable, Hashable, Sendable {
    @inlinable
    public static func < (left: StaticDateTime, right: StaticDateTime) -> Bool {
        guard left.staticDate == right.staticDate else { return left.staticDate < right.staticDate }
        return left.staticTime < right.staticTime
    }
    
    public var staticDate:StaticDate
    public var staticTime:StaticTime
    
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
}

extension StaticDateTime {
    @inlinable
    public var dayOfWeek : UInt8 {
        return staticDate.dayOfWeek
    }

    @inlinable
    public var dateString : String {
        return staticDate.dateString + "T" + staticTime.dateString
    }

    @inlinable
    public func adding(_ interval: TimeInterval) -> StaticDateTime {
        var copy:StaticDateTime = self
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
        staticDate.day += interval.days
        var days_for_month = staticDate.month.daysInMonth(year: staticDate.year)
        while staticDate.day > days_for_month {
            staticDate.month += 1
            staticDate.day -= days_for_month
            if staticDate.month > 12 {
                staticDate.year += 1
                staticDate.month = 1
            }
            days_for_month = staticDate.month.daysInMonth(year: staticDate.year)
        }
    }

    @inlinable
    public func date() -> Date? {
        return DateComponents(calendar: Calendar.current, timeZone: TimeZone.current, year: staticDate.year, month: staticDate.month, day: staticDate.day, hour: Int(staticTime.hour), minute: Int(staticTime.minute)).date
    }
}