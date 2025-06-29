//
//  RetsuInfo.swift
//  Retsu
//
//  Created by Joe Charlier on 1/9/24.
//  Copyright © 2024 Aepryus Software. All rights reserved.
//

import Acheron
import UIKit

class RetsuInfo: UIView {
    let topView: UIImageView = UIImageView(image: UIImage(named: "Flame")!)
    let bottomView: UIImageView = UIImageView(image: UIImage(named: "Flame")!)
    
    let eraLabel: UILabel = UILabel()
    let paramLabel: UILabel = UILabel()
    let nextLabel: UILabel = UILabel()
    let statusLabel: UILabel = UILabel()
    let recordLabel: UILabel = UILabel()
    
    let pen: Pen = Pen(font: UIFont.avenir(size: 16*Screen.s), color: .white)
    
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
        
        eraLabel.pen = pen
        addSubview(eraLabel)
        
        paramLabel.pen = pen
        addSubview(paramLabel)
        
        nextLabel.pen = pen
        addSubview(nextLabel)

        statusLabel.pen = pen
        addSubview(statusLabel)

        recordLabel.pen = pen
        addSubview(recordLabel)

        loadData()
    }
    required init?(coder: NSCoder) { fatalError() }
    
    var era: Era { Retsu.era }
    
    func loadData() {
        eraLabel.text = "era: \(era.name), started: \(era.firstDay.format("M/d/yy"))"
        paramLabel.text = " target: \(era.target), up by: \(era.upAmount), down by: \(era.downAmount)"
        nextLabel.text = " next: \(era.nextAmount), for: \(era.nextDay.format("M/d/yy"))"
        
        switch era.daysBehind {
            case 0: statusLabel.text = " currently caught up"
            case 1: statusLabel.text = " not done todays yet"
            default: statusLabel.text = " \(era.daysBehind) days behind"
        }
        
        recordLabel.text = " most: \(era.highestAmount), streak: \(era.currentStreak), top: \(era.highestStreak)"
    }
    
//        print("highest: \(highestAmount)")
//        print("current streak: \(currentStreak)")
//        print("highest streak: \(highestStreak)")
    
// UIView ==========================================================================================
    override func layoutSubviews() {
        topView.top(width: width, height: 4*s)
        bottomView.bottom(width: width, height: 4*s)
        
        let lw: CGFloat = 300*s
        let lh: CGFloat = 20*s
        
        eraLabel.topLeft(dx: 16*s, dy: topView.bottom+3*s, width: lw, height: lh)
        paramLabel.topLeft(dx: eraLabel.left, dy: eraLabel.bottom+3*s, width: lw, height: lh)
        nextLabel.topLeft(dx: eraLabel.left, dy: paramLabel.bottom+3*s, width: lw, height: lh)
        statusLabel.topLeft(dx: eraLabel.left, dy: nextLabel.bottom+3*s, width: lw, height: lh)
        recordLabel.topLeft(dx: eraLabel.left, dy: statusLabel.bottom+3*s, width: lw, height: lh)
    }
}
