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

    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        setupSearchBar()
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
        searchBar.showsCancelButton = true
        navigationItem.titleView = searchBar
    }
}

extension MoviesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText(searchText)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchCancelAction()
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}
