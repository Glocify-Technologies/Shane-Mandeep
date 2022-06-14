//
// Setting.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Setting: Codable {

    public var _id: Int?
    public var key: String?
    public var value: String?
    public var createdAt: String?
    public var updatedAt: String?

    public init(_id: Int?, key: String?, value: String?, createdAt: String?, updatedAt: String?) {
        self._id = _id
        self.key = key
        self.value = value
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case key
        case value
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }


}

