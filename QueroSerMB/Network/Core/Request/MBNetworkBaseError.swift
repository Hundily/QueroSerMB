//
//  NetworkBaseError.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

enum MBNetworkBaseError: Error {
    case invalidURL
    case noData
    case parse
    case badRequest
    case unauthorized
    case clientError
    case unknown
    
}
