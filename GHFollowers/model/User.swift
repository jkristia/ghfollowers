//
//  User.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/8/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let htmlUrl: String
    let createdAt: String
}
