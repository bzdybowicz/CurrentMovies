//
//  MoviesResponse.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

struct MoviesResponse: Codable, Equatable {
    let page: Int?
    let results: [MovieResponseItem]?
}

struct MovieResponseItem: Codable, Equatable {
    let backdropPath: String?
    let title: String?
    let releaseDate: String?
    let vote: Double?
    let overview: String?

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case title = "title"
        case releaseDate = "release_date"
        case vote = "vote_average"
        case overview = "overview"
    }
}
