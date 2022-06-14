//
//  SignUpVM.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-22.
//

import Foundation
import RappleProgressHUD

class SignUpVM: iBSBase, ObservableObject{
    //MARK: - PROPERITY
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    
    //MARK: - FOR VALIDATION
    @Published var emailValidation = false
}

//: MARK: - APINetworkRequest
extension SignUpVM: LoadingIndicatorDelegate {
    func stripeConnect(completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        PaymentAPI.stripeConnect(accept: "application/json",completion: { data, error in
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
                guard let user = data?.payload else {
                    self.showAlert = true
                    self.alertMessage = .MismatchingData
                    self.alertTitle = .Error
                    return
                    completion(false)
                }
                UserDefaults.standard.set("\(user)", forKey: "stripeUrl")
                UserDefaults.standard.synchronize()
//                self.stripeUrl = "\(user)"
                // Read access token from readable object
              
                completion(true)
            }
        })
    }
    func signup(userRole: String, email: String, password: String, completion: @escaping (_ success: Bool) -> ()) {
        
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
        
        AuthAPI.authPostRegister(accept: "application/json", deviceId: ApplicationServiceProvider.shared.deviceId, deviceType: ApplicationServiceProvider.shared.deviceType, userRole: userRole, email: email, password: password, devicePushToken: "", completion: { data, error in
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
                guard let user = data?.payload else {
                    self.showAlert = true
                    self.alertMessage = .MismatchingData
                    self.alertTitle = .Error
                    return
                    completion(false)
                }
                // Read access token from readable object
                let accessToken: String = (user.accessToken ?? "")
                
                // Set access token to user defaults
                iBSUserDefaults.setAccessToken(token: accessToken)
                
                
                PersistenceController.shared.saveUserData(with: user)
                AppConstant.addAccessTokenToSwaggerAPIClientcustomHeaders()
                //                Authenticated.send(true)
                completion(true)
            }
        })
    }
}

//: MARK: - FormValidation
extension SignUpVM {
    func formValidationSignUp(email: String, password: String, termsCheck: Bool) -> Bool {
        if email.isEmpty {
            alertTitle = .Failed
            alertMessage = .EmailEmpty
            showAlert = true
            return false
        } else if !Validators().isValidEmailValidator(value: email).isSuccess {
            alertTitle = .Failed
            alertMessage = .InvalidEmail
            showAlert = true
            return false
        } else if password.isEmpty {
            alertTitle = .Failed
            alertMessage = .PasswordEmpty
            showAlert = true
            return false
        } else if !termsCheck {
            alertTitle = .Failed
            alertMessage = .termsCheck
            showAlert = true
            return false
        }
        return true
    }
}
