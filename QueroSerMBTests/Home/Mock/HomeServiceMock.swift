//
//  HomeServiceMock.swift
//  QueroSerMBAppTests
//
//  Created by Hundily Cerqueira on 19/11/25.
//

import Foundation
import XCTest
@testable import QueroSerMB

class HomeServiceMock: HomeServiceProtocol {
    var fetchResult: Result<HomeResponse, MBNetworkBaseError>?
    var fetchCoinsResult: Result<HomeDetailResponse, MBNetworkBaseError>?

    func fetch(params: [String],
               completion: @escaping (Result<HomeResponse, MBNetworkBaseError>) -> Void) {

        if let result = fetchResult {
            completion(result)
        } else {
            XCTFail("fetchResult não configurado no mock")
        }
    }

    func fetchCoins(params: HomeDetailRequest,
                    completion: @escaping (Result<HomeDetailResponse, MBNetworkBaseError>) -> Void) {

        if let result = fetchCoinsResult {
            completion(result)
        } else {
            XCTFail("fetchCoinsResult não configurado no mock")
        }
    }
    
    func fetchExchangeMap(completion: @escaping (Result<HomeExchangeMapResponse, MBNetworkBaseError>) -> Void) {
        
    }
}
