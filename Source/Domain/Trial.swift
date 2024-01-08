//
//  Trial.swift
//  Retsu
//
//  Created by Joe Charlier on 11/7/23.
//

import Acheron
import Foundation

class Trial: Domain {
    enum Result: CaseIterable { case success, failure }
    
    @objc dynamic var day: Day = .today
    @objc dynamic var amount: Int = 1
    @objc dynamic var recorded: Date? = nil
    @objc dynamic var resultToken: String = "success"
    
    var result: Result {
        set { resultToken = newValue.toString() }
        get { Result.from(string: resultToken)! }
    }
    
// Domain ==========================================================================================
    override var properties: [String] { super.properties + ["day", "amount", "recorded", "resultToken"] }
}
