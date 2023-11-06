//
//  ApiKeyStorage.swift
//  CurrentMovies
//
//  Created by Bartlomiej Zdybowicz on 06/11/2023.
//

import Foundation

protocol ApiKeyStorageProtocol {
    func saveApiKey(_ key: String) throws
    func getKey() -> String?
    func deleteKey()
}

final class ApiKeyStorage: ApiKeyStorageProtocol {

    private let service: String = "TMDBKey"
    private let account: String = "MovieApp"

    func saveApiKey(_ key: String) throws {
        let data = try JSONEncoder().encode(key)
        let query: [CFString: Any] = [
            kSecValueData: data,
            kSecClass: kSecClassGenericPassword,
            kSecAttrService: service,
            kSecAttrAccount: account
        ]
        let saveStatus = SecItemAdd(query as CFDictionary, nil)
        if saveStatus != errSecSuccess {
            print("Error: \(saveStatus)")
        }
    }

    func getKey() -> String? {
        let query: [CFString: Any] = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ]
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        guard let data = result as? Data else {
            print("Not Data")
            return nil
        }
        do {
            let key = try JSONDecoder().decode(String.self, from: data)
            return key
        } catch {
            assertionFailure("Fail to decode item, error: \(error)")
            return nil
        }
    }

    func deleteKey() {
        let query: [CFString: Any] = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ]
        SecItemDelete(query as CFDictionary)
    }
}
