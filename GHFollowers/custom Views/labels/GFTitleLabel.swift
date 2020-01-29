//
//  GFTitleLabel.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/7/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

class GFTitleLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(textAlignment: NSTextAlignment, fontsize: CGFloat) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment;
        self.font = UIFont.systemFont(ofSize: fontsize, weight: .bold)
        configure()
    }
    
    private func configure() {
        textColor = UIColor.label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false;
    }
}
