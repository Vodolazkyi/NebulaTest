//
//  ApplicationFlowCoordinator.swift
//
//  Created by Vodolazkyi Anton on 11/8/18.
//

import UIKit
import Swinject
import Core

final class ApplicationFlowCoordinator: EventNode {
    
    private unowned let window: UIWindow
    private let container: Container
    
    init(window: UIWindow) {
        self.window = window
        self.container = Container { ApplicationFlowAssembly().assemble(container: $0) }
        
        super.init(parent: nil)
        addEventsHandlers()
        observeSession()
    }
    
    func startFlow() {
        let flowStrategy: ApplicationFlowStrategy = container.autoresolve()
        
        switch flowStrategy.startFlow() {
        case .auth: presentAuthFlow()
        case .main: presentMainFlow()
        }
    }
    
    private func addEventsHandlers() {
        addHandler { [weak self] (event: AuthFlowEvent) in
            guard let `self` = self else { return }
            
            switch event {
            case .complete:
                self.startFlow()
            }
        }
    }
    
    private func observeSession() {
        let sessionController: UserSessionController = container.autoresolve()
        sessionController.userSession.sessionInvalidated = { [unowned self] userId in
            UIView.transition(
                with: self.window,
                duration: 0.3,
                options: .transitionFlipFromLeft,
                animations: { [weak self] in
                    self?.presentAuthFlow()
                },
                completion: nil
            )
        }
    }

    private func presentMainFlow() {
        let coordinator = container.resolve(MainFlowCoordinator.self, argument: self as EventNode)!
        presentFlow(coordinator)
    }
    
    private func presentAuthFlow() {
        let coordinator = container.resolve(AuthFlowCoordinator.self, argument: self as EventNode)!
        presentFlow(coordinator)
    }
    
    private func presentFlow(_ coordinator: Coordinator) {
        let flowEntry = coordinator.createFlow()
        window.rootViewController = flowEntry
        window.makeKeyAndVisible()
    }
}
