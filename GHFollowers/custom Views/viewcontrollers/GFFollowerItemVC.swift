//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/25/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
    override func actionButtonTapped() {
        if let delegate = self.delegate {
            delegate.didTapGithubFollowers(for: user)
        }
    }
}
