//
//  HomeCoordinatorMock.swift
//  QueroSerMBAppTests
//
//  Created by Hundily Cerqueira on 19/11/25.
//

import Foundation
@testable import QueroSerMB

class HomeCoordinatorMock: HomeCoordinatorProtocol {

    var openDetailCalled = false
    var tapClosedCalled = false
    var receivedModel: ExchangeModel?

    func openDetailView(model: ExchangeModel) {
        openDetailCalled = true
        receivedModel = model
    }
    
    func closedView() {
        tapClosedCalled = true
    }
}
