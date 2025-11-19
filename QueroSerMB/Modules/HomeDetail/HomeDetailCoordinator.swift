//
//  HomeDetailCoordinator.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import UIKit

protocol HomeDetailCoordinatorProtocol: AnyObject {
    func openDetail(service: HomeServiceProtocol, model: ExchangeModel)
    func closedView()
}

class HomeDetailCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() { }
}

extension HomeDetailCoordinator: HomeDetailCoordinatorProtocol {
    
    func openDetail(service: HomeServiceProtocol, model: ExchangeModel) {
        let viewModel = HomeDetailViewModel(service: service, model: model, coordinator: self)
        let homeDetailViewController = HomeDetailViewController(
            viewModel: viewModel
        )
        navigationController.pushViewController(homeDetailViewController, animated: true)
    }
    
    func closedView() {
        navigationController.dismiss(animated: true)
    }
}
