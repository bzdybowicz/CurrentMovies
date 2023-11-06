//
//  CurrentMoviesListView.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Combine
import UIKit

final class MoviesListView: UIView {

    private let tableView = UITableView()
    private let searchBar = UISearchBar()
    private let viewModel: MovieListViewModelProtocol

    private var cancellables: Set<AnyCancellable> = []

    init(viewModel: MovieListViewModelProtocol) {
        self.viewModel = viewModel
        super.init(frame: .zero)
        setup()
        bind()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension MoviesListView {

    func setup() {
        setupTableView()
    }

    func bind() {
        viewModel
            .itemsPublished
            .sink { [weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    func setupTableView() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reusableIdentifier)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
    }

}

extension MoviesListView: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(index: indexPath.row)
    }

}

extension MoviesListView: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reusableIdentifier)
        (cell as? MovieCell)?.update(item: viewModel.items[indexPath.row])
        return cell ?? UITableViewCell()
    }
}