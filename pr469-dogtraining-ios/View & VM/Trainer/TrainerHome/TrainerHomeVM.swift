//
//  TrainerHomeVM.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-02.
//

import Foundation
class TrainerHomeVM:iBSBase,ObservableObject{
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var allBooking:[Booking]?
    @Published var getPaginator:Paginator?
    @Published var searchText = ""
    var trainerListFull = false
    // Tracks last page loaded. Used to load next page (current + 1)
    var currentPage = 0
    var currentConfirmPage = 0
    // Limit of records per page. (Only if backend supports, it usually does)
    let perPage = 15
}

    extension TrainerHomeVM:LoadingIndicatorDelegate{
        func getBookingList( searchText: String, page: Int, perPage:Int ,completion: @escaping (_ success: Bool) -> ()) {
            
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
          
            BookingsAPI.getBookingList(accept: "application/json", q: searchText, page: page, perPage: perPage,completion:{ data, error in
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
                    self.currentPage += 1
//                    if (data?.payload?.count ?? 0) < perPage {
//                            self.trainerListFull = true
//                        }
                    if data?.payload?.count != perPage {
                        self.trainerListFull = true
                    }
                    guard let paginator = data?.paginator else {return}
                    self.getPaginator = paginator
                    guard var trainer = self.allBooking else{
                        self.allBooking = user
                        return
                    }
                    
                    trainer += user
                    self.allBooking?.removeAll()
                    self.allBooking = trainer
                    print(print("vms.allTrainer?.count",self.allBooking?.count))
                    
//                    self.allTrainer?.append(contentsOf: user)// = user
                    
                    // Read access token from readable object
                    completion(true)
                }
            })
          

        
        
    }
        
        
        func getBookingListSearch(searchText: String, page: Int, perPage:Int ,completion: @escaping (_ success: Bool) -> ()) {
            
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
          
            BookingsAPI.getBookingList(accept: "application/json", q: searchText, page: page, perPage: perPage,completion:{ data, error in
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
                    self.currentPage += 1
//                    if (data?.payload?.count ?? 0) < perPage {
//                            self.trainerListFull = true
//                        }
//                    if data?.payload?.count != perPage {
//                        self.trainerListFull = true
//                    }
//                    guard let paginator = data?.paginator else {return}
//                    self.getPaginator = paginator
//                    guard var trainer = self.allTrainer else{
//                        self.allTrainer = user
//                        return
//                    }
//
//                    trainer += user
//                    self.allTrainer?.removeAll()
                    self.allBooking = user
                    print(print("vms.allTrainer?.count",self.allBooking?.count))
                    
//                    self.allTrainer?.append(contentsOf: user)// = user
                    
                    // Read access token from readable object
                    completion(true)
                }
            })
          

        
        
    }
        
        func getConfirmBookingList( searchText: String, page: Int, perPage:Int ,completion: @escaping (_ success: Bool) -> ()) {
            
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
          
            BookingsAPI.getConfirmBookingList(accept: "application/json", q: searchText, page: page, perPage: perPage,completion:{ data, error in
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
                    self.currentConfirmPage += 1
//                    if (data?.payload?.count ?? 0) < perPage {
//                            self.trainerListFull = true
//                        }
                    if data?.payload?.count != perPage {
                        self.trainerListFull = true
                    }
                    guard let paginator = data?.paginator else {return}
                    self.getPaginator = paginator
                    guard var trainer = self.allBooking else{
                        self.allBooking = user
                        return
                    }
                    
                    trainer += user
                    self.allBooking?.removeAll()
                    self.allBooking = trainer
                    print(print("vms.allTrainer?.count",self.allBooking?.count))
                    
//                    self.allTrainer?.append(contentsOf: user)// = user
                    
                    // Read access token from readable object
                    completion(true)
                }
            })
          

        
        
    }
        
        
        func getConfirmBookingListSearch(searchText: String, page: Int, perPage:Int ,completion: @escaping (_ success: Bool) -> ()) {
            
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
          
            BookingsAPI.getBookingList(accept: "application/json", q: searchText, page: page, perPage: perPage,completion:{ data, error in
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
                    self.currentConfirmPage += 1
//                    if (data?.payload?.count ?? 0) < perPage {
//                            self.trainerListFull = true
//                        }
//                    if data?.payload?.count != perPage {
//                        self.trainerListFull = true
//                    }
//                    guard let paginator = data?.paginator else {return}
//                    self.getPaginator = paginator
//                    guard var trainer = self.allTrainer else{
//                        self.allTrainer = user
//                        return
//                    }
//
//                    trainer += user
//                    self.allTrainer?.removeAll()
                    self.allBooking = user
                    print(print("vms.allTrainer?.count",self.allBooking?.count))
                    
//                    self.allTrainer?.append(contentsOf: user)// = user
                    
                    // Read access token from readable object
                    completion(true)
                }
            })
          

        
        
    }
       
        
        func acceptBooking(id:String ,completion: @escaping (_ success: Bool) -> ()) {
            
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
            BookingsAPI.acceptBooking(accept: "application/json", id: id,completion:{ data, error in
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
        
        func cancelBooking(id:String ,completion: @escaping (_ success: Bool) -> ()) {
            
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
            BookingsAPI.cancelBooking(accept: "application/json", id: id,completion:{ data, error in
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
