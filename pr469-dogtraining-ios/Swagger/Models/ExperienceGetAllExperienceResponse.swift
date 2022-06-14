//
// ExperienceGetAllExperienceResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ExperienceGetAllExperienceResponse: Codable {

    public var message: String?
    public var result: Bool?
    public var payload: [Experience]?
    public var paginator: Paginator?

    public init(message: String?, result: Bool?, payload: [Experience]?, paginator: Paginator?) {
        self.message = message
        self.result = result
        self.payload = payload
        self.paginator = paginator
    }


}

