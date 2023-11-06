//
//  MoviesUIFactory.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

protocol MoviesUIFactoryProtocol {
    @MainActor
    func manufacture() -> (viewModel: MovieListViewModelProtocol, viewController: UIViewController)

    @MainActor
    func manufactureDetail(item: MovieItemViewModel) -> UIViewController
}

struct MoviesUIFactory: MoviesUIFactoryProtocol {

    private var service: MoviesServiceProtocol {
        MoviesService(urlSession: URLSession.shared,
                      apiKeyStorage: ApiKeyStorage(),
                      decoder: JSONDecoder())
    }

    @MainActor
    func manufacture() -> (viewModel: MovieListViewModelProtocol, viewController: UIViewController) {
        let viewModel = MovieListViewModel(moviesService: service)
        let vc = MoviesListViewController(viewModel: viewModel)
        return (viewModel, vc)
    }

    @MainActor
    func manufactureDetail(item: MovieItemViewModel) -> UIViewController {
        let viewModel = MovieDetailViewModel(item: item, moviesService: service,
                                             imageService: ImageService(urlSession: URLSession.shared))
        return MovieDetailViewController(viewModel: viewModel)
    }
}
