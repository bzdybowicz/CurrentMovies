//
//  MoviesResponse.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

struct MoviesResponse: Codable {
    let page: Int?
    let results: [MovieResponseItem]?
}

struct MovieResponseItem: Codable {
    let backdropPath: String?
    let title: String?
    let releaseDate: String?
    let vote: Double?
    let overview: String?
}
