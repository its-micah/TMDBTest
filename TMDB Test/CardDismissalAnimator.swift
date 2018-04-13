//
//  CardDismissalAnimator.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/13/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit

class CardDismissalAnimator : NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        
        let animationDuration = transitionDuration(using: transitionContext)
        
        UIView.animate(withDuration: animationDuration, animations: {
            fromViewController.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            fromViewController.view.alpha = 0
        }) { finished in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
