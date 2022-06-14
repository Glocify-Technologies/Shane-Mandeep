//
//  GetTrainerMethodsREsponse.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 02/06/22.
//

import Foundation
public struct GetTrainerMethodsResponse: Codable {

    public var message: String?
    public var result: Bool?
    public var payload: Method?
    public var payloads: String?

//    enum CodingKeys: String, CodingKey {
//
//        case id = "message"
//        case result = "result"
//        case payload = "payload"
//        case payloads = "payload"
//    }
    
    public init(message: String?, result: Bool?, payload: Method?,payloads:String) {
        self.message = message
        self.result = result
        self.payload = payload
        self.payloads = payloads
    }


}
public struct Method : Codable,Hashable {
    var id : String?
    var email : String?
  
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case email = "email"
//    }
//
//    public init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
//    }

}
