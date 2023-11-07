//
//  MovieListViewModelTests.swift
//  CurrentMoviesTests
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Combine
@testable import CurrentMovies
import XCTest

@MainActor
final class MovieListViewModelTests: XCTestCase {

    private var cancellables: Set<AnyCancellable> = []

    private lazy var stubbedResponse = MoviesResponse(page: 3, results: [
        MovieResponseItem(id: 1,
                          backdropPath: "Path",
                          title: "Title 1",
                          releaseDate: "23-03-2022",
                          vote: 7.5,
                          overview: "Some short overview"),
        MovieResponseItem(id: 2,
                          backdropPath: "Back drop path",
                          title: "Title 2",
                          releaseDate: "12-02-2022",
                          vote: 4.4,
                          overview: "Another overview")
    ])

    func testInitialDataFetchSuccess() async {
        let serviceStub = MoviesServiceRecordingStub(moviesResponse: stubbedResponse)
        let subject = PassthroughSubject<FavouriteChange, Never>()
        let favouritesStub = FavouritesRecordingStub(changePublisher: subject.eraseToAnyPublisher())
        let sut = MovieListViewModel(moviesService: serviceStub, favouritesStorage: favouritesStub)
        let expectation = expectation(description: "Items published")
        sut
            .itemsPublished
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(sut.items, [
            MovieItemViewModel(id: 1,
                               backdropPath: "Path",
                               title: "Title 1",
                               releaseDate: "23-03-2022",
                               voteString: "7.5",
                               overview: "Some short overview",
                               isFavourite: false),
            MovieItemViewModel(id: 2,
                               backdropPath: "Back drop path",
                               title: "Title 2",
                               releaseDate: "12-02-2022",
                               voteString: "4.4",
                               overview: "Another overview",
                               isFavourite: false)
        ])
    }

    func testGetSetFavourites() async {
        let serviceStub = MoviesServiceRecordingStub(moviesResponse: stubbedResponse)
        let subject = PassthroughSubject<FavouriteChange, Never>()
        let favouritesStub = FavouritesRecordingStub(changePublisher: subject.eraseToAnyPublisher(), favourites: [1])
        let sut = MovieListViewModel(moviesService: serviceStub, favouritesStorage: favouritesStub)
        let expectation = expectation(description: "Items published")
        sut
            .itemsPublished
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(sut.items, [
            MovieItemViewModel(id: 1,
                               backdropPath: "Path",
                               title: "Title 1",
                               releaseDate: "23-03-2022",
                               voteString: "7.5",
                               overview: "Some short overview",
                               isFavourite: true),
            MovieItemViewModel(id: 2,
                               backdropPath: "Back drop path",
                               title: "Title 2",
                               releaseDate: "12-02-2022",
                               voteString: "4.4",
                               overview: "Another overview",
                               isFavourite: false)
        ])
        sut.setFavourite(id: 2, newValue: true)
        sut.setFavourite(id: 1, newValue: false)
        XCTAssertEqual(sut.items, [
            MovieItemViewModel(id: 1,
                               backdropPath: "Path",
                               title: "Title 1",
                               releaseDate: "23-03-2022",
                               voteString: "7.5",
                               overview: "Some short overview",
                               isFavourite: false),
            MovieItemViewModel(id: 2,
                               backdropPath: "Back drop path",
                               title: "Title 2",
                               releaseDate: "12-02-2022",
                               voteString: "4.4",
                               overview: "Another overview",
                               isFavourite: true)
        ])
        XCTAssertEqual(favouritesStub.recordedAdds, [2])
        XCTAssertEqual(favouritesStub.recordedRemoves, [1])
        XCTAssertEqual(favouritesStub.recordedIsFavourite, [])
    }

    func testSelectItem() async {
        let serviceStub = MoviesServiceRecordingStub(moviesResponse: stubbedResponse)
        let subject = PassthroughSubject<FavouriteChange, Never>()
        let favouritesStub = FavouritesRecordingStub(changePublisher: subject.eraseToAnyPublisher(), favourites: [])
        let sut = MovieListViewModel(moviesService: serviceStub, favouritesStorage: favouritesStub)
        var selected: Bool = false
        let expectation = expectation(description: "Items published")
        sut
            .selectedItem
            .sink { _ in
                selected = true
            }
            .store(in: &cancellables)
        sut
            .itemsPublished
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        await fulfillment(of: [expectation], timeout: 1)
        sut.selectItem(index: 0)
        XCTAssertTrue(selected)
    }
}
