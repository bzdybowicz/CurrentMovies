//
//  MoviesUIFactory.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

protocol MoviesUIFactoryProtocol {
    func manufacture() -> (viewModel: MovieListViewModelProtocol, viewController: UIViewController)
}

struct MoviesUIFactory: MoviesUIFactoryProtocol {
    func manufacture() -> (viewModel: MovieListViewModelProtocol, viewController: UIViewController) {
        let viewModel = MovieListViewModel()
        let vc = MoviesListViewController(viewModel: viewModel)
        return (viewModel, vc)
    }
}
