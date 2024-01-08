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
    
    func loadSpecimen() {
        amountLabel.text = "\(Retsu.specimen.currentEra.nextTrialAmount)"
        if Retsu.specimen.currentEra.isCaughtUp { buttonBar.removeFromSuperview() }
        else { view.addSubview(buttonBar) }
    }

// UIViewController ================================================================================
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red.tone(0.7).shade(0.9)
        
        amountLabel.pen = Pen(font: UIFont(name: "Optima", size: 144*s)!, color: .white, alignment: .center)
        view.addSubview(amountLabel)
        
        successButton.backgroundColor = .orange.tone(0.4).shade(0.4)
        successButton.layer.cornerRadius = 10*s
        buttonBar.addSubview(successButton)
        successButton.addAction {
            Loom.transact { Retsu.specimen.currentEra.recordTrial(result: .success) }
            self.loadSpecimen()
        }

        failureButton.backgroundColor = .red.tone(0.4).shade(0.4)
        failureButton.layer.cornerRadius = 10*s
        buttonBar.addSubview(failureButton)
        failureButton.addAction {
            Loom.transact { Retsu.specimen.currentEra.recordTrial(result: .failure) }
            self.loadSpecimen()
        }
        
        loadSpecimen()
    }
    override func viewDidLayoutSubviews() {
        amountLabel.top(dy: 100*s, size: CGSize(width: 300*s, height: 256*s))
        buttonBar.top(dy: amountLabel.bottom + 30*s, width: 256*s, height:64*s)
        
        successButton.left(width: (256-64-16)*s, height: 64*s)
        failureButton.right(width: 64*s, height: 64*s)
    }
}
