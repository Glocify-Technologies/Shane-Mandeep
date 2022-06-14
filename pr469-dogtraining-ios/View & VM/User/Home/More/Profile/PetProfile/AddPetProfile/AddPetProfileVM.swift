//
//  AddPetProfileVM.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-13.
//

import Foundation

class AddPetProfileVM:iBSBase,ObservableObject{
    //MARK: - PROPERITY
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var petProfileText = ""
    @Published var petProfileName = ""
    @Published var petName = ""
    @Published var breed = ""
    @Published var image = ""
    @Published var petProfileId = ""
    @Published var ispetProfileShow : Bool = false
    @Published var ServicesText = ""
    @Published var ServicesId = ""
    @Published var timeId = ""
    @Published var services: [Service] = []
    @Published var getAvailabilityservices: [Time] = []
    //MARK: - FOR VALIDATION
    @Published var fullNameValidation = false
    @Published var lastNameValidation = false
    @Published var newPasswordValidation = false
    @Published var emailValidation = false
    @Published var petProfile: [PetProfile] = []
    @Published var selectPetProfile: [SelectPetProfile] = []
    @Published var selectPreferedServices: [SelectService] = []
    @Published var isServicesShow : Bool = false
    @Published var isTimeShow : Bool = false
}
//: MARK: - APINetworkRequest
extension AddPetProfileVM: LoadingIndicatorDelegate {
    func loadData(){
        getAllPetProfile { success in
            print(self.petProfile as Any)
        }
    }
    func getServices(completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        ServicesAPI.servicesGetGetAllServices(accept: "application/json", completion:{ data, error in
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
                self.services = data?.payload ?? []
                
               
                completion(true)
            }
        })
    }
    func getAllPetProfile(completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        PetProfileAPI.petProfileGetGetAllPetProfile(accept: "application/json", completion:{ data, error in
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
                self.petProfile = user
               
                completion(true)
            }
        })
    }
    
    func getAllAvailabeServices(date:String,serviceId:String,trainerId:String,completion: @escaping (_ success: Bool) -> ()) {
        
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
        BookingsAPI.GetAllAvailabeServices(accept: "application/json", date: date,serviceId:serviceId,trainerId: trainerId,completion:{ data, error in
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
                self.getAvailabilityservices = data?.payload ?? []
                
               
                completion(true)
            }
        })
    }
    
    
    func addAvailabeServices(date:String,serviceId:String,times:NSMutableArray,completion: @escaping (_ success: Bool) -> ()) {
        
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
        BookingsAPI.AddNewAvailability(accept: "application/json", date: date, serviceId: serviceId, times: times,completion:{ data, error in
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
    
    func bookingsPostAddNewBooking(trainerId: String, date: String, serviceId: String, time: String, petProfileId: String,completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        BookingsAPI.bookingsPostAddNewBooking(accept: "application/json", trainerId: trainerId, date: date, serviceId: serviceId, time: time, petProfileId:petProfileId,completion:{ data, error in
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

                completion(true)
            }
        })
      

    
    
}
}

extension AddPetProfileVM{
    func formValidationsServiceProfileInfo(selectDate:String,time:String,service:String,petProfile:String) -> Bool {
        if selectDate.isEmpty {
            alertTitle = .Failed
            alertMessage = .selectDateForBookingEmpty
            isShowAlert = true
            return false
        }
        else if service.isEmpty {
            alertTitle = .Failed
            alertMessage = .ServiceNameEmpty
            isShowAlert = true
            return false
        }else if time.isEmpty {
            alertTitle = .Failed
            alertMessage = .selectPreferredTimeForBookingEmpty
            isShowAlert = true
            return false
        }
//        else if petProfile.isEmpty {
//            alertTitle = .Failed
//            alertMessage = .selectPreferredPetProfileForBookingEmpty
//            isShowAlert = true
//            return false
//        }
        return true
    }
}
