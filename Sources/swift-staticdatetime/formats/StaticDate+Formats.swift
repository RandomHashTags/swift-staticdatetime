
// MARK: ISO 8601
extension StaticDate {
    @inlinable
    public init?(iso8601: some StringProtocol) {
        let values = iso8601.split(separator: "-")
        guard values.count == 3, let year = Int64(values[0]), let month = Int64(values[1]), let day = Int64(values[2]) else { return nil }
        self.year = year
        self.month = month
        self.day = day
    }

    @inlinable
    public var iso8601: String {
        var s = ""
        s.reserveCapacity(10)
        s += "\(year)-"
        if month < 10 {
            s += "0"
        }
        s += "\(month)-"
        if day < 10 {
            s += "0"
        }
        s += "\(day)"
        return s
    }
}