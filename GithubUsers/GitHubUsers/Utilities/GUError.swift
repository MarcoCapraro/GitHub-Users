//
//  GUError.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/27/24.
//

import Foundation

// Refactored to conform to the Error protocol and use with Result
enum GUError: String, Error {
    
    // The rawValue is the associated string
    case invalidUsername    = "This username created an invalid request. Please try again"
    case unableToComplete   = "nable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again"
    case invalidData        = "The data received from the server is invalid. Please try again"
    case unableToFavorite   = "There was an error favoriting this user. Please try again"
    case alreadyInFavorites = "Already favorited this user. You must REALLY like them!"
}
