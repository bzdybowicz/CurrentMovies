//
//  MoviesService.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

protocol MoviesServiceProtocol {
    func fetchCurrentMovies() async throws -> MoviesResponse
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

    func fetchCurrentMovies() async throws -> MoviesResponse {
        var urlComponents = URLComponents(string: baseApiString + MoviesRequest.nowPlaying.path)
        guard let key = apiKeyStorage.getKey() else {
            throw ServiceError.noApiKey
        }
        urlComponents?.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "api_key", value: key)
        ]
        guard let url = urlComponents?.url else {
            throw ServiceError.urlCreationFailure
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue(jsonValue, forHTTPHeaderField: acceptKey)
        let response = try await urlSession.data(for: urlRequest)
        return try decoder.decode(MoviesResponse.self, from: response.0)
    }
}
