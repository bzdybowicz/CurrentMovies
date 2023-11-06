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
        MovieResponseItem(backdropPath: "Path",
                          title: "Title 1",
                          releaseDate: "23-03-2022",
                          vote: 7.5,
                          overview: "Some short overview"),
        MovieResponseItem(backdropPath: "Back drop path",
                          title: "Title 2",
                          releaseDate: "12-02-2022",
                          vote: 4.4,
                          overview: "Another overview")
    ])

    func testInitialDataFetchSuccess() async {
        let serviceStub = MoviesServiceRecordingStub(moviesResponse: stubbedResponse)
        let sut = MovieListViewModel(moviesService: serviceStub)
        let expectation = expectation(description: "Items published")
        sut
            .itemsPublished
            .sink { _ in
                expectation.fulfill()
            }
            .store(in: &cancellables)
        await fulfillment(of: [expectation], timeout: 1)
        XCTAssertEqual(sut.items, [
            MovieItemViewModel(backdropPath: "Path",
                               title: "Title 1",
                               releaseDate: "23-03-2022",
                               voteString: "7.5",
                               overview: "Some short overview"),
            MovieItemViewModel(backdropPath: "Back drop path",
                               title: "Title 2",
                               releaseDate: "12-02-2022",
                               voteString: "4.4",
                               overview: "Another overview")
        ])
    }
}
