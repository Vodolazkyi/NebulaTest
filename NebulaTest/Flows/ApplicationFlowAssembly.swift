//
//  ApplicationFlowAssembly.swift
//
//  Created by Vodolazkyi Anton on 11/9/18.
//

import Swinject
import Core
import YALAPIClient

final class ApplicationFlowAssembly: Assembly {
    
    func assemble(container: Container) {
        assembleServices(container: container)
        assembleCoordinators(container: container)
    }
    
    private func assembleServices(container: Container) {
        container.register(KeychainService.self) { _ in
            KeychainService()
        }.inObjectScope(.container)

        container.register(TokensStoragable.self) {
            TokensStorage(storage: $0.autoresolve())
        }.inObjectScope(.container)

        container.register(UserSessionController.self) {
            UserSessionController(storage: $0.autoresolve())
        }.inObjectScope(.container)

        container.register(UserSession.self) { resolver in
            let controller: UserSessionController = resolver.autoresolve()
            return controller.userSession
        }.inObjectScope(.container)
        
        container.register(ApplicationFlowStrategy.self) { resolver in
            ApplicationFlowStrategy(sessionController: resolver.autoresolve())
        }.inObjectScope(.container)
    }
    
    private func assembleCoordinators(container: Container) {
        container.register(AuthFlowCoordinator.self) { (_, parent: EventNode) in
            AuthFlowCoordinator(parentNode: parent, parentContainer: container)
        }.inObjectScope(.transient)
        
        container.register(MainFlowCoordinator.self) { (_, parent: EventNode) in
            MainFlowCoordinator(parentNode: parent, parentContainer: container)
        }.inObjectScope(.transient)
    }
}
