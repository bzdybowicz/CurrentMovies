//
//  MovieDetailViewController.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

final class MovieDetailViewController: UIViewController {

    private let viewModel: MovieDetailViewModelProtocol
    private var favouriteButton: UIBarButtonItem?

    init(viewModel: MovieDetailViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupFavouritesButton()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MovieDetailView(viewModel: viewModel)
    }

    @objc func favouriteAction() {
        viewModel.setFavourite(newValue: !viewModel.item.isFavourite)
        favouriteButton?.image = viewModel.item.image
    }
}

private extension MovieDetailViewController {

    func setupFavouritesButton() {
        favouriteButton = UIBarButtonItem(image: viewModel.item.image,
                                          style: .plain,
                                          target: self,
                                          action: #selector(favouriteAction))
        navigationItem.rightBarButtonItem = favouriteButton
    }

}

extension MovieItemViewModel {
    var image: UIImage {
        (isFavourite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")) ?? UIImage()
    }
}
