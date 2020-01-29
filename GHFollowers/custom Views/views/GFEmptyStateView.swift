//
//  GFEmptyStateView.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/11/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

class GFEmptyStateView: UIView {
    
    private let messageLabel = GFTitleLabel(textAlignment: .center, fontsize: 28)
    private let logoImageview = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String) {
        super.init(frame: .zero)
        messageLabel.text = message;
        configure()
    }
    
    private func configure() {
        addSubview(messageLabel)
        addSubview(logoImageview)
        
        messageLabel.numberOfLines = 3
        messageLabel.textColor = .secondaryLabel
        
        logoImageview.image = UIImage(named: "empty-state-logo")
        logoImageview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            messageLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            logoImageview.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageview.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageview.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200), // push out by 170
            logoImageview.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 60) // push down by 40
        ])
       
    }
}
