//
//  HomeCoordinator.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import UIKit

protocol HomeCoordinatorProtocol: AnyObject {
    func openDetailView(model: ExchangeModel)
    func closedView()
}

class HomeCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    let navigationController: UINavigationController
    let service = HomeService(service: MBBaseService())
    
    init(navigation: UINavigationController) {
        self.navigationController = navigation
    }
    
    func start() {
        let homeViewModel = HomeViewModel(service: self.service, coordinator: self)
        let homeViewController = HomeViewController(viewModel: homeViewModel)
        navigationController.pushViewController(homeViewController, animated: true)
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    func openDetailView(model: ExchangeModel) {
        let coordinator = HomeDetailCoordinator(navigationController: self.navigationController)
        childCoordinators.append(coordinator)
        coordinator.openDetail(service: self.service, model: model)
    }
    
    func closedView() {
        navigationController.dismiss(animated: true)
    }
    
}
