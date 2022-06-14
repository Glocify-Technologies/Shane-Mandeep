//
// ProfileTrainerProfileSetupResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation

public struct ProfileTrainerProfileSetupResponse: Codable {

    public var message: String?
    public var result: Bool?
    public var payload: Trainer?

    public init(message: String?, result: Bool?, payload: Trainer?) {
        self.message = message
        self.result = result
        self.payload = payload
    }
}

