//
//  NetworkBaseServiceProtocol.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

protocol MBBaseServiceProtocol {
    func fetch<T: Decodable>(request: RequestProtocol, model: T.Type, completion: @escaping (Result<T, MBNetworkBaseError>) -> Void)
    func fetchData(request: RequestProtocol, completion: @escaping (Result<Data, Error>) -> Void)
}
