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
        container.register(DBClient.self) { _ in
            return DBClient(modelName: Constants.dataBaseModelName)
        }.inObjectScope(.container)
        
        container.register(GraphService.self) { _ in
            return GraphService()
        }.inObjectScope(.weak)
        
        container.register(PhotoService.self) { resolver in
            return PhotoService(graphService: resolver.autoresolve(), dbClient: resolver.autoresolve())
        }.inObjectScope(.transient)
        
        container.register(AlbumsListViewController.self) { (resolver, parentNode: EventNode) in
            let model = AlbumsListModel(parentNode, photoService: resolver.autoresolve())
            return AlbumsListViewController(model: model)
        }.inObjectScope(.transient)
    }
}
