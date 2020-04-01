//
//  MainAssembly.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import Swinject
import Core

final class MainAssembly: Assembly {
    
    init() {}
    
    func assemble(container: Container) {
        container.register(AlbumsListViewController.self) { (_, parentNode: EventNode) in
            let model = AlbumsListModel(parentNode)
            return AlbumsListViewController(model: model)
        }.inObjectScope(.transient)
    }
}
