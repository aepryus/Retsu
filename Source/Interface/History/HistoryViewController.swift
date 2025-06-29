//
//  HistoryViewController.swift
//  Retsu
//
//  Created by Joe Charlier on 1/14/24.
//  Copyright © 2024 Aepryus Software. All rights reserved.
//

import Acheron
import UIKit

class HistoryViewController: UIViewController {
    let monthView: MonthView = MonthView()
    
// UIViewController ================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue.shade(0.7)
        
        monthView.backgroundColor = .orange.shade(0.7)
        view.addSubview(monthView)
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        monthView.top(dy: Screen.safeTop+40*s, width: view.width-20*s, height: (view.width-20*s)*5/7)
    }
}
