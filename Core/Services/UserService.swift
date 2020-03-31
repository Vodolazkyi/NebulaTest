//
//  UserService.swift
//  Core
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright © 2020 Vodolazkyi. All rights reserved.
//

import Foundation

public final class UserService {
    
    private let userSessionController: UserSessionController
    
    public init(userSessionController: UserSessionController) {
        self.userSessionController = userSessionController
    }
    
    public func login(with userId: String, token: String) {
        let sessionInfo = SessionInfo(userId: userId, token: token)
        userSessionController.openSession(with: sessionInfo)
    }
}
