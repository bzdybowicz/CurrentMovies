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
    @MainActor
    func manufacture() -> (viewModel: MovieListViewModelProtocol, viewController: UIViewController) {
        let viewModel = MovieListViewModel(moviesService: MoviesService(urlSession: URLSession.shared,
                                                                        apiKeyStorage: ApiKeyStorage(),
                                                                        decoder: JSONDecoder()))
        let vc = MoviesListViewController(viewModel: viewModel)
        return (viewModel, vc)
    }
}
