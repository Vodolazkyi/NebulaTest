//
//  KeychainService.swift
//
//  Created by Anton Vodolazkyi on 08.08.17.
//

import KeychainAccess

enum KeychainKey: String, CaseIterable {
    case token
    case userId
}

public final class KeychainService {
    
    static let shared = KeychainService()
    
    private let keychain = Keychain(service: Bundle.main.bundleIdentifier!)
    
    public init() {}
    
    func get(for key: KeychainKey) -> String? {
        return keychain[string: key.rawValue]
    }
    
    func save(value: String?, for key: KeychainKey) {
        keychain[string: key.rawValue] = value
    }
    
    func delete(_ keys: [KeychainKey]) {
        keys.forEach { try? keychain.remove($0.rawValue) }
    }
}
