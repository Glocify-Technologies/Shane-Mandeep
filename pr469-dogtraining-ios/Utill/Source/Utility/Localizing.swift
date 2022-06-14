//
//  Localizing.swift
//  iBaseSwift
//
//  Created by Dushan Saputhanthri on 21/1/20.
//  Copyright © 2020 Elegant Media Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

public class Localizing {
    fileprivate func NSLocalizedString(_ key: String) -> String {
        return Foundation.NSLocalizedString(key, comment: "")
    }
}

extension String {
    
    static let Error = NSLocalizedString("Error", comment: "")
    static let Incomplete = NSLocalizedString("Incomplete", comment: "")
    static let Success = NSLocalizedString("Success", comment: "")
    static let Failed = NSLocalizedString("Failed", comment: "")
    static let selectDateForBookingEmpty = NSLocalizedString("Please select date.", comment: "")
    static let selectPreferredTimeForBookingEmpty = NSLocalizedString("Please select your preferred time.", comment: "")
    static let selectPreferredPetProfileForBookingEmpty = NSLocalizedString("Please select your pet profile.", comment: "")
    static let MissingData = NSLocalizedString("Missing data in the request.", comment: "")
    static let NoInternet = NSLocalizedString("Internet connection offline.", comment: "")
    static let ServiceNameEmpty = NSLocalizedString("Please select service.", comment: "")
    static let imageEmpty = NSLocalizedString("Please select image.", comment: "")
    static let certificatesEmpty = NSLocalizedString("Please select certificates.", comment: "")
    static let NameEmpty = NSLocalizedString("Please enter name.", comment: "")
    static let FullNameEmpty = NSLocalizedString("Please enter fullname.", comment: "")
    static let FirstNameEmpty = NSLocalizedString("Please enter firstname.", comment: "")
    static let LastNameEmpty = NSLocalizedString("Please enter lastname.", comment: "")
    static let UsernameEmpty = NSLocalizedString("Please enter username.", comment: "")
    static let EmailEmpty = NSLocalizedString("Please enter email address.", comment: "")
    static let userMessageEmpty = NSLocalizedString("Please enter message.", comment: "")
    static let PasswordEmpty = NSLocalizedString("Please enter password.", comment: "")
    static let termsCheck = NSLocalizedString("Please check terms & condition.", comment: "")
    static let CountryCodeEmpty = NSLocalizedString("Please enter country code.", comment: "")
    static let countryCodePhoneEmpty = NSLocalizedString("Please enter country code.", comment: "")
    static let PhoneEmpty = NSLocalizedString("Please enter phone number.", comment: "")
    static let CurrentPasswordEmpty = NSLocalizedString("Please enter current password.", comment: "")
    static let NewPasswordEmpty = NSLocalizedString("Please enter new password.", comment: "")
    static let TrainingPlaceEmpty = NSLocalizedString("Please enter training place.", comment: "")
    static let TrainingExpEmpty = NSLocalizedString("Please enter training experience.", comment: "")
    static let DogSportsTitleEmpty = NSLocalizedString("Please enter dog sports title.", comment: "")
    static let TermConEmpty = NSLocalizedString("Please enter terms & conditions.", comment: "")
    static let BusinessNameEmpty = NSLocalizedString("Please enter business name.", comment: "")
    static let passwordOldEmpty = NSLocalizedString("Please enter old password.", comment: "")
    static let newPssEmpty = NSLocalizedString("Please enter new passowrd.", comment: "")
    static let confirmPassEmpty = NSLocalizedString("Please enter confirm password.", comment: "")
    static let BusinessLocationEmpty = NSLocalizedString("Please enter business location.", comment: "")
    static let BusinessPhoneNumberEmpty = NSLocalizedString("Please enter business phone number.", comment: "")
    static let WebsiteEmpty = NSLocalizedString("Please enter website.", comment: "")
    static let ConfirmPasswordEmpty = NSLocalizedString("Please enter confirm password.", comment: "")
    static let RoleNotSet = NSLocalizedString("Please select role.", comment: "")
    static let InvalidVerificationCode = NSLocalizedString("Invalid verification code.", comment: "")
    
    static let InvalidUsername = NSLocalizedString("Invalid username.", comment: "")
    static let InvalidEmail = NSLocalizedString("Please enter a valid email address.", comment: "")
    static let InvalidCountryCode = NSLocalizedString("Invalid counrty code.", comment: "")
    static let InvalidPhone = NSLocalizedString("Invalid phone number.", comment: "")
    static let IncompletePhone = NSLocalizedString("Incomplete phone number.", comment: "")
    static let InvalidUrl = NSLocalizedString("Invalid url.", comment: "")
    static let InvalidPassword = NSLocalizedString("Invalid password.", comment: "")
    static let MismatchingPasswords = NSLocalizedString("Passwords do not match.", comment: "")
    static let MismatchingNewPasswords = NSLocalizedString("New Passwords do not match.", comment: "")
    static let MismatchingData = NSLocalizedString("Mismatching Data", comment: "")
    
    
    static let ShortPassword = NSLocalizedString("Password should be at least \(CharacterCounts.passwordMinimumCharacterCount) characters.", comment: "")
    static let NewAndCurrentPasswordsMatched = NSLocalizedString("Current password and new password can not be same.", comment: "")
    
}
