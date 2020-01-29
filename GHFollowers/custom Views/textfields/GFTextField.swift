//
//  GFTextField.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/6/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

class GFTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure();
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false;
        layer.cornerRadius = 10;
        layer.borderWidth = 2;
        layer.borderColor = UIColor.systemGray4.cgColor;
        textColor = .label;
        tintColor = .label;
        textAlignment = .center;
        font = UIFont.preferredFont(forTextStyle: .title2)
        
        // shrink font to fit width, but only down to min font size
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12;
        
        backgroundColor = .tertiarySystemBackground;
        autocorrectionType = .no
        
        keyboardType = .default
        returnKeyType = .go
    }

}
