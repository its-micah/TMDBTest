//
//  FlowLayout.swift
//  TMDB Test
//
//  Created by Micah Lanier on 3/28/18.
//  Copyright © 2018 Micah Lanier. All rights reserved.
//

import UIKit

class FlowLayout: UICollectionViewFlowLayout {
    
    var addedItem: IndexPath?
    
    override func initialLayoutAttributesForAppearingItem(at itemIndexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.initialLayoutAttributesForAppearingItem(at: itemIndexPath),
        let added = addedItem,
        added == itemIndexPath else {
            return nil
        }
        // set new attributes
        attributes.center = CGPoint(x: collectionView!.frame.width - 23.5, y: -24.5)
        attributes.alpha = 1.0
        attributes.transform = CGAffineTransform(scaleX: 0.15, y: 0.15)
        attributes.zIndex = 5
        return attributes
    }

}
