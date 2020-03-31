//
//  ApplicationServicesManager.swift
//
//  Created by Vodolazkyi Anton on 1/14/19.
//

import UIKit

/// This is only a tagging protocol.
/// It doesn't add more functionalities yet.
public protocol ApplicationService: UIApplicationDelegate {}

open class PluggableApplicationDelegate: UIResponder, UIApplicationDelegate {
    
    public var window: UIWindow?
    
    open var services: [ApplicationService] { [] }
    // swiftlint:disable identifier_name
    private lazy var __services: [ApplicationService] = {
        self.services
    }()
    // swiftlint:enable identifier_name
    
    open func applicationDidFinishLaunching(_ application: UIApplication) {
        __services.forEach { $0.applicationDidFinishLaunching?(application) }
    }
    
    open func application(
        _ application: UIApplication,
        willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, willFinishLaunchingWithOptions: launchOptions) ?? false {
                result = true
            }
        }
        return result
    }
    
    open func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, didFinishLaunchingWithOptions: launchOptions) ?? false {
                result = true
            }
        }
        return result
    }
    
    open func applicationDidBecomeActive(_ application: UIApplication) {
        for service in __services {
            service.applicationDidBecomeActive?(application)
        }
    }
    
    open func applicationWillResignActive(_ application: UIApplication) {
        for service in __services {
            service.applicationWillResignActive?(application)
        }
    }
    
    @available(iOS, introduced: 2.0, deprecated: 9.0, message: "Please use application:openURL:options:")
    open func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, handleOpen: url) ?? false {
                result = true
            }
        }
        return result
    }
    
    @available(iOS, introduced: 4.2, deprecated: 9.0, message: "Please use application:openURL:options:")
    open func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        var result = false
        for service in __services {
            if service.application?(application, open: url, sourceApplication: sourceApplication, annotation: annotation) ?? false {
                result = true
            }
        }
        return result
    }
    
    @available(iOS 9.0, *)
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        var result = false
        for service in __services {
            if service.application?(app, open: url, options: options) ?? false {
                result = true
            }
        }
        return result
    }
    
    open func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        for service in __services {
            service.applicationDidReceiveMemoryWarning?(application)
        }
    }
    
    open func applicationWillTerminate(_ application: UIApplication) {
        for service in __services {
            service.applicationWillTerminate?(application)
        }
    }
    
    open func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        for service in __services {
            service.application?(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
        }
    }
    
    open func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        for service in __services {
            service.application?(application, didFailToRegisterForRemoteNotificationsWithError: error)
        }
    }
    
    open func applicationDidEnterBackground(_ application: UIApplication) {
        for service in __services {
            service.applicationDidEnterBackground?(application)
        }
    }
    
    open func applicationWillEnterForeground(_ application: UIApplication) {
        for service in __services {
            service.applicationWillEnterForeground?(application)
        }
    }
}
