//
//  SearchResult.swift
//  AppStoreTest
//
//  Created by Charlie Tuna on 2019-04-07.
//  Copyright © 2019 Charlie Tuna. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    let screenshotUrls: [String]
    let artworkUrl100: String
}
