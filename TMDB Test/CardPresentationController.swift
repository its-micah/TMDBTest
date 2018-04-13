//
//  CardPresentationController.swift
//  TMDB Test
//
//  Created by Micah Lanier on 4/13/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit

final class CardPresentationController: UIPresentationController {
    var touchForwardingView: PSPDFTouchForwardingView!
    var dimView: UIView = UIView()
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController!) {
        super.init(presentedViewController:presentedViewController, presenting:presentingViewController)
        dimView.backgroundColor = UIColor(white:0.0, alpha:0.66)
        
    }
    
    func frameOfPresentatedViewInContainerView() -> CGRect {
        return CGRect(x: 0, y: 40, width: (containerView?.bounds.width)!, height: containerView!.bounds.height / 2.1)
        
    }
    
    override func containerViewWillLayoutSubviews() {
        dimView.frame = (containerView?.bounds)!
        presentedView?.frame = frameOfPresentatedViewInContainerView()
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        dimView.frame = (self.containerView?.bounds)!
        dimView.alpha = 0.0
        containerView?.insertSubview(dimView, at:0)
        let coordinator = presentedViewController.transitionCoordinator
        if (coordinator != nil) {
            coordinator?.animate(alongsideTransition: { (context) in
                self.dimView.alpha = 1
            }, completion: nil)
        } else {
            dimView.alpha = 1.0
        }
        touchForwardingView = PSPDFTouchForwardingView(frame: containerView!.bounds)
        touchForwardingView.passthroughViews = [presentingViewController.view]
        containerView?.insertSubview(touchForwardingView, at: 0)
    }
    
}
