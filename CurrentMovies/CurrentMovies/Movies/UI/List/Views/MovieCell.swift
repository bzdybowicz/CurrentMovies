//
//  MovieCell.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

final class MovieCell: UITableViewCell {

    private let label = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.reusableIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(item: MovieItemViewModel) {
        label.text = item.title
    }
}

private extension MovieCell {

    static let xOffset: CGFloat = 20
    static let yOffset: CGFloat = 8

    func setup() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: MovieCell.xOffset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -MovieCell.xOffset),
            label.topAnchor.constraint(equalTo: topAnchor, constant: MovieCell.yOffset),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -MovieCell.yOffset),
        ])
    }
}
