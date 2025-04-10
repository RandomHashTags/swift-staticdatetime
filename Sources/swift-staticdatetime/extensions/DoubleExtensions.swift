extension Double {
    @inlinable public static func minutes(_ input: Int) -> Double { minutes(Double(input)) }

    @inlinable public static func hours(_ input: Int) -> Double { hours(Double(input)) }

    @inlinable public static func days(_ input: Int) -> Double { days(Double(input)) }

    @inlinable public static func weeks(_ input: Int) -> Double { weeks(Double(input)) }

    @inlinable public static func months(_ input: Int) -> Double { months(Double(input)) }

    @inlinable public static func years(_ input: Int) -> Double { days(Double(input)) }


    @inlinable public static func minutes(_ input: Double) -> Double { input * 60 }

    @inlinable public static func hours(_ input: Double) -> Double { minutes(input) * 60 }

    @inlinable public static func days(_ input: Double) -> Double { hours(input) * 24 }

    @inlinable public static func weeks(_ input: Double) -> Double { days(input) * 7 }

    @inlinable public static func months(_ input: Double) -> Double { days(30.00) * input }

    /// > Note: Measured in Gregorian Years (365.25 days)
    @inlinable public static func years(_ input: Double) -> Double { days(365.25) * input }

    @inlinable
    public var values : (days: Int, hours: Int, minutes: Int, seconds: Int) {
        var seconds:Int = Int(self)
        var minutes:Int = seconds / 60
        seconds -= minutes * 60

        var hours:Int = minutes / 60
        minutes -= hours * 60

        let days:Int = hours / 24
        hours -= days * 24
        return (days, hours, minutes, seconds)
    }
}