//
//  MovieListViewModel.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

@MainActor
protocol MovieListViewModelProtocol {
    var items: [MovieItemViewModel] { get }
}

@MainActor
final class MovieListViewModel: MovieListViewModelProtocol {

    private (set) var items: [MovieItemViewModel] = []

    private let moviesService: MoviesServiceProtocol
    private let emptyPlaceholderString = "-"

    init(moviesService: MoviesServiceProtocol) {
        self.moviesService = moviesService
        fetchList()
    }

    private func fetchList() {
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

    private func handleResponse(_ response: MoviesResponse) {
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
    }

    private func handleError(error: Error) {
        guard let error = error as? ServiceError else { return }
        print("Service error \(error)")
        // Handle errors.
    }
}
