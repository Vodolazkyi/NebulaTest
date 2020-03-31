//
//  CoordinatorApplicationService.swift
//
//  Created by Vodolazkyi Anton on 1/14/19.
//

import UIKit
import Core

final class CoordinatorApplicationService: NSObject, ApplicationService {
    
    var window: UIWindow?
    
    private lazy var applicationFlowCoordinator: ApplicationFlowCoordinator = {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        return ApplicationFlowCoordinator(window: window)
    }()
        
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        applicationFlowCoordinator.startFlow()

        return true
    }
}
