//
//  AuthModel.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import Core

enum AuthModelEvent: Event {
    case loggedIn
}

final class AuthModel: EventNode {
    
    private let userService: UserService
    
    // MARK: - Init.
    
    init(_ parent: EventNode, userService: UserService) {
        self.userService = userService
        super.init(parent: parent)
    }
    
    func login(with token: String, userId: String) {
        userService.login(with: userId, token: token)
        raise(event: AuthModelEvent.loggedIn)
    }
}
