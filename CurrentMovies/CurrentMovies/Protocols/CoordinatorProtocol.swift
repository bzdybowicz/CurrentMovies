//
//  CoordinatorProtocol.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

protocol RootCoordinatorProtocol: CoordinatorProtocol {
    var window: UIWindow { get }
}

protocol CoordinatorProtocol {
    @MainActor
    func start()
}
