//
//  JSONDecoderProtocol.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

protocol JSONDecoderProtocol {
    func decode<T>(_ type: T.Type, from data: Data) throws -> T where T : Decodable
}

extension JSONDecoder: JSONDecoderProtocol {
}
