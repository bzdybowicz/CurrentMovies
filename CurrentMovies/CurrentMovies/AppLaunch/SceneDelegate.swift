//
//  SceneDelegate.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private var mainCoordinator: CoordinatorProtocol?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        setup(window: window)
    }

    private func setup(window: UIWindow) {
        self.window = window
        window.makeKeyAndVisible()

        mainCoordinator = MoviesCoordinator()
        mainCoordinator?.start()
    }
}

