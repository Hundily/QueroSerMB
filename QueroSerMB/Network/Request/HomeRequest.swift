//
//  HomeRequest.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

struct HomeRequest: RequestProtocol {
    
    let slugs: [String]
    
    init(slugs: [String]) {
        self.slugs = slugs
    }
    
    var baseURL: URL {
        URL(string: "https://pro-api.coinmarketcap.com")!
    }
    
    var path: String {
        return "/v1/exchange/info"
    }
    
    var method: HTTPMethod {
        return .get
    }

    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    
    var parameters: [String: Any]? {
        return ["slug": slugs.joined(separator: ",")]
    }
    
    var body: Data?
}

struct HomeExchangeListRequest: RequestProtocol {
    
    var baseURL: URL {
        URL(string: "https://pro-api.coinmarketcap.com")!
    }
    
    var path: String {
        return "/v1/exchange/map"
    }
    
    var method: HTTPMethod {
        return .get
    }

    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    
    var parameters: [String: Any]?
    
    var body: Data?
}
