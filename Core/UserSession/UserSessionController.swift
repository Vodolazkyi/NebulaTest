//
//  UserSessionController.swift
//  Core
//
//  Created by Vodolazkyi Anton on 11/8/18.
//

import Foundation

public final class UserSessionController {
    
    public let userSession: UserSession
    
    public init(storage: TokensStoragable) {
        userSession = UserSession(storage: storage)
    }

    public func openSession(with provider: SessionInfo) {
        userSession.startSession(with: provider)
    }
    
    public func closeSession() {
        userSession.stopSession()
    }
    
    public func canRestorePreviousSession() -> Bool {
        return userSession.canRestorePreviousSession()
    }
}
