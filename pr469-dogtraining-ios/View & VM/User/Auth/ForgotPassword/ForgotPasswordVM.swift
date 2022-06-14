//
//  ForgotPasswordVM.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-24.
//

import Foundation
import RappleProgressHUD

class ForgotPasswordVM: iBSBase, ObservableObject{
    //MARK: - PROPERITY
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var methods:Method?
    @Published var getTrainerMethodsResponse:GetTrainerMethodsResponse?
    //MARK: - FOR VALIDATION
    @Published var emailValidation = false
    @Published var userEmail: String = ""
    @Published var userId: String = ""
}

//: MARK: - APINetworkRequest
extension ForgotPasswordVM: LoadingIndicatorDelegate {
    func forgotPassword(email: String, completion: @escaping (_ success: Bool) -> ()) {
        
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
       
        ForgotPasswordAPI.forgotpasswordPostResetPassword(accept: "application/json", email: email, completion: { data, error in
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
    
    

    func getTrainersPaymentMethods(completion: @escaping (_ success: Bool, _ data:SuccessResponse?) -> ()) {
        
        // Starting Loading Indicator
        startLoading()
        
        // Check internet connection
        guard Reachability.isInternetAvailable() else {
            // Stop Loading Indicator
            stopLoading()
            
            self.alertTitle = .Failed
            self.alertMessage = .NoInternet
            self.showAlert = true
            completion(false,nil)
            return
        }
       
        PaymentAPI.getTrainerPaymentMethods(accept: "application/json",completion: { data, error in
            // Stop Loading Indicator
            self.stopLoading()

            if error != nil {
                self.hadleErrorResponse(error) { _, _, message in
                    self.showAlert = true
                    self.alertMessage = message
                    self.alertTitle = .Error
                    completion(false,nil)
                }
            } else {
                self.showAlert = true
                self.alertMessage = data?.message ?? ""
                self.alertTitle = .Success
                if data?.payload == ""{
                   
                }else{
                    if let d = data?.payload {
                        var met:Method?
                        
                        if let email = (d.value as! NSDictionary).value(forKey: "email"){
                            if let id = (d.value as! NSDictionary).value(forKey: "id"){
                                self.userId = "\(id)"
                             }
                            
                            self.userEmail = "\(email)"
                         }
                        met = Method(id: self.userId, email: self.userEmail)
                        self.methods = met
                        print(met as Any)
                        print(self.methods as Any)
                    }
                   
                }

                completion(true,data)
            }
        })
    }
    
    func deletTrainerMethods(paymentMethodId:String,completion: @escaping (_ success: Bool) -> ()) {
        
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
        PaymentAPI.deleteTrainerPaymentMethod(accept: "application/json", paymentMethodId: paymentMethodId,completion: { data, error in
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

                completion(true)
            }
        })
    }
}

//: MARK: - FormValidation
extension ForgotPasswordVM {
    func formValidationForgotPassword(email: String) -> Bool {
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
        }
        return true
    }
}


