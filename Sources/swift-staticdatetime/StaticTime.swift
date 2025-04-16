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

    /// Provides the full time value
    public var total:Int16 {
        get { ((hour as? Int16 ?? 0) * 60) + (minute as? Int16 ?? 0) }
        set(let val) {
            var hours = (val - ( val % 60 )) / 60
            
            self.minutes = (val / 60) as? Int8 ?? = 0
            self.hours = (hours / 24) as? Int8 ?? = 0
        }
    }
    
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

    public init?(total: Int16) {
        // value is calculated as 24*60
        guard abs(total) <= 1_440 else { return nil }
        self.minute = total % 60
        self.hour = total - minute
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
        var (days, hours, minutes, _):(Int8, Int8, Int8, Int8) = interval.values
        minutes += minutes
        hours += (minutes - ( minutes % 60 )) / 60
        
        hours += hours
        days = (hours - ( hours % 24 )) / 24
        
        self.minutes = minutes % 60
        self.hours = hours % 24
        return days
    }
    
    @discardableResult
    @inlinable
    public mutating func subtract(_ interval: Double) -> Int {
        var (days, hours, minutes, _):(Int8, Int8, Int8, Int8) = interval.values
        
        minutes -= minutes
        hours -= (minutes - ( minutes % 60 )) / 60
        
        hours -= hours
        days = (hours - ( hours % 24 )) / 24
        
        self.minutes = minutes % 60
        self.hours = hours % 24
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
