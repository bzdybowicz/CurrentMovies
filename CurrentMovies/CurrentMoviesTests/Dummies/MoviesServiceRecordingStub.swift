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
    private let searchResponse: MoviesResponse?
    private let configurationResponse: ConfigurationResponse?

    init(moviesResponse: MoviesResponse? = nil,
         searchResponse: MoviesResponse? = nil,
         configurationResponse: ConfigurationResponse? = nil) {
        self.moviesResponse = moviesResponse
        self.searchResponse = searchResponse
        self.configurationResponse = configurationResponse
    }

    func fetchConfiguration() async throws -> ConfigurationResponse {
        guard let configurationResponse else {
            throw TestError.sample
        }
        return configurationResponse
    }

    func searchMovies(query: String) async throws -> MoviesResponse {
        guard let searchResponse else {
            throw TestError.sample
        }
        return searchResponse
    }

    func fetchCurrentMovies(page: Int32) async throws -> MoviesResponse {
        guard let moviesResponse else {
            throw TestError.sample
        }
        return moviesResponse
    }

}
