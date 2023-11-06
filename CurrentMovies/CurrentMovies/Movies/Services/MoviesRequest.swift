//
//  MoviesRequest.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

enum MoviesRequest {
    case nowPlaying
    case configuration

    var path: String {
        switch self {
        case .nowPlaying:
            return "movie/now_playing"
        case .configuration:
            return "configuration"
        }
    }

    func queryItems(apiKey: String) -> [URLQueryItem] {
        switch self {
        case .nowPlaying:
            return [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "page", value: "1"),
                URLQueryItem(name: "api_key", value: apiKey)
            ]
        case .configuration:
            return [
                URLQueryItem(name: "api_key", value: apiKey)
            ]
        }
    }
}
