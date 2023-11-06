//
//  ApiKeyStorageRecordingStub.swift
//  CurrentMoviesTests
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

@testable import CurrentMovies

final class ApiKeyStorageRecordingStub: ApiKeyStorageProtocol {

    private (set) var recordedSaveKeys: [String] = []
    private (set) var recordedGetCallsCount: Int = 0
    private (set) var deleteCallsCount: Int = 0

    private let key: String?

    init(key: String?) {
        self.key = key
    }

    func saveApiKey(_ key: String) throws {
        recordedSaveKeys.append(key)
    }

    func getKey() -> String? {
        recordedGetCallsCount += 1
        return key
    }

    func deleteKey() {
        deleteCallsCount += 1
    }
}
