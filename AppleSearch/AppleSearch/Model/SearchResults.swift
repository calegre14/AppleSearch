//
//  SearchResults.swift
//  AppleSearch
//
//  Created by Christopher Alegre on 10/3/19.
//  Copyright © 2019 Christopher Alegre. All rights reserved.
//

import Foundation


struct MusicTopLevelDictionary: Decodable {
    let results: [MusicSearchResult]
}

struct AppTopLevelDictionary: Decodable {
    let results: [AppSearchResult]
}

struct MusicSearchResult: Decodable {
    let artistName: String
    let trackName: String?
    let artworkUrl100: String?
}

struct AppSearchResult: Decodable {
    let trackName: String
    let description: String
    let artworkUrl100: String?
}
