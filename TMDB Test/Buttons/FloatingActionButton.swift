//
//  FloatingActionButton.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/22/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit

public enum FABButtonState {
    case Normal
    case Collapsed
}

class FloatingActionButton: UIButton {
    
    private var normalTitle:String? = "+"
    private var extendedTitle: String = "Done"
    private var buttonState = FABButtonState.Normal
    private var ratioConstraint: NSLayoutConstraint?
    var highConstraintPriority: Float = 800
    var lowConstraintPriority: Float = 200

    
    //MARK: - Initializers
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
//        self.createRatioContraint()
        self.style()
    }
    override public init(frame: CGRect) {
        super.init(frame: frame)
//        self.createRatioContraint()
    }
    
    public init() {
        super.init(frame:CGRect.zero)
        self.style()
//        self.createRatioContraint()
    }
    
    func style() {
        self.layer.backgroundColor = UIColor(hex: "DE4327").cgColor
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 4, height: 4)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.5
    }
 
    
    func hide() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveLinear, animations: {
            self.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        }, completion: { _ in
                self.isHidden = true
        })
    }
    
    func show() {
        self.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    func animate(completion: (() -> Void)?) {
            switch self.buttonState {
            case .Normal:
                self.hide()
            case .Collapsed:
                self.show()
            }
            self.layoutIfNeeded()
            completion?()
    }
    
    public func switchState() {
        animate {
            switch self.buttonState {
            case .Normal:
                self.buttonState = .Collapsed
                print("This button is Collapsed")
            case .Collapsed:
                self.buttonState = .Normal
                print("This button is Normal")
            }
        }
    }
    
}
