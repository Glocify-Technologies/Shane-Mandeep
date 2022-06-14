//
//  GetAvailabilityResponse.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 30/05/22.
//

import Foundation
public struct GetAvailabilityResponse : Codable {
    let payload : [Time]?
    let message : String?
    let result : Bool?

    enum CodingKeys: String, CodingKey {

        case payload = "payload"
        case message = "message"
        case result = "result"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        payload = try values.decodeIfPresent([Time].self, forKey: .payload)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(Bool.self, forKey: .result)
    }

}
