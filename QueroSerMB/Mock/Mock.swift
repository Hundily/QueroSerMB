//
//  Mock.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

struct Mock {
    static let exchange = ExchangeModel(
        logo: "https://s2.coinmarketcap.com/static/img/exchanges/64x64/270.png",
        id: 270,
        countries: ["BR", "US"],
        taker_fee: 0.04,
        notice: "",
        alertLink: "",
        slug: "binance",
        fiats: ["USD", "EUR", "BRL"],
        porStatus: 1,
        off_ramp_direct_withdrawal: "USD, EUR",
        description: "Mocked description for testing.",
        on_ramp_google_apple_pay: "USD, BRL",
        is_hidden: 0,
        alertType: 1,
        type: "exchange",
        spot_volume_usd: 123456789.0,
        date_launched: "2017-07-14T00:00:00.000Z",
        porAuditStatus: 0,
        off_ramp_p2p: "BRL, USD",
        porSwitch: nil,
        spot_volume_last_updated: "2025-11-18T12:10:16.831Z",
        algorithm: nil,
        weekly_visits: 999999,
        name: "Binance",
        walletSourceStatus: 0,
        tags: ["CEX", "Top Tier"],
        maker_fee: 0.02,
        on_ramp_third_party: nil,
        on_ramp_p2p: nil,
        urls: Urls(
            actual: ["https://www.binance.com"],
            website: ["https://www.binance.com"],
            twitter: ["https://twitter.com/binance"],
            chat: ["https://t.me/binanceexchange"],
            register: ["https://accounts.binance.com"],
            fee: ["https://www.binance.com/fee"],
            blog: []
        ),
        is_redistributable: 1,
        on_ramp_card_visa_mastercard: nil,
        on_ramp_direct_deposit: nil
    )
}

enum MockError: Error {
    case generic
}
