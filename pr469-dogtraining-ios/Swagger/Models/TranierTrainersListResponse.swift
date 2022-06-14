//
// TranierTrainersListResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct TranierTrainersListResponse: Codable {

    public var message: String?
    public var result: Bool?
    public var payload: [Trainer]?
    public var paginator: Paginator?

    public init(message: String?, result: Bool?, payload: [Trainer]?, paginator: Paginator?) {
        self.message = message
        self.result = result
        self.payload = payload
        self.paginator = paginator
    }


}
