//
// PetProfileDeletePetProfileResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct PetProfileDeletePetProfileResponse: Codable {

    public var message: String?
    public var result: Bool?
    public var payload: PetProfile?

    public init(message: String?, result: Bool?, payload: PetProfile?) {
        self.message = message
        self.result = result
        self.payload = payload
    }


}

