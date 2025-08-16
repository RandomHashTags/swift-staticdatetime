
import Testing

@Suite
struct LeapYears {
    @Test
    func leapYears() {
        #expect(2000.isLeapYear)
        #expect(!2001.isLeapYear)
        #expect(!2002.isLeapYear)
        #expect(!2003.isLeapYear)
        #expect(2004.isLeapYear)
        #expect(!2005.isLeapYear)

        #expect(2020.isLeapYear)
        #expect(!2021.isLeapYear)
        #expect(!2022.isLeapYear)
        #expect(!2023.isLeapYear)
        #expect(2024.isLeapYear)

        #expect(!2100.isLeapYear)
        #expect(!2200.isLeapYear)
        #expect(!2300.isLeapYear)
        #expect(2400.isLeapYear)
    }
}