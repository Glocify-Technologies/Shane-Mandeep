//
//  GetAvailabilityModel.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 30/05/22.
//

import Foundation
struct GetAvailability : Codable {
    let id : Int?
    let trainer_id : String?
    let date : String?
    let created_at : String?
    let updated_at : String?
    let service_id : String?
    let time : [Time]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case trainer_id = "trainer_id"
        case date = "date"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case service_id = "service_id"
        case time = "time"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        trainer_id = try values.decodeIfPresent(String.self, forKey: .trainer_id)
        date = try values.decodeIfPresent(String.self, forKey: .date)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        service_id = try values.decodeIfPresent(String.self, forKey: .service_id)
        time = try values.decodeIfPresent([Time].self, forKey: .time)
    }

}

struct Time : Codable,Hashable{
    let uuid = UUID()
    var id : Int?
    var availability_id : String?
    var start_time : String?
    var end_time : String?
    var created_at : String?
    var updated_at : String?
    
    enum CodingKeys: String, CodingKey {

        case id = "id"
        case availability_id = "availability_id"
        case start_time = "start_time"
        case end_time = "end_time"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        availability_id = try values.decodeIfPresent(String.self, forKey: .availability_id)
        start_time = try values.decodeIfPresent(String.self, forKey: .start_time)
        end_time = try values.decodeIfPresent(String.self, forKey: .end_time)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }
}


public struct SelectTime : Codable,Hashable{
    public var id = UUID()
    var start_time : String?
    var end_time : String?
    
    
   
}
