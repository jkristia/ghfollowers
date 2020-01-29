//
//  GFButton.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/6/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

class GFButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure();
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero);
        set(backgroundColor: backgroundColor, title: title)
        configure();
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor;
        self.setTitle(title, for: .normal);
    }
    
    private func configure() {
        layer.cornerRadius = 10;
//        titleLabel?.textColor = .white;
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false;
    }
}
