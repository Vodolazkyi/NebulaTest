//
//  CoordinatorApplicationService.swift
//
//  Created by Vodolazkyi Anton on 1/14/19.
//

import UIKit
import Core
import FBSDKCoreKit

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

        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        applicationFlowCoordinator.startFlow()

        return true
    }
    
    func application(
        _ app: UIApplication,
        open url: URL,
        options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        ApplicationDelegate.shared.application(
            app,
            open: url,
            sourceApplication: options[.sourceApplication] as? String,
            annotation: options[.annotation]
        )
    }
}
