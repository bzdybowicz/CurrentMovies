//
//  MovieCell.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

final class MovieCell: UITableViewCell {

    init() {
        super.init(style: .default, reuseIdentifier: Self.reusableIdentifier)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(item: MovieItemViewModel) {
        
    }
}
