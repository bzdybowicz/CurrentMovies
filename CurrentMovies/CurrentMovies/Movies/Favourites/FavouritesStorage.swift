//
//  FavouritesStorage.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 07/11/2023.
//

import Foundation
import Combine

protocol FavouritesStorageProtocol {
    func add(id: Int)
    func remove(id: Int)
    func isFavourite(id: Int) -> Bool

    var changePublisher: AnyPublisher<FavouriteChange, Never> { get }
}

struct FavouriteChange: Equatable {
    let newValue: Bool
    let id: Int
}

struct FavouritesStorage: FavouritesStorageProtocol {

    var changePublisher: AnyPublisher<FavouriteChange, Never> { passthroughSubject.eraseToAnyPublisher() }

    private let passthroughSubject = PassthroughSubject<FavouriteChange, Never>()
    private let userDefaults: UserDefaults
    private let key = "Favourite.Movies.Key"

    init(userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func add(id: Int) {
        var array = getArray()
        var set = Set(array)
        if set.insert(id).inserted {
            passthroughSubject.send(FavouriteChange(newValue: true, id: id))
            array.append(id)
        }
        saveArray(array)
    }

    func remove(id: Int) {
        var array = getArray()
        array.removeAll(where: {
            $0 == id
        })
        passthroughSubject.send(FavouriteChange(newValue: false, id: id))
        saveArray(array)
    }

    func isFavourite(id: Int) -> Bool {
        getArray().firstIndex(of: id) != nil
    }

}

private extension FavouritesStorage {

    func getArray() -> [Int] {
        let array = userDefaults.array(forKey: key) as? [Int]
        if let array {
            return array
        } else {
            return [Int]()
        }
    }

    func saveArray(_ array: [Int]) {
        userDefaults.set(array, forKey: key)
    }

}
