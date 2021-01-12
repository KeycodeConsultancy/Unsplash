//
//  Result.swift
//  Splash
//
//  Created by Kevin Reid on 07/01/2021.
//

import Foundation
import SwiftUI

struct Results: Codable {
    var total: Int
    var total_pages: Int
    var results: [Result]
}

struct Result : Codable {
    var id: String
    var description : String?
    var urls: URLs
    var user: User
    var likes: Int
}

struct URLs : Codable {
    var small : String
}

struct User: Codable {
    var name: String
    var id: String
}
