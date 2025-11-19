//
//  HomeDetailCoordinatorMock.swift
//  QueroSerMBTests
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation
import XCTest
@testable import QueroSerMB

class HomeDetailCoordinatorMock: HomeDetailCoordinatorProtocol {
    
    var closeCalled = false
    var openDetailCalled = false
    var receivedService: HomeServiceProtocol?
    var receivedModel: ExchangeModel?
    
    func closedView() {
        closeCalled = true
    }
    
    func openDetail(service: HomeServiceProtocol, model: ExchangeModel) {
        openDetailCalled = true
        receivedService = service
        receivedModel = model
    }
}
