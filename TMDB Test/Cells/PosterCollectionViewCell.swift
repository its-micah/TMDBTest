//
//  PosterCollectionViewCell.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/20/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit
import Shimmer

protocol Deleteable {
    func deleteProject(atCell cell: PosterCollectionViewCell)
}

struct AnimationConstants {
    static let wiggleBounceY = 4.0
    static let wiggleBounceDuration = 0.15
    static let wiggleBounceDurationVariance = 0.025
    static let wiggleRotateAngle = 0.035
    static let wiggleRotateDuration = 0.15
    static let wiggleRotateDurationVariance = 0.025
}

class PosterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    var shimmerView: FBShimmeringView!
    var shakeEnabled: Bool!
    var delegate: Deleteable?
    var isEditing: Bool = false {
        didSet {
            deleteButton.isHidden = !isEditing
            if isEditing {
                self.bringSubview(toFront: deleteButton)
                shake()
            } else {
                stopShake()
            }
        }
    }
    
    func shake() {
        UIView.animate(withDuration: 0.0) {
            self.layer.add(self.rotationAnimation(), forKey: "rotation")
            self.layer.add(self.bounceAnimation(), forKey: "bounce")
            self.transform = CGAffineTransform.identity
            self.shakeEnabled = true
        }
    }

    
    
    func stopShake() {
        let layer = self.layer
        layer.removeAnimation(forKey: "rotation")
        layer.removeAnimation(forKey: "bounce")
        shakeEnabled = false
    }
    
    @IBAction func onDeleteButtonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? PosterCollectionViewCell else {
            return // or fatalError() or whatever
        }
        self.delegate?.deleteProject(atCell: cell)
        
        
    }
    
    func shimmer() {
        shimmerView = FBShimmeringView(frame: self.posterImageView.frame)
        shimmerView.contentView = posterImageView
        self.addSubview(shimmerView)
        shimmerView.shimmeringDirection = .right
        shimmerView.shimmeringAnimationOpacity = 0.7
        shimmerView.shimmeringSpeed = 140
        shimmerView.isShimmering = true
    }
    
    func rotationAnimation() -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        animation.values = [(-AnimationConstants.wiggleRotateAngle), (AnimationConstants.wiggleRotateAngle)]
        animation.autoreverses = true
        animation.duration = randomize(interval: AnimationConstants.wiggleRotateDuration, withVariance: AnimationConstants.wiggleRotateDurationVariance)
        animation.repeatCount = .infinity
        return animation
    }
    
    func bounceAnimation() -> CAAnimation {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        animation.values = [(AnimationConstants.wiggleBounceY), (0.0)]
        animation.autoreverses = true
        animation.duration = randomize(interval: AnimationConstants.wiggleBounceDuration, withVariance: AnimationConstants.wiggleBounceDurationVariance)
        animation.repeatCount = .infinity
        return animation
    }
    
    private func randomize(interval: TimeInterval, withVariance variance: Double) -> Double{
        let random = (Double(arc4random_uniform(1000)) - 500.0) / 500.0
        return interval + variance * random
    }
}
