//
//  DayView.swift
//  Retsu
//
//  Created by Joe Charlier on 1/14/24.
//  Copyright © 2024 Aepryus Software. All rights reserved.
//

import UIKit

class DayView: UIView {
    let day: Day
    
    init(day: Day) {
        self.day = day
        super.init(frame: .zero)
    }
    required init?(coder: NSCoder) { fatalError() }
}
