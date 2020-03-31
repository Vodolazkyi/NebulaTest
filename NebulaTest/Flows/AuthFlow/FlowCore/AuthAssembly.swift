//
//  AuthAssembly.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import Swinject
import Core

final class AuthAssembly: Assembly {
    
    init() {}
    
    func assemble(container: Container) {
        container.register(AuthViewController.self) { (resolver, parentNode: EventNode) in
            let model = AuthModel(parentNode, userService: resolver.autoresolve())
            return AuthViewController(model: model)
        }.inObjectScope(.transient)
    }
}
