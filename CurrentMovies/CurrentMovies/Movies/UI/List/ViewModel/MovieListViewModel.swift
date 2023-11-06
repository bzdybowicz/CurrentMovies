//
//  MovieListViewModel.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Combine

@MainActor
protocol MovieListViewModelProtocol {
    // Output.
    var items: [MovieItemViewModel] { get }
    var itemsPublished: AnyPublisher<Void, Never> { get }
    var selectedItem: AnyPublisher<MovieItemViewModel, Never> { get }

    // Input.
    func refreshList()
    func selectItem(index: Int)
}

@MainActor
final class MovieListViewModel: MovieListViewModelProtocol {
    var itemsPublished: AnyPublisher<Void, Never> { reloadSubject.eraseToAnyPublisher() }
    var selectedItem: AnyPublisher<MovieItemViewModel, Never> { selectedItemSubject.eraseToAnyPublisher() }
    private (set) var items: [MovieItemViewModel] = []

    private let selectedItemSubject = PassthroughSubject<MovieItemViewModel, Never>()
    private let reloadSubject = PassthroughSubject<Void, Never>()
    private let moviesService: MoviesServiceProtocol
    private let emptyPlaceholderString = "-"

    init(moviesService: MoviesServiceProtocol) {
        self.moviesService = moviesService
        fetchList()
    }

    func refreshList() {
        fetchList()
    }

    func selectItem(index: Int) {
        selectedItemSubject.send(items[index])
    }
}

private extension MovieListViewModel {
    func fetchList() {
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let response = try await self.moviesService.fetchCurrentMovies()
                self.handleResponse(response)
            } catch let error {
                self.handleError(error: error)
            }
        }
    }

    func handleResponse(_ response: MoviesResponse) {
        guard let results = response.results else { return }
        let items = results.compactMap {
            var voteString = emptyPlaceholderString
            if let vote = $0.vote {
                voteString = String(format: "%.1f", vote)
            }
            return MovieItemViewModel(backdropPath: $0.backdropPath,
                                      title: $0.title ?? emptyPlaceholderString,
                                      releaseDate: $0.releaseDate ?? emptyPlaceholderString,
                                      voteString: voteString,
                                      overview: $0.overview ?? emptyPlaceholderString)
        }
        self.items = items
        reloadSubject.send(())
    }

    func handleError(error: Error) {
        guard let error = error as? ServiceError else { return }
        print("Service error \(error)")
        // Handle errors. It was not required by reqs.
    }
}
