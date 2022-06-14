//
//  TrainerEditProfileVM.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-14.
//

import Foundation

class TrainerEditProfileVM:ObservableObject{
    //MARK: - PROPERITY
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var phoneCountryCode = ""
    @Published var businessPhoneCountryCode = ""
    @Published var fullNameText = ""
    @Published var email = ""
    @Published var businessName = ""
    @Published var website = ""
    @Published var jobTrainingPlace = ""
    @Published var phoneText = ""
    @Published var businessPhoneText = ""
    
    
    //MARK: - FOR VALIDATION
    @Published var fullNameValidation = false
    @Published var lastNameValidation = false
    @Published var newPasswordValidation = false
    @Published var emailValidation = false
    
    @Published var services: [Service] = []
    @Published var sportTitle: [SportTitle] = []
    @Published var selectServices: [SelectService] = []
    @Published var experience: [Experience] = []
    @Published var getTrainer:Trainer?
}
