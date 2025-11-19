//
//  HomeDetailResponse.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 19/11/25.
//

import Foundation

struct HomeDetailResponse: Codable {
    let status: Status?
    let data: [CoinModel]
}

// MARK: - CoinModel
struct CoinModel: Codable {
    let walletAddress: String
    let balance: Double
    let platform, currency: Currency

    enum CodingKeys: String, CodingKey {
        case walletAddress = "wallet_address"
        case balance, platform, currency
    }
}

// MARK: - Currency
struct Currency: Codable {
    let cryptoID: Int
    let priceUsd: Double?
    let symbol, name: String

    enum CodingKeys: String, CodingKey {
        case cryptoID = "crypto_id"
        case priceUsd = "price_usd"
        case symbol, name
    }
}
