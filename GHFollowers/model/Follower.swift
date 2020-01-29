//
//  Follower.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/8/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

// snake_case is when seperated by underline, e.g. avatar_url in the github response
// https://www.hackingwithswift.com/articles/52/swift-4-1-improves-codable-with-keydecodingstrategy


import Foundation

struct Follower: Codable, Hashable {
    let login: String
    let avatarUrl: String
}
