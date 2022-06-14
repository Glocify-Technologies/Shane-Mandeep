//
//  ContactUsVM.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-17.
//

import Foundation

import RappleProgressHUD

class ContactUsVM: iBSBase, ObservableObject{
    //MARK: - PROPERITY
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
        
    //MARK: - FOR VALIDATION
    @Published var emailValidation = false
}

//: MARK: - APINetworkRequest
extension ContactUsVM: LoadingIndicatorDelegate {
    func contactUs(userMessage: String, completion: @escaping (_ success: Bool) -> ()) {
        
        // Starting Loading Indicator
        startLoading()
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            // Stop Loading Indicator
            stopLoading()
            
            self.alertTitle = .Failed
            self.alertMessage = .NoInternet
            self.showAlert = true
            completion(false)
            return
        }
       
        SettingsAPI.contactUs(accept: "application/json", userMessage: userMessage, completion:  { data, error in
            // Stop Loading Indicator
            self.stopLoading()

            if error != nil {
                self.hadleErrorResponse(error) { _, _, message in
                    self.showAlert = true
                    self.alertMessage = message
                    self.alertTitle = .Error
                    completion(false)
                }
            } else {
//                guard let user = data?.payload else {
                self.showAlert = true
                self.alertMessage = data?.message ?? ""
                self.alertTitle = .Success
//                    return
//                    completion(false)
//                }
                
//                PersistenceController.shared.saveUserData(with: user)
//                AppConstant.addAccessTokenToSwaggerAPIClientcustomHeaders()
//                Authenticated.send(true)
                completion(true)
            }
        })
    }
}

//: MARK: - FormValidation
extension ContactUsVM {
    func formValidationContactUs(userMessage: String) -> Bool {
        if userMessage.isEmpty {
            alertTitle = .Failed
            alertMessage = .userMessageEmpty
            showAlert = true
            return false
        }
        return true
    }
}


