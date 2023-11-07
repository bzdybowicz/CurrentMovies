//
//  MovieItemViewModel.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

struct MovieItemViewModel: Equatable {
    let id: Int
    let backdropPath: String?
    let title: String
    let releaseDate: String
    let voteString: String
    let overview: String
    private (set)var isFavourite: Bool

    mutating func setFavourite(newValue: Bool) {
        isFavourite = newValue
    }
}
