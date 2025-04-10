//
//  StaticTime.swift
//
//
//  Created by Evan Anderson on 2/7/24.
//

/// An exact hour and minute.
public struct StaticTime : Codable, Comparable, CustomStringConvertible, Hashable, Sendable {
    @inlinable
    public static func < (left: StaticTime, right: StaticTime) -> Bool {
        guard left.hour == right.hour else { return left.hour < right.hour }
        return left.minute < right.minute
    }
    
    public var hour:Int8, minute:Int8
    
    @inlinable
    public init(hour: Int8, minute: Int8) {
        self.hour = hour
        self.minute = minute
    }
    @inlinable
    public init?<T: StringProtocol>(htmlTime: T) {
        let values = htmlTime.split(separator: ":")
        guard values.count == 2, let hour = Int8(values[0]), let minute = Int8(values[1]) else { return nil }
        self.hour = hour
        self.minute = minute
    }
    
    @inlinable
    public var description : String {
        return "\(hour):" + (minute >= 10 ? "\(minute)" : "0\(minute)")
    }

    @inlinable
    public var dateString : String {
        return (hour < 10 ? "0" : "") + "\(hour):" + (minute < 10 ? "0" : "") + "\(minute):00"
    }

    @inlinable
    public func adding(_ interval: Double) -> StaticTime {
        var copy:StaticTime = self
        let _:Int = copy.add(interval)
        return copy
    }

    @inlinable
    public func subtracting(_ interval: Double) -> StaticTime {
        var copy:StaticTime = self
        let _:Int = copy.subtract(interval)
        return copy
    }

    @discardableResult
    @inlinable
    public mutating func add(_ interval: Double) -> Int {
        var (days, hours, minutes, _):(Int, Int, Int, Int) = interval.values
        hour += Int8(exactly: hours)!
        minute += Int8(exactly: minutes)!
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
        var (days, hours, minutes, _):(Int, Int, Int, Int) = interval.values
        days = 0
        let minutes_to_hours:Int = minutes / 60
        minutes -= minutes_to_hours * 60
        hours += minutes_to_hours
        
        hour -= Int8(exactly: hours)!
        minute -= Int8(exactly: minutes)!
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
