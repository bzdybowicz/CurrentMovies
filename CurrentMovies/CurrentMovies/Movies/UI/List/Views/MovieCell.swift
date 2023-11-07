//
//  MovieCell.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

final class MovieCell: UITableViewCell {

    private let label = UILabel()
    private let favouriteButton = UIButton()

    private var item: MovieItemViewModel?
    private weak var viewModel: MovieListViewModelProtocol?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: Self.reusableIdentifier)
        setup()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        item = nil
        viewModel = nil
    }

    func update(item: MovieItemViewModel, viewModel: MovieListViewModelProtocol) {
        self.item = item
        self.viewModel = viewModel
        label.text = item.title
        favouriteButton.setImage(item.image, for: .normal)
        favouriteButton.addTarget(self, action: #selector(favouriteAction), for: .touchUpInside)
    }

    @objc func favouriteAction() {
        guard let item = item else { return }
        viewModel?.setFavourite(id: item.id, newValue: !item.isFavourite)
    }
}

private extension MovieCell {

    static let xOffset: CGFloat = 20
    static let yOffset: CGFloat = 8

    func setup() {
        setupLabel()
        setupFavouriteButton()
    }

    func setupLabel() {
        contentView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: MovieCell.xOffset),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MovieCell.yOffset),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -MovieCell.yOffset),
        ])
    }

    func setupFavouriteButton() {
        contentView.addSubview(favouriteButton)
        favouriteButton.translatesAutoresizingMaskIntoConstraints = false
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        NSLayoutConstraint.activate([
            favouriteButton.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: MovieCell.xOffset),
            favouriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -MovieCell.xOffset),
            favouriteButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: MovieCell.yOffset),
            favouriteButton.widthAnchor.constraint(equalToConstant: 22),
            favouriteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -MovieCell.yOffset),
        ])
    }
}
