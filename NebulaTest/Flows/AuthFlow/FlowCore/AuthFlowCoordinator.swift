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
        addHandler { [weak self] (event: AuthModelEvent) in
            guard let `self` = self else { return }

            switch event {
            case .loggedIn: self.raise(event: AuthFlowEvent.complete)
            }
        }
    }
}

extension AuthFlowCoordinator: Coordinator {
    
    func createFlow() -> UIViewController {
        let controller = container.resolve(AuthViewController.self, argument: self as EventNode)!
        let navigation = UINavigationController(rootViewController: controller)
        root = navigation
        return root
    }
}
