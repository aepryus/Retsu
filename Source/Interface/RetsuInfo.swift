//
//  RetsuInfo.swift
//  Retsu
//
//  Created by Joe Charlier on 1/9/24.
//  Copyright © 2024 Aepryus Software. All rights reserved.
//

import UIKit

class RetsuInfo: UIView {
    let topView: UIImageView = UIImageView(image: UIImage(named: "Flame")!)
    let bottomView: UIImageView = UIImageView(image: UIImage(named: "Flame")!)
    
    init() {
        super.init(frame: .zero)
        
        topView.layer.cornerRadius = 2*s
        topView.layer.masksToBounds = true
        topView.contentMode = .scaleToFill
        addSubview(topView)
        
        bottomView.layer.cornerRadius = 2*s
        bottomView.layer.masksToBounds = true
        bottomView.contentMode = .scaleToFill
        addSubview(bottomView)
    }
    required init?(coder: NSCoder) { fatalError() }
    
// UIView ==========================================================================================
    override func layoutSubviews() {
        topView.top(width: width, height: 4*s)
        bottomView.bottom(width: width, height: 4*s)
    }
}
