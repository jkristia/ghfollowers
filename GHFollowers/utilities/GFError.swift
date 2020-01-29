//
//  ErrorMEssages.swift
//  GHFollowers
//
//  Created by jesper kristiansen on 1/9/20.
//  Copyright © 2020 jesper kristiansen. All rights reserved.
//

import Foundation

enum GFError: String, Error {
    case invalidUrl = "bad url"
    case exceptionThrown = "error2"
    case error1 = "Unable to complete your request, Please check your internet connection"
    case error2 = "Invalid response from the server. Please try again"
    case error3 = "Invalid data received. Please try again"
    case unableToFavorite   = "There was an error favoriting this user. Please try again."
    case alreadyInFavorites = "You've already favorited this user. You must REALLY like them!"
}
