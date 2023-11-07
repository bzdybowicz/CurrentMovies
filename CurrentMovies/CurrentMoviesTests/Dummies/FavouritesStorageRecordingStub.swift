//
//  FavouritesStorageRecordingStub.swift
//  CurrentMoviesTests
//
//  Created by Bartlomiej Zdybowicz on 07/11/2023.
//

import Combine
import Foundation
@testable import CurrentMovies

final class FavouritesRecordingStub: FavouritesStorageProtocol {

    private (set)var recordedAdds = [Int]()
    private (set)var recordedRemoves = [Int]()
    private (set)var recordedGetCallsCount = 0
    private (set)var recordedIsFavourite = [Int]()

    private let favourites: [Int]
    var changePublisher: AnyPublisher<FavouriteChange, Never>

    init(changePublisher: AnyPublisher<FavouriteChange, Never>, favourites: [Int] = []) {
        self.changePublisher = changePublisher
        self.favourites = favourites
    }

    func add(id: Int) {
        recordedAdds.append(id)
    }

    func remove(id: Int) {
        recordedRemoves.append(id)
    }

    func isFavourite(id: Int) -> Bool {
        favourites.firstIndex(where: { $0 == id }) != nil
    }

}
