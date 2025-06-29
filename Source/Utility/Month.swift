//
//  Month.swift
//  Retsu
//
//  Created by Joe Charlier on 1/19/24.
//  Copyright © 2024 Aepryus Software. All rights reserved.
//

import Foundation

extension Calendar {
    func monthsBetween(_ from: Date, _ to: Date) -> Int { dateComponents([.month], from: startOfDay(for: from), to: startOfDay(for: to)).day! }
}

class Month: NSObject {
    private let n: Int
    private let date: Date
    private let days: [Day]
    
    private convenience init(date: Date) {
        self.init(n: Calendar.current.monthsBetween(Day.startDate, date))
    }
    private init(n: Int) {
        self.n = n
        date = Calendar.current.date(byAdding: .month, value: n, to: Month.startDate)!
        
        let n: Int = Calendar.current.range(of: .day, in: .month, for: date)!.count
        var day: Day = Day.day(date: date)
        var days: [Day] = []
        for _ in 1...n {
            days.append(day)
            day = day.dayAfter
        }
        self.days = days
    }
    
// NSObject ========================================================================================
    override var description: String { date.format("MMM yyyy") }

// Static ==========================================================================================
//    static func - (a: Day, b: Day) -> Int { a.n - b.n }
//    static func == (a: Day, b: Day) -> Bool { a.n == b.n }
//    static func < (a: Day, b: Day) -> Bool { a.n < b.n }
//    static func > (a: Day, b: Day) -> Bool { a.n > b.n }

    static let startDate: Date = Calendar.current.date(from: DateComponents(year: 1970, month: 10, day: 1))!
    static var months: [Int:Month] = [:]
    
    static func test() {
//        let birth: Date = .now
//        let birhtday: Day = Day(date: birth)
//        print("Day is [\(birhtday.n)]")
        
        let month: Month = Month(n: 1)
        print("month:\(month)")
    }
    
    static func month(n: Int) -> Month {
        var month: Month? = months[n]
        if let month { return month }
        month = Month(n: n)
        months[n] = month
        return month!
    }
//    static func month(date: Date) -> Month { month(n: Calendar.current.monthsBetween(Day.startDate, date)) }
//    static var yesterday: Day { today.dayBefore }
//    static var today: Day { day(date: .now) }
//    static var tomorrow: Day { today.dayAfter }
}
