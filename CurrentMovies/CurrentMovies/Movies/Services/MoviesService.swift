//
//  MoviesService.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

protocol MoviesServiceProtocol {
    func fetchCurrentMovies(page: Int32) async throws -> MoviesResponse
    func fetchConfiguration() async throws -> ConfigurationResponse

    func searchMovies(query: String) async throws -> MoviesResponse
}

enum ServiceError: Error {
    case urlCreationFailure
    case requestFailure
    case noApiKey
}

struct MoviesService: MoviesServiceProtocol {

    private let urlSession: URLSessionProtocol
    private let apiKeyStorage: ApiKeyStorageProtocol
    private let decoder: JSONDecoderProtocol

    private let baseApiString = "https://api.themoviedb.org/3/"
    private let acceptKey = "accept"
    private let jsonValue = "application/json"

    init(urlSession: URLSessionProtocol,
         apiKeyStorage: ApiKeyStorageProtocol,
         decoder: JSONDecoderProtocol) {
        self.urlSession = urlSession
        self.apiKeyStorage = apiKeyStorage
        self.decoder = decoder
    }

    func fetchCurrentMovies(page: Int32) async throws -> MoviesResponse {
        let response = try await performRequest(request: .nowPlaying(page: page))
        return try decoder.decode(MoviesResponse.self, from: response.0)
    }

    func fetchConfiguration() async throws -> ConfigurationResponse {
        let response = try await performRequest(request: .configuration)
        return try decoder.decode(ConfigurationResponse.self, from: response.0)
    }

    func searchMovies(query: String) async throws -> MoviesResponse {
        let response = try await performRequest(request: .search(query: query))
        return try decoder.decode(MoviesResponse.self, from: response.0)
    }
}

private extension MoviesService {

    func performRequest(request: MoviesRequest) async throws -> (Data, URLResponse) {
        var urlComponents = URLComponents(string: baseApiString + request.path)
        guard let key = apiKeyStorage.getKey() else {
            throw ServiceError.noApiKey
        }
        urlComponents?.queryItems = request.queryItems(apiKey: key)
        guard let url = urlComponents?.url else {
            throw ServiceError.urlCreationFailure
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(jsonValue, forHTTPHeaderField: acceptKey)
        urlRequest.timeoutInterval = 10
        return try await urlSession.data(for: urlRequest)
    }
}
