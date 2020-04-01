//
//  MainFlowCoordinator.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import UIKit
import Swinject

enum MainFlowEvent: Event {
    
}

final class MainFlowCoordinator: EventNode {
    
    private let container: Container
    private weak var root: UINavigationController!
    
    init(parentNode: EventNode, parentContainer: Container) {
        self.container = Container(parent: parentContainer) { MainAssembly().assemble(container: $0) }
        
        super.init(parent: parentNode)
        addEventsHandlers()
    }
    
    private func addEventsHandlers() {
//        addHandler { [weak self] (event: MainFlowEvent) in
//            guard let `self` = self else { return }
//            
//            switch event {
//                
//            }
//        }
    }
}

extension MainFlowCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let controller = container.resolve(AlbumsListViewController.self, argument: self as EventNode)!
        let navigation = UINavigationController(rootViewController: controller)
        root = navigation
        return root
    }
}
