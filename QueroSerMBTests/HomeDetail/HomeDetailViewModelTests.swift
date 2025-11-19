//
//  HomeDetailViewModelTests.swift
//  QueroSerMBTests
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation
import XCTest
@testable import QueroSerMB

final class HomeDetailViewModelTests: XCTestCase {

    var sut: HomeDetailViewModel!
    var serviceMock: HomeServiceMock!
    var coordinatorMock: HomeDetailCoordinatorMock!
    var model: ExchangeModel!

    override func setUp() {
        super.setUp()

        serviceMock = HomeServiceMock()
        coordinatorMock = HomeDetailCoordinatorMock()

        model = ExchangeModel(
            logo: nil, id: 123, countries: nil, taker_fee: nil, notice: nil,
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

        sut = HomeDetailViewModel(service: serviceMock, model: model, coordinator: coordinatorMock)
    }

    override func tearDown() {
        sut = nil
        serviceMock = nil
        coordinatorMock = nil
        model = nil
        super.tearDown()
    }

    // MARK: - Teste Sucesso
    func test_fetchCoins_success_shouldReturnCoinList() {

        let coins = [
            CoinModel(walletAddress: "abc", balance: 1.0,
                      platform: .init(cryptoID: 1, priceUsd: 1.0, symbol: "BTC", name: "Bitcoin"),
                      currency: .init(cryptoID: 1, priceUsd: 1.0, symbol: "USD", name: "Dollar"))
        ]

        let response = HomeDetailResponse(status: nil, data: coins)

        serviceMock.fetchCoinsResult = .success(response)

        let exp = expectation(description: "state loaded")

        sut.state.bind { state in
            if case .loaded(let result) = state {
                XCTAssertEqual(result?.count, 1)
                XCTAssertEqual(result?.first?.platform.name, "Bitcoin")
                exp.fulfill()
            }
        }

        sut.fetchCoins()
        wait(for: [exp], timeout: 1.0)
    }

    // MARK: - Teste Erro
    func test_fetchCoins_failure_shouldReturnError() {

        serviceMock.fetchCoinsResult = .failure(.badRequest)

        let exp = expectation(description: "state error")

        sut.state.bind { state in
            if case .error(let error) = state {
                XCTAssertEqual(error as? MBNetworkBaseError, .badRequest)
                exp.fulfill()
            }
        }

        sut.fetchCoins()
        wait(for: [exp], timeout: 1.0)
    }

    // MARK: - Teste closedView
    func test_closedView_shouldCallCoordinator() {
        sut.closedView()
        XCTAssertTrue(coordinatorMock.closeCalled)
    }

    // MARK: - Teste getDetail
    func test_getDetail_shouldReturnModel() {
        let returned = sut.getDetail()
        XCTAssertEqual(returned.id, 123)
    }
}
