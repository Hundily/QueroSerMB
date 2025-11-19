//
//  HomeResponse.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import Foundation

struct HomeResponse: Codable {
    let status: Status
    let data: [String: ExchangeModel]
}

struct Status: Codable {
    let error_message: String?
    let notice: String?
    let timestamp: String
    let credit_count: Int
    let elapsed: Int
    let error_code: Int
}

struct ExchangeModel: Codable {
    let logo: String?
    let id: Int?
    let countries: [String]?
    let taker_fee: Double?
    let notice: String?
    let alertLink: String?
    let slug: String?
    let fiats: [String]?
    let porStatus: Int?
    let off_ramp_direct_withdrawal: String?
    let description: String?
    let on_ramp_google_apple_pay: String?
    let is_hidden: Int?
    let alertType: Int?
    let type: String?
    let spot_volume_usd: Double?
    let date_launched: String?
    let porAuditStatus: Int?
    let off_ramp_p2p: String?
    let porSwitch: String?
    let spot_volume_last_updated: String?
    let algorithm: String?
    let weekly_visits: Int?
    let name: String?
    let walletSourceStatus: Int?
    let tags: [String]?
    let maker_fee: Double?
    let on_ramp_third_party: String?
    let on_ramp_p2p: String?
    let urls: Urls?
    let is_redistributable: Int?
    let on_ramp_card_visa_mastercard: String?
    let on_ramp_direct_deposit: String?
}

struct Urls: Codable {
    let actual: [String]
    let website: [String]
    let twitter: [String]
    let chat: [String]
    let register: [String]
    let fee: [String]
    let blog: [String]
}
