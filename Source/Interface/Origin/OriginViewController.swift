//
//  ViewController.swift
//  Retsu
//
//  Created by Joe Charlier on 11/6/23.
//

import Acheron
import UIKit

class OriginViewController: UIViewController {
    let amountLabel: UILabel = UILabel()
    let buttonBar: UIView = UIView()
    let successButton: UIControl = UIControl()
    let failureButton: UIControl = UIControl()
    let retsuButton: RetsuButton = RetsuButton()
    let retsuInfo: RetsuInfo = RetsuInfo()
    let historyButton: UIControl = UIControl()
    let eraButton: UIControl = UIControl()
    
    var isCaughtUp: Bool { Retsu.specimen.currentEra.isCaughtUp }
    
    func loadSpecimen() {
        if isCaughtUp {
            amountLabel.text = "烈"
            buttonBar.removeFromSuperview()
        } else {
            amountLabel.text = "\(Retsu.specimen.currentEra.nextAmount)"
            view.addSubview(buttonBar)
        }
        retsuInfo.loadData()
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
        
        historyButton.backgroundColor = .blue.shade(0.5)
        view.addSubview(historyButton)
        historyButton.addAction {
            self.present(Retsu.historyViewController, animated: true)
        }
        
        eraButton.backgroundColor = .green.shade(0.5)
        view.addSubview(eraButton)
        eraButton.addAction {
            self.present(Retsu.eraViewController, animated: true)
        }

        loadSpecimen()
    }
    override func viewDidLayoutSubviews() {
        amountLabel.top(dy: 170*s, size: CGSize(width: 300*s, height: 200*s))

        buttonBar.top(dy: amountLabel.bottom + 8*s, width: 256*s, height:64*s)
        successButton.left(width: (256-64-16)*s, height: 64*s)
        failureButton.right(width: 64*s, height: 64*s)
        
        retsuInfo.top(dy: buttonBar.bottom+60*s, width: 280*s, height: 140*s)
        retsuButton.bottomRight(dx: -20*s, dy: -Screen.safeTop-3*s, width: 50*s, height: 50*s)
        
        historyButton.topLeft(dx: 10*s, dy: Screen.safeTop+10*s, width: 30*s, height: 30*s)
        eraButton.topLeft(dx: 10*s, dy: historyButton.bottom+10*s, width: 30*s, height: 30*s)
    }
}
