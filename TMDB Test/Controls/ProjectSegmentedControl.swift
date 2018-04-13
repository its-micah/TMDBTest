//
//  ProjectSegmentedControl.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/26/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit

fileprivate extension Selector {
    static let buttonTapped =
        #selector(ProjectSegmentedControl.buttonTapped(button:))
}

@IBDesignable
class ProjectSegmentedControl: UIControl {
    var buttons = [UIButton]()
    var selector: UIView!
    var selectedSegmentIndex = 0
    
    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            layer.borderColor = borderColor.cgColor
        }
    }
    
    @IBInspectable
    var commaSeparatedButtonTitles: String = "" {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var textColor: UIColor = .lightGray {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorTextColor: UIColor = .white {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable
    var selectorColor: UIColor = UIColor(red: 140/255, green: 140/255, blue: 140/255, alpha: 1) {
        didSet {
            updateView()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    
    func updateView() {
        buttons.removeAll()
        subviews.forEach { $0.removeFromSuperview() }
        
        let buttonTitles = commaSeparatedButtonTitles.components(separatedBy: ",")
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.setTitleColor(textColor, for: .normal)
            button.addTarget(self, action: .buttonTapped, for: .touchUpInside)
            buttons.append(button)
        }
        
        buttons[0].setTitleColor(selectorTextColor, for: .normal)
        
        let selectorWidth = (frame.width / CGFloat(buttons.count))
        let selectorHeight = frame.height / 2
        selector = UIView(frame: CGRect(x: 0, y: selectorHeight / 2, width: selectorWidth - 5, height: selectorHeight))
        selector.layer.cornerRadius = selectorHeight / 2
        selector.backgroundColor = selectorColor
        addSubview(selector)
        
        let sv = UIStackView(arrangedSubviews: buttons)
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        addSubview(sv)
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        sv.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        sv.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        sv.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        
    }
    
    @objc func buttonTapped(button: UIButton) {
        for (buttonIndex, btn) in buttons.enumerated() {
            button.setTitleColor(textColor, for: .normal)
            
            if btn == button {
                selectedSegmentIndex = buttonIndex
                let selectorStartPosition = frame.width / CGFloat(buttons.count) * CGFloat(buttonIndex)
                UIView.animate(withDuration: 0.2, animations: {
                    self.selector.frame.origin.x = selectorStartPosition
                })
                btn.setTitleColor(selectorTextColor, for: .normal)
            }
        }
        sendActions(for: .valueChanged)
        
    }
 

}
