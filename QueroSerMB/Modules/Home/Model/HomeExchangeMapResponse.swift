//
//  ExchangeList.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 19/11/25.
//

struct HomeExchangeMapResponse: Codable {
    let status: Status?
    let data: [ExchangeListModel]
}

// MARK: - Datum
struct ExchangeListModel: Codable {
    let id: Int
    let name, slug: String
    let isActive, isListed, isRedistributable: Int
    let firstHistoricalData, lastHistoricalData: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case isActive = "is_active"
        case isListed = "is_listed"
        case isRedistributable = "is_redistributable"
        case firstHistoricalData = "first_historical_data"
        case lastHistoricalData = "last_historical_data"
    }
}
