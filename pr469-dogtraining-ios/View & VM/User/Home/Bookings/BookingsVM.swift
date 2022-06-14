//
//  BookingsVM.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-07.
//

import Foundation

struct BookingsUserCardData:Identifiable {
    var id = UUID()
    
    var date: String
    var time: String
    var image: String
    var name: String
    var centre: String
    var address: String
    
}


class BookingsVM:iBSBase,ObservableObject{
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var searchText = ""
    @Published var getPaginator:Paginator?
    
    var confirmBookingsFull = false
    public var booking: [Booking]?
    // Tracks last page loaded. Used to load next page (current + 1)
    var currentPage = 0
    var currentConfirmPage = 0
    // Limit of records per page. (Only if backend supports, it usually does)
    let perPage = 15
    @Published var userCardArray: [BookingsUserCardData] = [BookingsUserCardData(date: "Wed 27, Oct", time: "11.00 AM", image: "People 07", name: "Alison Cara", centre: "Dog Training Centre", address: "3 Farland Street, Brockton, MA 02401"),BookingsUserCardData(date: "Wed 28, Oct", time: "11.00 AM", image: "People 05", name: "Alison Cara", centre: "Dog Training Centre", address: "3 Farland Street, Brockton, MA 02401"),BookingsUserCardData(date: "Wed 27, Oct", time: "11.00 AM", image: "People 04", name: "Alison Cara", centre: "Dog Training Centre", address: "3 Farland Street, Brockton, MA 02401")]
}
extension BookingsVM:LoadingIndicatorDelegate{
    
    
    func getConfirmBookings( searchText: String, page: Int, perPage:Int ,completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        BookingsAPI.bookingsGetGetConfirmBookings(accept: "application/json", page: page, perPage: perPage, q: searchText,completion:{ data, error in
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
                    self.confirmBookingsFull = true
                }
                guard let paginator = data?.paginator else {return}
                self.getPaginator = paginator
                guard var bookingAll = self.booking else{
                    self.booking = user
                    return
                }
                
                bookingAll += user
                self.booking?.removeAll()
                self.booking = bookingAll
                print(print("vm.booking?.count",self.booking?.count as Any))
                
//                    self.allTrainer?.append(contentsOf: user)// = user
                
                // Read access token from readable object
                completion(true)
            }
        })
      

    
    
}
    
    
    func getConfirmBookingsSearch(searchText: String, page: Int, perPage:Int ,completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        BookingsAPI.bookingsGetGetConfirmBookings(accept: "application/json", page: page, perPage: perPage, q: searchText,completion:{ data, error in
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

                self.booking = user
                print(print("vms.allTrainer?.count",self.booking?.count))
                
//                    self.allTrainer?.append(contentsOf: user)// = user
                
                // Read access token from readable object
                completion(true)
            }
        })
      

    
    
}
    
    func getPendingBookings( searchText: String, page: Int, perPage:Int ,completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        BookingsAPI.bookingsGetGetAllPendingBookings(accept: "application/json", page: page, perPage: perPage, q: searchText,completion:{ data, error in
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
                    self.confirmBookingsFull = true
                }
                guard let paginator = data?.paginator else {return}
                self.getPaginator = paginator
                guard var bookingAll = self.booking else{
                    self.booking = user
                    return
                }
                
                bookingAll += user
                self.booking?.removeAll()
                self.booking = bookingAll
                print(print("vms.allTrainer?.count",self.booking?.count))
                
//                    self.allTrainer?.append(contentsOf: user)// = user
                
                // Read access token from readable object
                completion(true)
            }
        })
      

    
    
}
    
    
    func getPendingBookingsSearch(searchText: String, page: Int, perPage:Int ,completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        BookingsAPI.bookingsGetGetConfirmBookings(accept: "application/json", page: page, perPage: perPage, q: searchText,completion:{ data, error in
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

                self.booking = user
                print(print("vms.allTrainer?.count",self.booking?.count))
                
//                    self.allTrainer?.append(contentsOf: user)// = user
                
                // Read access token from readable object
                completion(true)
            }
        })
      

    
    
}
    
}
