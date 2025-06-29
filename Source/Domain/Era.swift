//
//  Era.swift
//  Retsu
//
//  Created by Joe Charlier on 11/6/23.
//

import Acheron
import Foundation

class Era: Domain {
    @objc dynamic var name: String = ""
    @objc dynamic var target: Int = 60
    @objc dynamic var upAmount: Int = 2
    @objc dynamic var downAmount: Int = 5
    @objc dynamic var active: Bool = true
    @objc dynamic var headingUp: Bool = true
    @objc dynamic var firstDay: Day = .today
    @objc dynamic var nextDay: Day = .today
    @objc dynamic var nextAmount: Int = 1
    @objc dynamic var highestAmount: Int = 0
    @objc dynamic var currentStreak: Int = 0
    @objc dynamic var highestStreak: Int = 0

    @objc dynamic var trials: [Trial] = []
    
    var isCaughtUp: Bool { nextDay > .today }
    var daysBehind: Int { Day.tomorrow-nextDay }
    
    func add(trial: Trial) {
        trials.append(trial)
        add(trial)
    }
    
    func recordTrial(result: Trial.Result) {
        if trials.count == 0 {
            firstDay = .today
            nextDay = .today
            nextAmount = 1
            headingUp = false
        }
        
        let trial: Trial = Trial()
        trial.day = nextDay
        trial.amount = nextAmount
        trial.recorded = .now
        trial.result = result
        trial.onTime = (nextDay == Day.today)
        add(trial: trial)
        
        if headingUp {
            if result == .failure || (nextDay < .today && nextAmount > target) { headingUp = false }
        } else {
            if nextAmount == 1 { headingUp = true }
        }
        
        if trial.onTime { currentStreak += 1 }
        else { currentStreak = 0 }
        
        if currentStreak > highestStreak { highestStreak = currentStreak }
        
        nextDay = nextDay.dayAfter
        
        if result == .success && nextAmount > highestAmount { highestAmount = nextAmount }
        
        if headingUp {
            if nextAmount < highestAmount { nextAmount += upAmount }
            else { nextAmount += 1 }
        } else {
            nextAmount = 1 + ((nextAmount / downAmount) - 1) * downAmount
        }
    }
    func report() {
        print("era name: \(name)")
        print("started: \(firstDay)")
        print("target: \(target)")
        print("next: \(nextAmount)")
        print("is caught up: \(isCaughtUp)")
        print("trials to go: \(Day.tomorrow-nextDay)")
        print("highest: \(highestAmount)")
        print("current streak: \(currentStreak)")
        print("highest streak: \(highestStreak)")
        print("")
    }
    
// Domain ==========================================================================================
    override var properties: [String] { super.properties + ["name", "target", "upAmount", "downAmount", "active", "headingUp", "firstDay", "nextDay", "nextAmount", "highestAmount", "currentStreak", "highestStreak"] }
    override var children: [String] { super.children + ["trials"] }
}
