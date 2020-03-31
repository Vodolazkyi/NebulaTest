//
//  ApplicationFlowStrategy.swift
//
//  Created by Vodolazkyi Anton on 1/31/19.
//

import Core

enum ApplicationFlowType {
    case auth, main
}

final class ApplicationFlowStrategy {
    
    private let sessionController: UserSessionController
    
    init(sessionController: UserSessionController) {
        self.sessionController = sessionController
    }
    
    func startFlow() -> ApplicationFlowType {
        guard sessionController.canRestorePreviousSession() else {
            return .auth
        }
        return .main
    }
}
