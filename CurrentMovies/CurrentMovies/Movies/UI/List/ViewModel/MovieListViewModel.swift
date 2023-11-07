//
//  MovieListViewModel.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Combine

@MainActor
protocol MovieListViewModelProtocol: AnyObject {
    // Output.
    var items: [MovieItemViewModel] { get }
    var itemsPublished: AnyPublisher<Void, Never> { get }
    var selectedItem: AnyPublisher<MovieItemViewModel, Never> { get }
    var reloadItem: AnyPublisher<Int, Never> { get }

    // Input.
    func refreshList()
    func selectItem(index: Int)
    func setFavourite(id: Int, newValue: Bool)
}

@MainActor
final class MovieListViewModel: MovieListViewModelProtocol {
    var itemsPublished: AnyPublisher<Void, Never> { reloadSubject.eraseToAnyPublisher() }
    var selectedItem: AnyPublisher<MovieItemViewModel, Never> { selectedItemSubject.eraseToAnyPublisher() }
    var reloadItem: AnyPublisher<Int, Never> { reloadItemSubject.eraseToAnyPublisher() }
    private (set) var items: [MovieItemViewModel] = []

    private let reloadItemSubject = PassthroughSubject<Int, Never>()
    private let favouritesStorage: FavouritesStorageProtocol
    private let selectedItemSubject = PassthroughSubject<MovieItemViewModel, Never>()
    private let reloadSubject = PassthroughSubject<Void, Never>()
    private let moviesService: MoviesServiceProtocol
    private let emptyPlaceholderString = "-"

    private var cancellables: Set<AnyCancellable> = []

    init(moviesService: MoviesServiceProtocol,
         favouritesStorage: FavouritesStorageProtocol) {
        self.moviesService = moviesService
        self.favouritesStorage = favouritesStorage
        fetchList()
        bindFavourites()
    }

    func refreshList() {
        fetchList()
    }

    func selectItem(index: Int) {
        selectedItemSubject.send(items[index])
    }

    func setFavourite(id: Int, newValue: Bool) {
        if let firstIndex = items.firstIndex(where: {
            id == $0.id
        }) {
            if newValue {
                favouritesStorage.add(id: id)
            } else {
                favouritesStorage.remove(id: id)
            }
            items[firstIndex].setFavourite(newValue: newValue)
            reloadItemSubject.send(firstIndex)
        }
    }
}

private extension MovieListViewModel {

    func bindFavourites() {
        favouritesStorage
            .changePublisher
            .sink(receiveValue: { [weak self] change in
                self?.handleChange(change)
            })
            .store(in: &cancellables)
    }

    func handleChange(_ change: FavouriteChange) {
        if let firstIndex = items.firstIndex(where: {
            change.id == $0.id
        }) {
            items[firstIndex].setFavourite(newValue: change.newValue)
            reloadItemSubject.send(firstIndex)
        }
    }

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
        let items = results.compactMap { value -> MovieItemViewModel? in
            var voteString = emptyPlaceholderString
            if let vote = value.vote {
                voteString = String(format: "%.1f", vote)
            }
            guard let id = value.id else { return nil }
            return MovieItemViewModel(id: id,
                                      backdropPath: value.backdropPath,
                                      title: value.title ?? emptyPlaceholderString,
                                      releaseDate: value.releaseDate ?? emptyPlaceholderString,
                                      voteString: voteString,
                                      overview: value.overview ?? emptyPlaceholderString,
                                      isFavourite: favouritesStorage.isFavourite(id: id))
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
