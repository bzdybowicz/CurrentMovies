//
//  MovieDetailViewModel.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Combine
import UIKit

@MainActor
protocol MovieDetailViewModelProtocol {
    var item: MovieItemViewModel { get }
    var releaseDateText: String { get }
    var imagePublisher: AnyPublisher<UIImage, Never> { get }
    var imageRatioPublisher: AnyPublisher<CGFloat, Never> { get }
}

@MainActor
final class MovieDetailViewModel: MovieDetailViewModelProtocol {

    let item: MovieItemViewModel
    let releaseDateText = L10n.Detail.ReleaseDate.label
    var imagePublisher: AnyPublisher<UIImage, Never> { imageSubject.eraseToAnyPublisher() }
    var imageRatioPublisher: AnyPublisher<CGFloat, Never> { imageRatioSubject.eraseToAnyPublisher() }

    private let imageRatioSubject = PassthroughSubject<CGFloat, Never>()
    private let imageSubject = PassthroughSubject<UIImage, Never>()
    private let moviesService: MoviesServiceProtocol
    private let imageService: ImageServiceProtocol

    init(item: MovieItemViewModel,
         moviesService: MoviesServiceProtocol,
         imageService: ImageServiceProtocol) {
        self.item = item
        self.moviesService = moviesService
        self.imageService = imageService
        getConfiguration()
    }
}

private extension MovieDetailViewModel {

    func getConfiguration() {
        Task { [weak self] in
            guard let self else { return }
            do {
                let configuration = try await self.moviesService.fetchConfiguration()
                guard let imageUrl = configuration.image.secureBaseUrl,
                      let size = configuration.size,
                      let path = item.backdropPath else {
                    return
                }
                let fullUrl = imageUrl + size + path
                let image = try await self.imageService.fetchImage(urlString: fullUrl)
                self.handleImage(image: image)
            } catch let error {
                print("Error \(error)")
                // Not required.
            }
        }
    }

    func handleImage(image: UIImage) {
        var ratio: CGFloat
        if image.size.height == 0 || image.size.height > image.size.width {
            ratio = 1
        } else {
            ratio = image.size.height / image.size.width
        }
        imageRatioSubject.send(ratio)
        imageSubject.send(image)
    }
}

extension ConfigurationResponse {

    var size: String? {
        guard let sizes = image.backDropSizes else { return nil }
        if sizes.count > 1 {
            return sizes[1]
        } else {
            return sizes.first
        }
    }

}
