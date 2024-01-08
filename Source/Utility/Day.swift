//
//  Day.swift
//  Retsu
//
//  Created by Joe Charlier on 11/8/23.
//

import Acheron
import Foundation

extension Calendar {
    func daysBetween(_ from: Date, _ to: Date) -> Int { dateComponents([.day], from: startOfDay(for: from), to: startOfDay(for: to)).day! }
}

@objc class Day: NSObject, Packable {
    private let n: Int
    private let date: Date
    
    private override init() { fatalError() }

    private convenience init(date: Date) {
        self.init(n: Calendar.current.daysBetween(Day.startDate, date))
    }
    private init(n: Int) {
        self.n = n
        date = Calendar.current.date(byAdding: .day, value: n, to: Day.startDate)!
    }
    
    var dayBefore: Day { Day.day(n: n-1) }
    var dayAfter: Day { Day.day(n: n+1) }
        
// Packable ========================================================================================
    required init?(_ text: String) {
        n = Int(text)!
        date = Calendar.current.date(byAdding: .day, value: n, to: Day.startDate)!
    }
    func pack() -> String { "\(n)" }
    
// NSObject ========================================================================================
    override var description: String { date.format("MMM d, yyyy") }

// Static ==========================================================================================
    static func - (a: Day, b: Day) -> Int { a.n - b.n }
    static func < (a: Day, b: Day) -> Bool { a.n < b.n }
    static func > (a: Day, b: Day) -> Bool { a.n > b.n }

    static let startDate: Date = Calendar.current.date(from: DateComponents(year: 1970, month: 11, day: 2))!
    static var days: [Int:Day] = [:]
    
    static func test() {
        let birth: Date = .now
        let birhtday: Day = Day(date: birth)
        print("Day is [\(birhtday.n)]")
    }
    
    static func day(n: Int) -> Day {
        var day: Day? = days[n]
        if let day { return day }
        day = Day(n: n)
        days[n] = day
        return day!
    }
    static func day(date: Date) -> Day { day(n: Calendar.current.daysBetween(Day.startDate, date)) }
    static var yesterday: Day { today.dayBefore }
    static var today: Day { day(date: .now) }
    static var tomorrow: Day { today.dayAfter }
}
