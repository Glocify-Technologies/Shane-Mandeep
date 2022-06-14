//
//  TrainerProfileModel.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 09/05/22.
//

import Foundation
import SwiftUI

struct TrainerProfileModel{
    var name : String?
    var phone :String?
    var lat : Double?
    var long : Double?
    var location : String?
    var business_name : String?
    var business_phone_number :String?
    var wesbite :String?
    var services :[SelectService]?
    var sport_title_id :Array<Any>?
    var photos :Array<Any>?
    var training_place :String?
    var experience_id :String?
    var terms_conditions :UIImage?
    var certificates :UIImage?
}
