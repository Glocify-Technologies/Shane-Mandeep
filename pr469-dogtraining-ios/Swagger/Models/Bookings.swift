//
//  Bookings.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 27/05/22.
//

import Foundation
public struct BookingListResponse:Codable {
    
    let payload : [Booking]?
    let paginator : Paginator?
    let message : String?
    let result : Bool?

    enum CodingKeys: String, CodingKey {

        case payload = "payload"
        case paginator = "paginator"
        case message = "message"
        case result = "result"
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        payload = try values.decodeIfPresent([Booking].self, forKey: .payload)
        paginator = try values.decodeIfPresent(Paginator.self, forKey: .paginator)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        result = try values.decodeIfPresent(Bool.self, forKey: .result)
    }

}
//struct Booking : Codable {
//    let id : Int?
//    let user_id : String?
//    let trainer_id : String?
//    let date : String?
//    let service_id : String?
//    let time : String?
//    let pet_profile_id : String?
//    let status : String?
//    let created_at : String?
//    let updated_at : String?
//    let is_paid : String?
//    let pet_profiles : String?
//    let users : Users?
//    let trainer : Trainer?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case user_id = "user_id"
//        case trainer_id = "trainer_id"
//        case date = "date"
//        case service_id = "service_id"
//        case time = "time"
//        case pet_profile_id = "pet_profile_id"
//        case status = "status"
//        case created_at = "created_at"
//        case updated_at = "updated_at"
//        case is_paid = "is_paid"
//        case pet_profiles = "pet_profiles"
//        case users = "users"
//        case trainer = "trainer"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(Int.self, forKey: .id)
//        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
//        trainer_id = try values.decodeIfPresent(String.self, forKey: .trainer_id)
//        date = try values.decodeIfPresent(String.self, forKey: .date)
//        service_id = try values.decodeIfPresent(String.self, forKey: .service_id)
//        time = try values.decodeIfPresent(String.self, forKey: .time)
//        pet_profile_id = try values.decodeIfPresent(String.self, forKey: .pet_profile_id)
//        status = try values.decodeIfPresent(String.self, forKey: .status)
//        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
//        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
//        is_paid = try values.decodeIfPresent(String.self, forKey: .is_paid)
//        pet_profiles = try values.decodeIfPresent(String.self, forKey: .pet_profiles)
//        users = try values.decodeIfPresent(Users.self, forKey: .users)
//        trainer = try values.decodeIfPresent(Trainer.self, forKey: .trainer)
//    }
//
//}
//struct Users : Codable {
//    let id : String?
//    let uuid : String?
//    let name : String?
//    let email : String?
//    let phone : String?
//    let avatar_url : String?
//    let timezone : String?
//    let user_role : String?
//    let age : String?
//    let location : String?
//    let latitude : String?
//    let longitude : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case id = "id"
//        case uuid = "uuid"
//        case name = "name"
//        case email = "email"
//        case phone = "phone"
//        case avatar_url = "avatar_url"
//        case timezone = "timezone"
//        case user_role = "user_role"
//        case age = "age"
//        case location = "location"
//        case latitude = "latitude"
//        case longitude = "longitude"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        id = try values.decodeIfPresent(String.self, forKey: .id)
//        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
//        name = try values.decodeIfPresent(String.self, forKey: .name)
//        email = try values.decodeIfPresent(String.self, forKey: .email)
//        phone = try values.decodeIfPresent(String.self, forKey: .phone)
//        avatar_url = try values.decodeIfPresent(String.self, forKey: .avatar_url)
//        timezone = try values.decodeIfPresent(String.self, forKey: .timezone)
//        user_role = try values.decodeIfPresent(String.self, forKey: .user_role)
//        age = try values.decodeIfPresent(String.self, forKey: .age)
//        location = try values.decodeIfPresent(String.self, forKey: .location)
//        latitude = try values.decodeIfPresent(String.self, forKey: .latitude)
//        longitude = try values.decodeIfPresent(String.self, forKey: .longitude)
//    }
//
//}
