//
//  MoreVM.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-17.
//

import Foundation

class MoreVM: iBSBase, ObservableObject {
    
    //MARK: - PROPERTIES
    @Published var isShowAlert = false
    var alertMessage: String = ""
    var alertTitle: String = ""
    
    
    //MARK: - METHODS
    
    //MARK:- logout user network request
    func logOutUser(completion: @escaping (_ success: Bool) -> ()) {
        
        //check internet availability
        guard Reachability.isInternetAvailable() else {
            self.isShowAlert = true
            self.alertMessage = .NoInternet
            self.alertTitle = .Error
            completion(false)
            return
        }
        
        //API call
        AuthAPI.authGetLogout(accept: "application/json") { (response, error) in
            if error != nil {
                self.hadleErrorResponse(error) { (status, statusCode, message) in
                                       
                    switch statusCode {
                    case 401, 403:
                        // Delete current user from local
                        PersistenceController.shared.deleteUserData()
                        SwaggerClientAPI.customHeaders.removeValue(forKey: "x-access-token")
                        Authenticated.send(false)
                        completion(true)
                    default:
                        self.alertTitle = .Error
                        self.isShowAlert = true
                        self.alertMessage = "Error"
                        completion(false)
                    }
                }
            } else {
                
//                PersistenceController.shared.deleteUserData()
//                SwaggerClientAPI.customHeaders.removeValue(forKey: "x-access-token")
//                
//                //remove accessToken from local
//                iBSUserDefaults.removeAccessToken()
//                
//                //remove authontication
//                Authenticated.send(false)
                
                completion(true)
            }
        }
    }
}
