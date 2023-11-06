//
//  MoviesRequest.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

enum MoviesRequest {
    case nowPlaying

    var path: String {
        "movie/now_playing"
    }
}
