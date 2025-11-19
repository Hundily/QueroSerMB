//
//  HomeDetailRequest.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 19/11/25.
//

import Foundation

struct HomeDetailRequest: RequestProtocol {
    
    let id: String
    
    init(id: String) {
        self.id = id
    }
    
    var baseURL: URL {
        URL(string: "https://pro-api.coinmarketcap.com")!
    }
    
    var path: String {
        return "/v1/exchange/assets"
    }
    
    var method: HTTPMethod {
        return .get
    }

    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    
    var parameters: [String: Any]? {
        return ["id": id]
    }
    
    var body: Data?
}
