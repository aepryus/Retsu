//
//  RetsuButton.swift
//  Retsu
//
//  Created by Joe Charlier on 1/9/24.
//

import Acheron
import UIKit

class RetsuButton: UIControl {
    let imageView: UIImageView = UIImageView(image: UIImage(named: "AppIcon")!)
    
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
        addAction {
            Retsu.specimen.currentEra.report()
//            Loom.transact {
//                Retsu.era.currentStreak = 2
//                Retsu.era.highestStreak = 2
//                Retsu.era.highestAmount = 3
//            }
        }
    }
    required init?(coder: NSCoder) { fatalError() }
    
// UIView ==========================================================================================
    override func layoutSubviews() {
        imageView.frame = bounds
    }
}
