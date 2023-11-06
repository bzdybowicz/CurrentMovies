//
//  CurrentMoviesListView.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

final class MoviesListView: UIView {

    private let viewModel: MovieListViewModelProtocol

    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
