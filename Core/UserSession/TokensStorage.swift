//
//  TokensStorage.swift
//  Core
//
//  Created by Vodolazkyi Anton on 11/8/18.
//

import Foundation

public final class TokensStorage: TokensStoragable {
    
    private let storage: KeychainService
    
    public init(storage: KeychainService) {
        self.storage = storage
    }
    
    public func obtain() -> SessionInfo? {
        guard let token = storage.get(for: .token),
            let userId = Int(storage.get(for: .userId) ?? "") else {
                return nil
        }
        return SessionInfo(userId: userId, token: token)
    }
    
    public func update(token: String) {
        storage.save(value: token, for: .token)
    }
    
    public func save(data: SessionInfo) {
        storage.save(value: data.token, for: .token)
        storage.save(value: String(data.userId), for: .userId)
    }
    
    public func clean() {
        storage.delete([.userId, .token])
    }
}
