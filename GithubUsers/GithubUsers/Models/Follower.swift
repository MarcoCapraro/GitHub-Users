//
//  Follower.swift
//  GithubUsers
//
//  Created by Marco Capraro on 2/15/24.
//

import Foundation

// Need codable for networking
struct Follower: Codable {
    var login: String
    var avatarUrl: String
}
