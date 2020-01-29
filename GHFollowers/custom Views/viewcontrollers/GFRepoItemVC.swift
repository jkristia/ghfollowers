//
//  GFRepoItemVC.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/25/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import UIKit

class GFRepoItemVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    override func actionButtonTapped() {
        if let delegate = self.delegate {
            delegate.didTapGithubProfile(for: user)
        }
    }
}
