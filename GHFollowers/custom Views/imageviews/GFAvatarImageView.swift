//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/9/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let placeholderImage = UIImage(named: "avatar-placeholder")! // load from assets
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false;
        layer.cornerRadius = 10;
        clipsToBounds = true;
        image = placeholderImage;
    }
    
    public func setImage(from urlString: String) {
        NetworkManager.intance.downloadImage(from: urlString) { [weak self] (image) in
            guard let self = self else { return }
            if let image = image {
                DispatchQueue.main.async {
                    self.image = image
                }
            }
        }
    }
}
