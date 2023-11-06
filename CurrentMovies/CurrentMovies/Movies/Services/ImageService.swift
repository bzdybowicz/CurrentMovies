//
//  ImageService.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import UIKit

protocol ImageServiceProtocol {
    func fetchImage(urlString: String) async throws -> UIImage
}

enum ImageServiceError: Error {
    case urlFailure
    case imageDecodingFailure
}

final class ImageService: ImageServiceProtocol {

    private let urlSession: URLSessionProtocol

    init(urlSession: URLSessionProtocol) {
        self.urlSession = urlSession
    }

    func fetchImage(urlString: String) async throws -> UIImage {
        guard let url = URL(string: urlString) else {
            throw ImageServiceError.urlFailure
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        if let image = UIImage(data: data) {
            return image
        } else {
            throw ImageServiceError.imageDecodingFailure
        }
    }
}
