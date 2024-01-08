//
//  Specimen.swift
//  Retsu
//
//  Created by Joe Charlier on 11/6/23.
//

import Acheron
import Foundation

class Specimen: Anchor {
    @objc dynamic var eras: [Era] = []
    
    var currentEra: Era { eras.last! }
    
    func add(era: Era) {
        eras.append(era)
        add(era)
    }
    
// Domain ==========================================================================================
    override var properties: [String] { super.properties + [] }
    override var children: [String] { super.children + ["eras"] }
    override func onCreate() {
        let era: Era = Era()
        add(era: era)
    }
}
