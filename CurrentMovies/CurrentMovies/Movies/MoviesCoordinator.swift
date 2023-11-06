//
//  MoviesCoordinator.swift
//  Movies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

final class MoviesCoordinator: RootCoordinatorProtocol {
    let window: UIWindow

    private let apiStorage: ApiKeyStorageProtocol
    private let uiFactory: MoviesUIFactoryProtocol
    private let apiKeyAlertFactory: ApiKeyUIFactoryProtocol

    init(window: UIWindow,
         apiStorage: ApiKeyStorageProtocol,
         uiFactory: MoviesUIFactoryProtocol,
         apiKeyAlertFactory: ApiKeyUIFactoryProtocol) {
        self.window = window
        self.apiStorage = apiStorage
        self.uiFactory = uiFactory
        self.apiKeyAlertFactory = apiKeyAlertFactory
    }

    func start() {
        showCurrentMoviesList()
        if apiStorage.getKey() == nil {
            showApiKeyAlert()
        }
    }

    private func showApiKeyAlert() {
        let alert = apiKeyAlertFactory.alert(alertKeyStorage: apiStorage)
        window.rootViewController?.present(alert, animated: true)
    }

    private func showCurrentMoviesList() {
        let pair = uiFactory.manufacture()
        window.rootViewController = pair.viewController
    }

}
