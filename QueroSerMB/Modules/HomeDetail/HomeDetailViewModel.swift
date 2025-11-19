//
//  HomeDetailViewModel.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

protocol HomeDetailViewModelProtocol: AnyObject {
    var state: Observable<GenericState<[CoinModel]>> { get set }
    func getDetail() -> ExchangeModel
    func closedView()
    func fetchCoins()
}

class HomeDetailViewModel: HomeDetailViewModelProtocol {
    
    private(set) var model: ExchangeModel
    var service: HomeServiceProtocol
    var coordinator: HomeDetailCoordinatorProtocol
    var state: Observable<GenericState<[CoinModel]>> = .init(.loading(false))
    
    init(service: HomeServiceProtocol, model: ExchangeModel, coordinator: HomeDetailCoordinatorProtocol) {
        self.service = service
        self.model = model
        self.coordinator = coordinator
    }
    
    func fetchCoins() {
        state.value = .loading(true)
        
        guard let rawId = model.id else {
            self.state.value = .error(MBNetworkBaseError.unknown)
            return
        }
        
        let id = String(rawId)
        let request = HomeDetailRequest(id: id)
        
        service.fetchCoins(params: request) { [weak self] (result: Result<HomeDetailResponse, MBNetworkBaseError>) in
            guard let self = self else { return }
            self.state.value = .loading(false)
            
            switch result {
            case .success(let data):
                self.state.value = .loaded(data.data)

            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
    
    func getDetail() -> ExchangeModel {
        return model
    }
    
    func closedView() {
        self.coordinator.closedView()
    }
}

