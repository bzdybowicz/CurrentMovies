//
//  MovieDetailViewModel.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

protocol MovieDetailViewModelProtocol {

}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {

    private let item: MovieItemViewModel

    init(item: MovieItemViewModel) {
        self.item = item
    }
}
