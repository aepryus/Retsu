//
//  Retsu.swift
//  Retsu
//
//  Created by Joe Charlier on 11/6/23.
//

import Acheron
import UIKit

class Retsu {
    static let window: UIWindow = UIWindow()
    static var specimen: Specimen!
    
    static var era: Era { specimen.currentEra }
    
    static func start() {
        print("[ Retsu ] ======================================================================")

        let basket: Basket = Basket(SQLitePersist("retsu"))
        Loom.start(basket: basket, namespaces: ["Retsu"])
        var specimenIden: String? = Loom.get(key: "specimenIden")
        if specimenIden == nil {
            Loom.transact {
                let specimen: Specimen = Loom.create()
                specimenIden = specimen.iden
            }
            Loom.set(key: "specimenIden", value: specimenIden!)
        }
        Retsu.specimen = Loom.selectBy(iden: specimenIden!)
        
        window.rootViewController = ViewController()
        window.makeKeyAndVisible()
    }
}
