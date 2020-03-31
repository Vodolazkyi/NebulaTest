//
//  AuthFlowCoordinator.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright (c) 2020 Vodolazkyi. All rights reserved.
//
//

import UIKit
import Swinject

enum AuthFlowEvent: Event {
    case complete
}

final class AuthFlowCoordinator: EventNode {
    
    private let container: Container
    private weak var root: UINavigationController!
    
    init(parentNode: EventNode, parentContainer: Container) {
        self.container = Container(parent: parentContainer) { AuthAssembly().assemble(container: $0) }
        
        super.init(parent: parentNode)
        addEventsHandlers()
    }
    
    private func addEventsHandlers() {
//        addHandler { [weak self] (event: AuthFlowEvent) in
//            guard let `self` = self else { return }
//            
//            switch event {
//                
//            }
//        }
    }
}

extension AuthFlowCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let controller = UIViewController()
        let navigation = UINavigationController(rootViewController: controller)
        root = navigation
        return root
    }
}
