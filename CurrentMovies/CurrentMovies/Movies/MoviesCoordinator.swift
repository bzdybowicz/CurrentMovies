//
//  MoviesCoordinator.swift
//  Movies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Combine
import UIKit

final class MoviesCoordinator: RootCoordinatorProtocol {
    let window: UIWindow

    private let apiStorage: ApiKeyStorageProtocol
    private let uiFactory: MoviesUIFactoryProtocol
    private let apiKeyAlertFactory: ApiKeyUIFactoryProtocol
    private var movieListViewModel: MovieListViewModelProtocol?
    private var navigationController: UINavigationController?

    private var cancellables: Set<AnyCancellable> = []

    init(window: UIWindow,
         apiStorage: ApiKeyStorageProtocol,
         uiFactory: MoviesUIFactoryProtocol,
         apiKeyAlertFactory: ApiKeyUIFactoryProtocol) {
        self.window = window
        self.apiStorage = apiStorage
        self.uiFactory = uiFactory
        self.apiKeyAlertFactory = apiKeyAlertFactory
    }

    @MainActor
    func start() {
        showCurrentMoviesList()
        if apiStorage.getKey() == nil {
            showApiKeyAlert()
        }
    }

    @MainActor
    private func showApiKeyAlert() {
        let alert = apiKeyAlertFactory.alert(alertKeyStorage: apiStorage) { [weak self] in
            self?.movieListViewModel?.refreshList()
        }
        window.rootViewController?.present(alert, animated: true)
    }

    @MainActor
    private func showCurrentMoviesList() {
        let pair = uiFactory.manufacture()
        movieListViewModel = pair.viewModel
        pair
            .viewModel
            .selectedItem
            .sink { [weak self] item in
                self?.showDetail(item)
            }
            .store(in: &cancellables)
        let navigationController = UINavigationController(rootViewController: pair.viewController)
        self.navigationController = navigationController
        window.rootViewController = navigationController
    }

    @MainActor
    private func showDetail(_ item: MovieItemViewModel) {
        let viewController = uiFactory.manufactureDetail(item: item)
        navigationController?.pushViewController(viewController, animated: true)
    }
}
