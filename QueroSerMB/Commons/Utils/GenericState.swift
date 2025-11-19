//
//  GenericState.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 17/11/25.
//

import Foundation

enum GenericState<Model> {
    case loading(_ state: Bool)
    case loaded(_ model: Model?)
    case error(_ error: Error)
}
