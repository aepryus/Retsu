//
//  ViewController.swift
//  Retsu
//
//  Created by Joe Charlier on 11/6/23.
//

import Acheron
import UIKit

class ViewController: UIViewController {
    let amountLabel: UILabel = UILabel()
    let buttonBar: UIView = UIView()
    let successButton: UIControl = UIControl()
    let failureButton: UIControl = UIControl()
    let retsuButton: RetsuButton = RetsuButton()
    let retsuInfo: RetsuInfo = RetsuInfo()
    
    var isCaughtUp: Bool { Retsu.specimen.currentEra.isCaughtUp }
    
    func loadSpecimen() {
        if isCaughtUp {
            amountLabel.text = "烈"
            buttonBar.removeFromSuperview()
        } else {
            amountLabel.text = "\(Retsu.specimen.currentEra.nextAmount)"
            view.addSubview(buttonBar)
        }
    }

// UIViewController ================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red.tone(0.7).shade(0.9)
        
        amountLabel.pen = Pen(font: UIFont(name: "Optima", size: 144*s)!, color: .white, alignment: .center)
        view.addSubview(amountLabel)
        
        successButton.backgroundColor = UIColor(patternImage: UIImage(named: "Flame")!)
        successButton.layer.cornerRadius = 10*s
        buttonBar.addSubview(successButton)
        successButton.addAction {
            Loom.transact { Retsu.specimen.currentEra.recordTrial(result: .success) }
            self.loadSpecimen()
        }

        failureButton.backgroundColor = UIColor(rgb: 0xFF0202)
        failureButton.layer.cornerRadius = 10*s
        buttonBar.addSubview(failureButton)
        failureButton.addAction {
            Loom.transact { Retsu.specimen.currentEra.recordTrial(result: .failure) }
            self.loadSpecimen()
        }
        
        view.addSubview(retsuButton)
        
        retsuButton.addAction(for: .touchDown) {
            UIView.animate(withDuration: 0.4) { self.retsuInfo.alpha = 1 }
        }
        retsuButton.addAction(for: [.touchUpInside, .touchUpOutside]) {
            UIView.animate(withDuration: 0.4) { self.retsuInfo.alpha = 0 }
        }

        retsuInfo.alpha = 0
        view.addSubview(retsuInfo)
        
        loadSpecimen()
    }
    override func viewDidLayoutSubviews() {
        amountLabel.top(dy: 100*s, size: CGSize(width: 300*s, height: 200*s))
        buttonBar.top(dy: amountLabel.bottom + 8*s, width: 256*s, height:64*s)
        
        successButton.left(width: (256-64-16)*s, height: 64*s)
        failureButton.right(width: 64*s, height: 64*s)
        retsuButton.bottom(dy: -100-Screen.safeBottom, width: 80*s, height: 80*s)
        retsuInfo.top(dy: retsuButton.top-170*s, width: 280*s, height: 140*s)
    }
}
