//
//  CurrentMoviesListViewController.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Combine
import UIKit

final class MoviesListViewController: UIViewController {

    private let searchBar = UISearchBar()
    private let viewModel: MovieListViewModelProtocol

    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupSearchBar()
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = MoviesListView(viewModel: viewModel)
    }
}

private extension MoviesListViewController {

    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.placeholder = viewModel.searchPlaceholder
        searchBar.searchBarStyle = .default
        navigationItem.titleView = searchBar
    }

    func bind() {
        viewModel
            .selectedItem
            .sink(receiveValue: { [weak self] _ in
                self?.searchBar.resignFirstResponder()
            })
            .store(in: &cancellables)
    }
}

extension MoviesListViewController: UISearchBarDelegate {

}
