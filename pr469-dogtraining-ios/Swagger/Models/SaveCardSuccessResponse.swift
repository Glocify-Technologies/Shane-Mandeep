//
//  SaveStripeSuccessResponse.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 10/06/22.
//

import Foundation

public struct SaveCardSuccessResponse: Codable {
    var payload : [Cards]?
    let message : String?
    let result : Bool?

    enum CodingKeys: String, CodingKey {

        case payload = "payload"
        case message = "message"
        case result = "result"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        payload = try values.decodeIfPresent([Cards].self, forKey: .payload)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(Bool.self, forKey: .result)
    }

}


public struct Cards : Codable,Hashable {
//    let uuid = UUID()
    var type : String?
    var card_exp_month : String?
    var card_exp_year : String?
    public let id : String?
    var is_default : Bool?
    var card_last4 : String?
    var customer : String?
    var card_brand : String?
    var isShow = false

    enum CodingKeys: String, CodingKey {

        case type = "type"
        case card_exp_month = "card_exp_month"
        case card_exp_year = "card_exp_year"
        case id = "id"
        case is_default = "is_default"
        case card_last4 = "card_last4"
        case customer = "customer"
        case card_brand = "card_brand"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        card_exp_month = try values.decodeIfPresent(String.self, forKey: .card_exp_month)
        card_exp_year = try values.decodeIfPresent(String.self, forKey: .card_exp_year)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        is_default = try values.decodeIfPresent(Bool.self, forKey: .is_default)
        card_last4 = try values.decodeIfPresent(String.self, forKey: .card_last4)
        customer = try values.decodeIfPresent(String.self, forKey: .customer)
        card_brand = try values.decodeIfPresent(String.self, forKey: .card_brand)
    }

}


