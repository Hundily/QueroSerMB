//
//  NetworkBaseService.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

class MBBaseService: MBBaseServiceProtocol {
    
    private let session: URLSession
    private let apiKey: String = "92bba6cd4145463fb6cff38d71cd9276"
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetch<T: Decodable>(request: RequestProtocol, model: T.Type, completion: @escaping (Result<T, MBNetworkBaseError>) -> Void) {
        
        var urlRequest = request.asURLRequest()
        urlRequest.setValue(apiKey, forHTTPHeaderField: "X-CMC_PRO_API_KEY")
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(MBNetworkBaseError.invalidURL))
                return
            }
            
            if let parameters = request.parameters as? [String: String] {
                if var urlComponents = URLComponents(url: urlRequest.url!, resolvingAgainstBaseURL: false) {
                    // Converte [String: String] em [URLQueryItem]
                    urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
                    
                    // Atualiza a URL da requisição
                    urlRequest.url = urlComponents.url
                }
            }
            
            guard let data = data else {
                completion(.failure(MBNetworkBaseError.noData))
                return
            }
            
            do {
                if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []),
                   let jsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                   let jsonString = String(data: jsonData, encoding: .utf8) {
                    print("📦 JSON recebido:\n\(jsonString)")
                }
                
                let decodedModel = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(decodedModel))
                }
                
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(MBNetworkBaseError.parse))
                }
            }
        }
        task.resume()
    }
    
    func fetchData(request: RequestProtocol, completion: @escaping (Result<Data, any Error>) -> Void) {
        let urlRequest = request.asURLRequest()
        
        let task = session.dataTask(with: urlRequest) { data, response, error in
            if error != nil {
                completion(.failure(error ?? MBNetworkBaseError.badRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(MBNetworkBaseError.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
        task.resume()
    }
}
