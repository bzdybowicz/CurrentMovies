//
//  MoviesServiceTests.swift
//  CurrentMoviesTests
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import XCTest
@testable import CurrentMovies

enum TestError: Error {
    case sample
}

final class MoviesServiceTests: XCTestCase {

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

    func testFetchMoviesError() async throws {
        let sessionStub = URLSessionRecordingStub(error: TestError.sample)
        let decoderStub = JSONDecoderRecordingStub(decoded: stubbedResponse)
        let apiKeystorageStub = ApiKeyStorageRecordingStub(key: "Key")
        let sut = MoviesService(urlSession: sessionStub, apiKeyStorage: apiKeystorageStub, decoder: decoderStub)
        do {
            _ = try await sut.fetchCurrentMovies(page: 1)
            XCTFail("Unexpected success")
        } catch let error {
            XCTAssertEqual(error as? TestError, TestError.sample)
        }
        XCTAssertEqual(sessionStub.recordedRequest?.url?.absoluteString, "https://api.themoviedb.org/3/movie/now_playing?language=en-US&api_key=Key&page=1")
        XCTAssertEqual(decoderStub.recordedData, nil)
    }

    func testFetchMoviesSuccess() async throws {
        let sessionStub = URLSessionRecordingStub(data: try JSONEncoder().encode(stubbedResponse))
        let decoderStub = JSONDecoderRecordingStub(decoded: stubbedResponse)
        let apiKeystorageStub = ApiKeyStorageRecordingStub(key: "Key")
        let sut = MoviesService(urlSession: sessionStub, apiKeyStorage: apiKeystorageStub, decoder: decoderStub)
        var response: MoviesResponse?
        do {
            response = try await sut.fetchCurrentMovies(page: 1)
        } catch let error {
            XCTFail("Unexpected error \(error)")
        }
        XCTAssertEqual(response, response)
        XCTAssertEqual(sessionStub.recordedRequest?.url?.absoluteString, "https://api.themoviedb.org/3/movie/now_playing?language=en-US&api_key=Key&page=1")
        XCTAssertEqual(decoderStub.recordedData, try JSONEncoder().encode(response))
    }
}
