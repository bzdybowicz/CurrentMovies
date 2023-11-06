//
//  JSONDecoderRecordingStub.swift
//  CurrentMoviesTests
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

import Foundation
@testable import CurrentMovies
import XCTest

final class JSONDecoderRecordingStub: JSONDecoderProtocol {

    private let decoded: Decodable

    private(set) var recordedData: Data?

    init(decoded: Decodable) {
        self.decoded = decoded
    }

    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable {
        recordedData = data
        return try XCTUnwrap(decoded as? T)
    }
}
