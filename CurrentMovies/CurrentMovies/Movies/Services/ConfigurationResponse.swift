//
//  ConfigurationResponse.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

struct ConfigurationResponse: Codable {
    let image: ConfigurationImagesResponse
    let changeKeys: [String]

    enum CodingKeys: String, CodingKey {
        case image = "images"
        case changeKeys = "change_keys"
    }
}

struct ConfigurationImagesResponse: Codable {
    let baseUrl: String?
    let secureBaseUrl: String?
    let backDropSizes: [String]?
    let logoSizes: [String]?
    let posterSizes: [String]?
    let profileSizes: [String]?
    let stillSizes: [String]?

    enum CodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backDropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
}
