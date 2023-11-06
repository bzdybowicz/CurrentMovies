//
//  UITableViewCell+ReusableIdentifier.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

extension UITableViewCell {
    static var reusableIdentifier: String {
        String(describing: Self.self)
    }
}
