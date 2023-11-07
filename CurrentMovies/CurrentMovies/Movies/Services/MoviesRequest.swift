//
//  MoviesRequest.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

enum MoviesRequest {
    case nowPlaying(page: Int32)
    case configuration
    case search(query: String)

    var path: String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        case .configuration:
            return "configuration"
        case .search:
            return "search/movie"
        }
    }

    func queryItems(apiKey: String) -> [URLQueryItem] {
        switch self {
        case .nowPlaying(let page):
            return [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "page", value: String("\(page)"))
            ]
        case .configuration:
            return [
                URLQueryItem(name: "api_key", value: apiKey)
            ]
        case .search(let query):
            return [
                URLQueryItem(name: "api_key", value: apiKey),
                URLQueryItem(name: "query", value: query)
            ]
        }
    }
}
