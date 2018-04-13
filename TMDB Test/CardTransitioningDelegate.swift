//
//  CardTransitioningDelegate.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/13/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit

class CardTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return CardPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardPresentationAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CardDismissalAnimator()
    }
    
}
