//
//  CurrentMoviesListViewController.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

final class MoviesListViewController: UIViewController {

    private let viewModel: MovieListViewModelProtocol

    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MoviesListView(viewModel: viewModel)
    }
}
