//
//  ApiKeyUIFactory.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

protocol ApiKeyUIFactoryProtocol {
    func alert(alertKeyStorage: ApiKeyStorageProtocol) -> UIAlertController
}

struct ApiKeyUIFactory: ApiKeyUIFactoryProtocol {
    func alert(alertKeyStorage: ApiKeyStorageProtocol) -> UIAlertController {
        let alert = UIAlertController(title: L10n.ApiKey.Alert.title,
                                      message: L10n.ApiKey.Alert.message,
                                      preferredStyle: .alert)

        alert.addTextField { (textField) in
            textField.placeholder = L10n.ApiKey.Alert.placeholder
        }

        let cancelAction = UIAlertAction(title: L10n.Generic.cancel, style: .cancel, handler: nil)

        let okAction = UIAlertAction(title: L10n.Generic.ok, style: .default) { (_) in
            if let text = alert.textFields?.first?.text {
                print("Entered text: \(text)")
                try? alertKeyStorage.saveApiKey(text)
            }
        }
        alert.addAction(cancelAction)
        alert.addAction(okAction)

        return alert
    }
}
