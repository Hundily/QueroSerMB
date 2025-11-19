//
//  Coordinator.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    func start()
}
