//
//  HomeViewModelTests.swift
//  QueroSerMBAppTests
//
//  Created by Hundily Cerqueira on 19/11/25.
//

import Foundation
import XCTest
@testable import QueroSerMB

final class HomeViewModelTests: XCTestCase {

    var sut: HomeViewModel!
    var serviceMock: HomeServiceMock!
    var coordinatorMock: HomeCoordinatorMock!

    override func setUp() {
        super.setUp()
        serviceMock = HomeServiceMock()
        coordinatorMock = HomeCoordinatorMock()
        sut = HomeViewModel(service: serviceMock, coordinator: coordinatorMock)
    }

    override func tearDown() {
        sut = nil
        serviceMock = nil
        coordinatorMock = nil
        super.tearDown()
    }

    // MARK: - Teste de Sucesso
    func test_fetchExchanges_success_shouldUpdateStateAndModel() {

        // Given
        let exchange = ExchangeModel(
            logo: nil, id: 1, countries: nil, taker_fee: nil, notice: nil,
            alertLink: nil, slug: nil, fiats: nil, porStatus: nil,
            off_ramp_direct_withdrawal: nil, description: nil,
            on_ramp_google_apple_pay: nil, is_hidden: nil, alertType: nil,
            type: nil, spot_volume_usd: nil, date_launched: nil,
            porAuditStatus: nil, off_ramp_p2p: nil, porSwitch: nil,
            spot_volume_last_updated: nil, algorithm: nil,
            weekly_visits: nil, name: "Binance",
            walletSourceStatus: nil, tags: nil,
            maker_fee: nil, on_ramp_third_party: nil,
            on_ramp_p2p: nil, urls: nil, is_redistributable: nil,
            on_ramp_card_visa_mastercard: nil, on_ramp_direct_deposit: nil
        )
        
        let response = HomeResponse(
            status: Status(error_message: nil, notice: nil, timestamp: "123",
                           credit_count: 0, elapsed: 0, error_code: 0),
            data: ["binance": exchange]
        )

        serviceMock.fetchResult = .success(response)

        let expectationState = expectation(description: "state updated")

        sut.state.bind { state in
            if case .loaded(let result) = state {
                XCTAssertEqual(result?.count, 1)
                XCTAssertEqual(result?.first?.name, "Binance")
                expectationState.fulfill()
            }
        }

        // When
        sut.fetchExchanges()

        // Then
        wait(for: [expectationState], timeout: 1.0)
        XCTAssertEqual(sut.model.count, 1)
        XCTAssertEqual(sut.model.first?.name, "Binance")
    }

    // MARK: - Teste de Erro

    func test_fetchExchanges_failure_shouldUpdateStateWithError() {

        let error = MBNetworkBaseError.badRequest
        serviceMock.fetchResult = .failure(error)

        let expectationState = expectation(description: "state error updated")

        sut.state.bind { state in
            if case .error(let receivedError) = state {
                XCTAssertEqual(receivedError as? MBNetworkBaseError, error)
                expectationState.fulfill()
            }
        }

        sut.fetchExchanges()

        wait(for: [expectationState], timeout: 1.0)
        XCTAssertTrue(sut.model.isEmpty)
    }

    // MARK: - Teste de Navegação
    func test_didOpenProductDetail_shouldCallCoordinator() {

        // Given
        let model = ExchangeModel(
            logo: nil, id: 123, countries: nil, taker_fee: nil, notice: nil,
            alertLink: nil, slug: nil, fiats: nil, porStatus: nil,
            off_ramp_direct_withdrawal: nil, description: nil,
            on_ramp_google_apple_pay: nil, is_hidden: nil, alertType: nil,
            type: nil, spot_volume_usd: nil, date_launched: nil,
            porAuditStatus: nil, off_ramp_p2p: nil, porSwitch: nil,
            spot_volume_last_updated: nil, algorithm: nil,
            weekly_visits: nil, name: "Coinbase",
            walletSourceStatus: nil, tags: nil,
            maker_fee: nil, on_ramp_third_party: nil,
            on_ramp_p2p: nil, urls: nil, is_redistributable: nil,
            on_ramp_card_visa_mastercard: nil, on_ramp_direct_deposit: nil
        )

        sut.didOpenProductDetail(model: model)

        XCTAssertTrue(coordinatorMock.openDetailCalled)
        XCTAssertEqual(coordinatorMock.receivedModel?.id, 123)
    }
}

