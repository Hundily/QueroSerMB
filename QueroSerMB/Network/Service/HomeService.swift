//
//  HomeService.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

protocol HomeServiceProtocol {
    func fetch(params: [String], completion: @escaping(Result<HomeResponse, MBNetworkBaseError>) -> Void)
    func fetchExchangeMap(completion: @escaping(Result<HomeExchangeMapResponse, MBNetworkBaseError>) -> Void)
    func fetchCoins(params: HomeDetailRequest, completion: @escaping(Result<HomeDetailResponse, MBNetworkBaseError>) -> Void)
}

final class HomeService: HomeServiceProtocol {
    
    private let service: MBBaseServiceProtocol
    
    init(service: MBBaseServiceProtocol) {
        self.service = service
    }
    
    func fetch(params: [String], completion: @escaping (Result<HomeResponse, MBNetworkBaseError>) -> Void) {
        let request = HomeRequest(slugs: params)
        
        service.fetch(request: request, model: HomeResponse.self) { (result: Result<HomeResponse, MBNetworkBaseError>) in
           switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchExchangeMap(completion: @escaping(Result<HomeExchangeMapResponse, MBNetworkBaseError>) -> Void) {
        let request = HomeExchangeListRequest()
        
        service.fetch(request: request, model: HomeExchangeMapResponse.self) { (result: Result<HomeExchangeMapResponse, MBNetworkBaseError>) in
           switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchCoins(params: HomeDetailRequest, completion: @escaping (Result<HomeDetailResponse, MBNetworkBaseError>) -> Void) {
        
        service.fetch(request: params, model: HomeDetailResponse.self) { (result: Result<HomeDetailResponse, MBNetworkBaseError>) in
           switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
