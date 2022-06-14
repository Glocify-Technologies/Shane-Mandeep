//
//  ChangePasswordVM.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-24.
//

import Foundation

class ChangePasswordVM:iBSBase,ObservableObject{
    //MARK: - PROPERITY
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    @Published var fullNameText = ""
    @Published var currentPassword = ""
    @Published var newPassword = ""
    @Published var confirmPassword = ""
    @Published var phoneCountryCode = ""
    @Published var businessPhoneCountryCode = ""
    @Published var phoneText = ""
    @Published var email = ""
    @Published var businessNameText = ""
    @Published var businessLocationText = ""
    @Published var businessPhoneText = ""
  
    
    @Published var WebsiteText = ""
    @Published var ServicesText = ""
    @Published var image = ""
    
    
    //MARK: - FOR VALIDATION
    @Published var fullNameValidation = false
    @Published var lastNameValidation = false
    @Published var newPasswordValidation = false
    @Published var emailValidation = false

}

extension ChangePasswordVM:LoadingIndicatorDelegate{
    func changePassword(password: String,confirmPass: String,newPass:String, completion: @escaping (_ success: Bool) -> ()) {
        
        // Starting Loading Indicator
        startLoading()
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            // Stop Loading Indicator
            stopLoading()
            
            self.alertTitle = .Failed
            self.alertMessage = .NoInternet
            self.isShowAlert = true
            completion(false)
            return
        }
      
        AuthAPI.authPostUpdatePassword(password: newPass, currentPassword: password, passwordConfirmation: confirmPass, accept: "application/json",completion: { data, error in
            // Stop Loading Indicator
            self.stopLoading()
            
            if error != nil {
                self.hadleErrorResponse(error) { _, _, message in
                    self.isShowAlert = true
                    self.alertMessage = message
                    self.alertTitle = .Error
                    completion(false)
                }
            } else {
                guard let user = data?.payload else {
                    self.isShowAlert = true
                    self.alertMessage = .MismatchingData
                    self.alertTitle = .Error
                    return
                    completion(false)
                }
                // Read access token from readable object
              
                completion(true)
            }
        })
    }
}
extension ChangePasswordVM {
    func formValidationProfileInfo(password: String,newPass:String,confirmPass: String) -> Bool {
        if password.isEmpty {
            alertTitle = .Failed
            alertMessage = .passwordOldEmpty
            isShowAlert = true
            return false
        } else if newPass.isEmpty {
            alertTitle = .Failed
            alertMessage = .newPssEmpty
            isShowAlert = true
            return false
        }else if confirmPass.isEmpty {
            alertTitle = .Failed
            alertMessage = .ConfirmPasswordEmpty
            isShowAlert = true
            return false
        }
        return true
    }
}
