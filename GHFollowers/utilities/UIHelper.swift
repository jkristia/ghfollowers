//
//  UIHelper.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/10/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayout(view: UIView) -> UICollectionViewFlowLayout {
        let numberOfColumns: CGFloat = 3;
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (2 * padding) - (minimumItemSpacing * CGFloat(numberOfColumns - 1))
        let itemWidth = availableWidth / numberOfColumns
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        return layout
    }
}
