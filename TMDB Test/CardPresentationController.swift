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
    
    func frameOfPresentatedViewInContainerView() -> CGRect {
        let height: CGFloat = 200
        return CGRect(x: 0, y: 44, width: (containerView?.bounds.width)!, height: containerView!.bounds.height / 2.2)
        
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentatedViewInContainerView()
    }
    
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        touchForwardingView = PSPDFTouchForwardingView(frame: containerView!.bounds)
        touchForwardingView.passthroughViews = [presentingViewController.view]
        containerView?.insertSubview(touchForwardingView, at: 0)
    }
    
}
