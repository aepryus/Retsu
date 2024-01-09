//
//  RetsuInfo.swift
//  Retsu
//
//  Created by Joe Charlier on 1/9/24.
//  Copyright © 2024 Aepryus Software. All rights reserved.
//

import UIKit

class RetsuInfo: UIView {
    let innerView: UIView = UIView()
    
    init() {
        super.init(frame: .zero)
        
        backgroundColor = .red.shade(0.76)
        
        layer.cornerRadius = 10*s
//        layer.borderColor = UIColor.red.shade(0.0).cgColor
//        layer.borderWidth = 1*s
//        
//        innerView.layer.cornerRadius = 8*s
//        innerView.layer.borderColor = UIColor.orange.tint(0.3).cgColor
//        innerView.layer.borderWidth = 1*s
        addSubview(innerView)
    }
    required init?(coder: NSCoder) { fatalError() }
    
// UIView ==========================================================================================
    override func layoutSubviews() {
        innerView.center(width: width-6*s, height: height-6*s)
    }
}
