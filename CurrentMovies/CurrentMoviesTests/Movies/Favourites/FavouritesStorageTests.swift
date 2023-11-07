//
//  FavouritesStorageTests.swift
//  CurrentMoviesTests
//
//  Created by Bartlomiej Zdybowicz on 07/11/2023.
//

@testable import CurrentMovies
import XCTest

final class FavouritesStorageTests: XCTestCase {

    func testStorage() throws {
        let userDefaults = try XCTUnwrap(UserDefaults(suiteName: "Test"))
        let sut = FavouritesStorage(userDefaults: userDefaults)
        sut.add(id: 123)
        sut.add(id: 355)
        sut.add(id: 664)
        let stored = (userDefaults.array(forKey: "Favourite.Movies.Key") as? [Int]) ?? []
        XCTAssertEqual([123, 355, 664], stored.sorted())
        sut.remove(id: 123)
        let storedPostRemove = (userDefaults.array(forKey: "Favourite.Movies.Key") as? [Int]) ?? []
        XCTAssertEqual([355, 664], storedPostRemove.sorted())
        XCTAssertFalse(sut.isFavourite(id: 400))
        XCTAssertTrue(sut.isFavourite(id: 355))
        XCTAssertTrue(sut.isFavourite(id: 664))
    }

}
