//
//  ClockView.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/23/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit

final class ClockView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public func makeWaves() {
        var i = 1
        let baseDiameter = 25
        var rect = CGRect(x: 0, y: 0, width: baseDiameter, height: baseDiameter)
        // Continue adding waves until the next wave would be outside of our frame
        while self.frame.contains(rect) {
            let waveLayer = buildWave(rect: rect)
            self.layer.addSublayer(waveLayer)
            i += 1
            // Increase size of rect with each new wave layer added
            rect = CGRect(x: 0, y: 0, width: baseDiameter * i, height: baseDiameter * i)
        }
    }
    
    private func buildWave(rect: CGRect) -> CAShapeLayer {
        let circlePath = UIBezierPath(ovalIn: rect)
        let waveLayer = CAShapeLayer()
        waveLayer.bounds = rect
        waveLayer.frame = rect
        waveLayer.position = self.center
        waveLayer.strokeColor = UIColor.black.cgColor
        waveLayer.fillColor = UIColor.clear.cgColor
        waveLayer.lineWidth = 2.0
        waveLayer.path = circlePath.cgPath
        waveLayer.strokeStart = 0
        waveLayer.strokeEnd = 1
        return waveLayer
    }
    
    

}
