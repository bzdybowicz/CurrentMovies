//
//  URLSessionProtocol.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

protocol URLSessionProtocol {
    func data(for request: URLRequest) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol {}
