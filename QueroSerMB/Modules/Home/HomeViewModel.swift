//
//  HomeViewModel.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

protocol HomeViewModelProtocol: AnyObject {
    var coordinator: HomeCoordinatorProtocol? { get set }
    var state: Observable<GenericState<[ExchangeModel]>> { get }
    var model: [ExchangeModel] { get set }
    var slug: [String] { get set }
    func fetchExchangesMap()
    func fetchExchanges()
    func didOpenProductDetail(model: ExchangeModel)
}

class HomeViewModel {
    let state: Observable<GenericState<[ExchangeModel]>> = .init(.loading(false))
    var model: [ExchangeModel] = []
    var slug: [String] = []
    
    var service: HomeServiceProtocol
    var coordinator: HomeCoordinatorProtocol?
    
    init(service: HomeServiceProtocol, coordinator: HomeCoordinatorProtocol?) {
        self.service = service
        self.coordinator = coordinator
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    
    /// Na documentação essa api (v1/exchange/map) retornar todas as exchanges com id, slug e se esta ativa
    /// Fiz um filtro de slug e tambem tentei só id a api v1/exchange/info retorna erro ou seja não sei qual SLUG ou ID enviar, por isso esta estao em hard code
    /// Pelo oque eu li na v1/exchange/info é obrigatorio o envio ou do ID ou do SLUG para este endpoint.
    func fetchExchangesMap() {
        state.value = .loading(true)
        
        service.fetchExchangeMap { [weak self] (result: Result<HomeExchangeMapResponse, MBNetworkBaseError>) in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                self.slug.append(contentsOf:
                    data.data
                        .filter { $0.isActive == 1 }
                        .compactMap { $0.slug }
                )
                
                if !self.slug.isEmpty {
                    self.fetchExchanges()
                }
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
     
    func fetchExchanges() {
        state.value = .loading(true)
        
        service.fetch(params: ["binance", "coinmate", "zaif"]) { [weak self] (result: Result<HomeResponse, MBNetworkBaseError>) in
            guard let self = self else { return }
            self.state.value = .loading(false)
            
            switch result {
            case .success(let data):
                let exchanges = Array(data.data.values)
                self.state.value = .loaded(exchanges)
                self.model = exchanges
            case .failure(let error):
                self.state.value = .error(error)
            }
        }
    }
    
    func didOpenProductDetail(model: ExchangeModel) {
        coordinator?.openDetailView(model: model)
    }
}
