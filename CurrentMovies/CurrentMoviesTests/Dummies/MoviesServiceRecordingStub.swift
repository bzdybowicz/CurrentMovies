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
    private let configurationResponse: ConfigurationResponse?

    init(moviesResponse: MoviesResponse? = nil,
         configurationResponse: ConfigurationResponse? = nil) {
        self.moviesResponse = moviesResponse
        self.configurationResponse = configurationResponse
    }

    func fetchConfiguration() async throws -> ConfigurationResponse {
        guard let configurationResponse else {
            throw TestError.sample
        }
        return configurationResponse
    }


    func fetchCurrentMovies() async throws -> MoviesResponse {
        guard let moviesResponse else {
            throw TestError.sample
        }
        return moviesResponse
    }

}
