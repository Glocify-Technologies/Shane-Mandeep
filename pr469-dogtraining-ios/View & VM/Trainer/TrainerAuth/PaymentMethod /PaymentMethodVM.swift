//
//  PaymentMethodVM.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-02.
//

import Foundation
import Stripe
class PaymentMethodVM:iBSBase, ObservableObject{
    //MARK: - PROPERITY
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var countryCode = ""
    @Published var countryFlag = ""
    @Published var CardNumber = ""
    @Published var selectedDate = ""
    @Published var Expdate = Date()
    @Published var SelectCountry = ""
    @Published var CVC = ""
    @Published var countries: [String] = []
    @Published var CardNumberValidation = false
    @Published var CardExpDateValidation = false
    @Published var stripeUrl = ""
    @Published var Cards:[Cards] = []
//    @Published var Expdate: Date? = nil
    @Published var dateFormatter: DateFormatter = {
            let df = DateFormatter()
//            df.dateStyle = .medium
        df.dateFormat = "MM/YY"
            return df
        }()
    
   
    
   
    

}
extension PaymentMethodVM: LoadingIndicatorDelegate {
    
    func createStripeToken(stripeCardParams:STPCardParams,completion: @escaping (_ success: Bool, _ token:String) -> ()) {
        startLoading()
        let config = STPPaymentConfiguration.shared
        let stpApiClient = STPAPIClient.init(configuration: config)
        stpApiClient.createToken(withCard: stripeCardParams) { (token, error) in

        if error == nil {

        //Success
        DispatchQueue.main.async {
        print(token!.tokenId)
            PaymentAPI.addCardOnStripe(accept: "application/json", tokenID:token!.tokenId ,custmerId:"cus_Lqh2RlFoREAIR7" ,completion: { data, error in
                if error == nil{
                    completion(true,"\(data!.id ?? "")")
                }
            })
        
         }
        } else {
            completion(true,"")
        //failed
        print("Failed")
        }
        }
    }
    
    //converting into token
    //card parameters
    func getPaymentMethods(completion: @escaping (_ success: Bool) -> ()) {
        
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
       
        PaymentAPI.getPaymentMethods(accept: "application/json",completion: { data, error in
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
                guard let data = data?.payload else{
                self.isShowAlert = true
                self.alertMessage = data?.message ?? ""
                self.alertTitle = .Success
                    return
                    completion(false)
                }
                self.Cards = data
                completion(true)
            }
        })
    }
    
    
    func addNewPaymentMethod(paymentMethodId: String, isDefaultMethod:String ,completion: @escaping (_ success: Bool) -> ()) {
        
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
        PaymentAPI.addNewPaymentMethod(accept: "application/json", paymentMethodId: paymentMethodId, isDefaultMethod: isDefaultMethod,completion: { data, error in
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
//                guard let user = data?.payload else {
////                    self.isShowAlert = true
////                    self.alertMessage = .MismatchingData
////                    self.alertTitle = .Error
//                    return
//                    completion(false)
//                }
                // Read access token from readable object
              
                completion(true)
            }
        })
    }
 
    
    func payNow(paymentMethodId: String, bookingId:String,amount:String ,completion: @escaping (_ success: Bool) -> ()) {
        
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
        PaymentAPI.PayNow(accept: "application/json", paymentMethodId: paymentMethodId, bookingId: bookingId, amount: amount,completion: { data, error in
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
//                guard let user = data?.payload else {
////                    self.isShowAlert = true
////                    self.alertMessage = .MismatchingData
////                    self.alertTitle = .Error
//                    return
//                    completion(false)
//                }
                // Read access token from readable object
              
                completion(true)
            }
        })
    }
}
