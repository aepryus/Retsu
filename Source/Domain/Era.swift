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
    @objc dynamic var goal: Int = 60
    @objc dynamic var upAmount: Int = 2
    @objc dynamic var downAmount: Int = 5
    @objc dynamic var active: Bool = true
    @objc dynamic var headingUp: Bool = true
    @objc dynamic var firstDay: Day = .today
    @objc dynamic var nextTrialDay: Day = .today
    @objc dynamic var nextTrialAmount: Int = 1
    @objc dynamic var highestAmount: Int = 100

    @objc dynamic var trials: [Trial] = []
    
    var isCaughtUp: Bool { nextTrialDay > .today }
    
    func add(trial: Trial) {
        trials.append(trial)
        add(trial)
    }
    
    func recordTrial(result: Trial.Result) {
        if trials.count == 0 {
            firstDay = .today
            nextTrialDay = .today
            nextTrialAmount = 1
            headingUp = false
        }
        
        let trial: Trial = Trial()
        trial.day = nextTrialDay
        trial.amount = nextTrialAmount
        trial.recorded = .now
        trial.result = result
        add(trial: trial)
        
        if headingUp {
            if result == .failure || (nextTrialDay < .today && nextTrialAmount > goal) { headingUp = false }
        } else {
            if nextTrialAmount == 1 { headingUp = true }
        }
        
        nextTrialDay = nextTrialDay.dayAfter
        
        if result == .success && nextTrialAmount > highestAmount { highestAmount = nextTrialAmount }
        
        if headingUp {
            if nextTrialAmount < highestAmount { nextTrialAmount += upAmount }
            else { nextTrialAmount += 1 }
        } else {
            nextTrialAmount = 1 + ((nextTrialAmount / downAmount) - 1) * downAmount
        }
    }
    
// Domain ==========================================================================================
    override var properties: [String] { super.properties + ["name", "goal", "upAmount", "downAmount", "active", "headingUp", "firstDay", "nextTrialDay", "nextTrialAmount", "highestAmount"] }
    override var children: [String] { super.children + ["trials"] }
}
