//
//  RetsuButton.swift
//  Retsu
//
//  Created by Joe Charlier on 1/9/24.
//

import Acheron
import UIKit

class RetsuButton: UIControl {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "FirePunch")!)
    
    init() {
        super.init(frame: .zero)
        
        imageView.alpha = 0.2
        addSubview(imageView)
        
        addAction(for: .touchDown) {
            UIView.animate(withDuration: 0.4) { self.imageView.alpha = 1 }
        }
        addAction(for: [.touchUpInside, .touchUpOutside]) {
            UIView.animate(withDuration: 0.4) { self.imageView.alpha = 0.2 }
        }
//        addAction {
//            Retsu.specimen.currentEra.report()
//            Loom.basket.printDocuments()
//            Loom.transact {
//                Retsu.era.currentStreak = 3
//                Retsu.era.highestStreak = 3
//                Retsu.era.trials.forEach {
//                    $0.onTime = true
//                }
//            }
//        }
    }
    required init?(coder: NSCoder) { fatalError() }
    
// UIView ==========================================================================================
    override func layoutSubviews() {
        imageView.frame = bounds
    }
}
