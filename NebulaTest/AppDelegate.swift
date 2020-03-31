//
//  AppDelegate.swift
//  NebulaTest
//
//  Created by Vodolazkyi Anton on 3/31/20.
//  Copyright © 2020 Vodolazkyi. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: PluggableApplicationDelegate {
    
    override var services: [ApplicationService] {
        let coordinatorService = CoordinatorApplicationService()
        return [coordinatorService]
    }
}
