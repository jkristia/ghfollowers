//
//  GFBodyLabel.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/7/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(textAlignment: NSTextAlignment) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment;
        configure()
    }
    
    private func configure() {
        textColor = UIColor.secondaryLabel
        font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.body)
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false;
    }
}
