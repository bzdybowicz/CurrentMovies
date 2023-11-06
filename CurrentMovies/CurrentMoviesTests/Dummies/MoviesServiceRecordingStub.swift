//
//  MoviesServiceRecordingStub.swift
//  CurrentMoviesTests
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation
@testable import CurrentMovies

final class MoviesServiceRecordingStub: MoviesServiceProtocol {

    private let moviesResponse: MoviesResponse?

    init(moviesResponse: MoviesResponse? = nil) {
        self.moviesResponse = moviesResponse
    }

    func fetchCurrentMovies() async throws -> MoviesResponse {
        guard let moviesResponse else {
            throw TestError.sample
        }
        return moviesResponse
    }

}
