//
//  MBCoordinator.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation
import UIKit

class MBCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let window: UIWindow
    let navigationController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.navigationController = UINavigationController()
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func start() {
        let homeCoordinator = HomeCoordinator(navigation: self.navigationController)
        childCoordinators.append(homeCoordinator)
        homeCoordinator.start()
    }
}
