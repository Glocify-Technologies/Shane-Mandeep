//
//  SignUpVerificationVM.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-23.
//

import Foundation

class SignUpVerificationVM : iBSBase, ObservableObject{
    @Published var codeone = ""
    @Published var codetwo = ""
    @Published var codethree = ""
    @Published var codefour = ""
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
}
//: MARK: - APINetworkRequest
extension SignUpVerificationVM: LoadingIndicatorDelegate {
    func verifyVerificationCode(code:Int,completion: @escaping (_ success: Bool) -> ()) {
        
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
        AuthAPI.authGetEmailVerification(code: code,accept: "application/json", completion: { data, error in
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
//                    self.showAlert = true
//                    self.alertMessage = data?.message ?? ""
//                    self.alertTitle = .Success
                
                // Read access token from readable object
                
                // Set access token to user defaults
                completion(true)
            }
        })
    }
    
    func verification(completion: @escaping (_ success: Bool) -> ()) {
        
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
        
        AuthAPI.authGetResendVerificationCode(accept: "application/json", completion: { data, error in
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
                    self.showAlert = true
                    self.alertMessage = data?.message ?? ""
                    self.alertTitle = .Success
                
                // Read access token from readable object
                
                // Set access token to user defaults
                completion(true)
            }
        })
    }
}
//: MARK: - FormValidation
extension SignUpVerificationVM {
    func formValidationVerification() -> Bool {
        if codeone.isEmpty {
            alertTitle = .Failed
            alertMessage = .InvalidVerificationCode
            showAlert = true
            return false
        }else if codetwo.isEmpty {
            alertTitle = .Failed
            alertMessage = .InvalidVerificationCode
            showAlert = true
            return false
        } else if codethree.isEmpty {
            alertTitle = .Failed
            alertMessage = .InvalidVerificationCode
            showAlert = true
            return false
        }
        else if codefour.isEmpty {
            alertTitle = .Failed
            alertMessage = .InvalidVerificationCode
            showAlert = true
            return false
        }
        return true
    }
}
