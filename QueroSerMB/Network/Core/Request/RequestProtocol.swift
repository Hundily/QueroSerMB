//
//  NetworkConfiguration.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

protocol RequestProtocol {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Data? { get }
    var parameters: [String: Any]? { get }
    
    func asURLRequest() -> URLRequest
}

extension RequestProtocol {
    func asURLRequest() -> URLRequest {
        // 1. Constrói a URL com QUERY PARAMETERS (Usando URLComponents)
        guard var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false) else {
            fatalError("URL inválida.")
        }

        // Adiciona os parâmetros de query se existirem
        if let parameters = parameters as? [String: String] {
            urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        }
        
        guard let finalURL = urlComponents.url else { fatalError("URL inválida.") }
        
        var request = URLRequest(url: finalURL) // Usa a URL final com Query String
        
        // 2. Define Headers e Body (igual)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body // Usado apenas para POST/PUT/PATCH
        
        return request
    }
}
