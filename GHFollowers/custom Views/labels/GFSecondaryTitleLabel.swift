//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/7/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(fontsize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontsize, weight: .medium)
        configure()
    }
    
    private func configure() {
        textColor = UIColor.secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false;
    }
}
