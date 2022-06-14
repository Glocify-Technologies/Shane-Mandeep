//
//  ProfileVM.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/17/21.
//

import Foundation
import UIKit
import PDFKit

class ProfileInfoVM:iBSBase, ObservableObject{
    //MARK: - PROPERITY
    @Published var isShowAlert = false
    @Published var alertMessage = ""
    @Published var alertTitle = ""
    @Published var countryCode = ""
    @Published var countryFlag = ""
    @Published var fullNameText = ""
    @Published var phoneText = ""
    @Published var lat = ""
    @Published var long = ""
    @Published var age = ""
    @Published var location = ""
    @Published var isServicesShow : Bool = false
    @Published var email = ""
    @Published var businessNameText = ""
    @Published var businessLocationText = ""
    @Published var businessPhoneText = ""
    @Published var WebsiteText = ""
    @Published var ServicesText = ""
    @Published var ServicesId = ""
    @Published var SportText = ""
    @Published var sportsId = ""
    @Published var ExpId = ""
    @Published var ExperinceText = ""
    @Published var image = ""
    @Published var termsAndConId = ""
    @Published var Image : UIImage?
    @Published var selectCountryCode : Bool = false
    @Published var phoneCountryCode = ""
    @Published var businessPhoneCountryCode = ""
    //MARK: - FOR VALIDATION
    @Published var fullNameValidation = false
    @Published var lastNameValidation = false
    @Published var newPasswordValidation = false
    @Published var emailValidation = false
    @Published var services: [Service] = []
    @Published var sportTitle: [SportTitle] = []
    @Published var selectServices: [SelectService] = []
    @Published var selectPreferedServices: [SelectService] = []
    @Published var experience: [Experience] = []
    @Published var getTrainer:Trainer?
    @Published var imageLoader = ImageLoader()
    @Published var selectedSportTitle: [SportTitle] = []
    
    @Published var selectEditServices: [SelectService] = []
//    override init() {
//        super.init()
//        self.loadData()
//    }
   
}
//: MARK: - APINetworkRequest
extension ProfileInfoVM: LoadingIndicatorDelegate {
    func loadData(){
        getServices { success in
            print(self.services)
        }
    }
    func loadSportsData(){
        getSportTitle { success in
            print(self.sportTitle)
        }
    }
    func loadExperienceData(){
        getAllExperience { success in
            print(self.experience)
        }
    }
    
    func loadTrainerProfile(){
        getTrainerProfile{ [weak self] success in
            self?.ServicesText = ""
            for i in 0..<(self?.getTrainer?.services?.count ?? 0){
                autoreleasepool{
                if self?.ServicesText == ""{
                    self?.ServicesText = self?.getTrainer?.services?[i].service ?? ""
                }else{
                    self?.ServicesText = (self?.ServicesText ?? "") + "," + (self?.getTrainer?.services?[i].service ?? "")
                }
                }
            }
            self?.SportText = ""
            for i in 0..<(self?.getTrainer?.sportTitles?.count ?? 0){
                autoreleasepool{
                if self?.SportText == ""{
                    self?.SportText = self?.getTrainer?.sportTitles?[i].title ?? ""
                }else{
                    self?.SportText = (self?.SportText ?? "") + "," + (self?.getTrainer?.sportTitles?[i].title ?? "")
                }
                }
            }
            for i in 0..<(self?.getTrainer?.file?.count ?? 0){
                 // found
                autoreleasepool{
                if self?.getTrainer?.file?[i].category == "terms and conditions"{

                    if let imageURL = self?.getTrainer?.file?[i].fileUrl {
                        if ((imageURL.contains(".pdf")) == true) {
//                            self?.Image = self?.pdfThumbnail(url: URL(string: imageURL)!)
                        }
//                        else{
//                            self?.imageLoader.loadData(from: imageURL) { data in
//                                self?.Image = UIImage(data: data)
//                            }
//                        }
                        self?.image = imageURL
                        self?.termsAndConId =  "\(self?.getTrainer?.file?[i]._id ?? 0)"


                    }
                }
                }
            }
            
            for j in 0..<(self?.getTrainer?.certificate?.count ?? 0){
                autoreleasepool{
                if ((self?.getTrainer?.certificate?[j].fileUrl!.contains(".pdf")) == true) {
                        self?.getTrainer?.certificate?[j].fileImage = UIImage(systemName: "list.bullet")//self?.pdfThumbnail(url: URL(string: self?.getTrainer?.certificate?[j].fileUrl ?? "")!)
                    
                    
                }
                }
            }
        }
    }
//    func pdfThumbnail(url: URL, width: CGFloat = 240) -> UIImage? {
//        guard let data = try? Data(contentsOf: url),
//            let page = PDFDocument(data: data)?.page(at: 0) else {
//        return nil
//      }
//
//      let pageSize = page.bounds(for: .mediaBox)
//      let pdfScale = width / pageSize.width
//
//      // Apply if you're displaying the thumbnail on screen
//      let scale = UIScreen.main.scale * pdfScale
//      let screenSize = CGSize(width: pageSize.width * scale,
//                              height: pageSize.height * scale)
//
//        let image = page.thumbnail(of: screenSize, for: .mediaBox)
//        return UIImage(data: image.jpegData(compressionQuality: 0.5)!)
//    }
    func setUpProfileTrainer(image:URL, completion: @escaping (_ success: Bool,_ data:ProfileUpdateMyAvatarResponse?) -> ()) {

            

            // Starting Loading Indicator

            startLoading()

            

            // Check internet connection

            guard Reachability.isInternetAvailable() else {

                // Stop Loading Indicator

                stopLoading()

                

                self.alertTitle = .Failed

                self.alertMessage = .NoInternet

                self.isShowAlert = true

                completion(false,nil)

                return

            }

          

            ProfileAPI.profilePostUpdateMyAvatar(image:image,accept: "application/json",completion: { data, error in

                // Stop Loading Indicator

                self.stopLoading()

                

                if error != nil {

                    self.hadleErrorResponse(error) { _, _, message in

                        self.isShowAlert = true

                        self.alertMessage = message

                        self.alertTitle = .Error

                        completion(false,nil)

                    }

                } else {

                    guard let user = data?.payload else {

                        self.isShowAlert = true

                        self.alertMessage = .MismatchingData

                        self.alertTitle = .Error

                        return

                        completion(false,nil)

                    }

                    // Read access token from readable object

                  

                    completion(true,data)

                }

            })

        }
    func setUpProfileInfo(name: String, location: String, lat: String,long: String,phone:String,age:String, completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        ProfileAPI.profilePutUserProfileSetup(name: name, phone: phone, accept: "application/json", location: location, latitude: lat, longitude: long, age: age, completion: { data, error in
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
                for i in 0..<(self.getTrainer?.services?.count ?? 0){
                    for j in  0..<self.services.count{
                        if self.services[j]._id == self.getTrainer?.services?[i]._id{
                            self.services[j].isShow = true
                        }
                    }
                }
               
                completion(true)
            }
        })
    }
    
    func getSportTitle(completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        SportTitleAPI.sportTitleGetGetAllSportTitles(accept: "application/json", completion:{ data, error in
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
                self.sportTitle = data?.payload ?? []
                for i in 0..<(self.getTrainer?.sportTitles?.count ?? 0){
                    for j in  0..<self.sportTitle.count{
                        if self.sportTitle[j]._id == self.getTrainer?.sportTitles?[i]._id{
                            self.sportTitle[j].isShow = true
                        }
                    }
                }
                completion(true)
            }
        })
      
    }
    
    func getAllExperience(completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        ExperienceAPI.experienceGetGetAllExperience(accept: "application/json", completion:{ data, error in
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
                self.experience = data?.payload ?? []
                completion(true)
            }
        })
      
    }
    func deleteFiles(fileId:String,completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        ProfileAPI.profileDeleteMyFiles(fileId: fileId,accept: "application/json",completion: { data, error in
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
    
    
    func updateFiles(photos: URL? = nil,fileId:String,termsConditions: NSURL? = nil,certificates: URL? = nil, completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        ProfileAPI.profilePostUpdateMyFiles(photos: photos, fileId: fileId, termsConditions: termsConditions, certificates: certificates, accept: "application/json",completion: { data, error in
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
    
    
    func setUpTrainersProfileInfo(name: String, phone: String, businessName: String, location: String, latitude: String, longitude: String, businessPhoneNumber: String, wesbite: String, serviceId:  NSMutableArray, sportTitleId: String, photos: [NSURL], trainingPlace: String, experienceId: String, termsConditions: NSURL? = nil, certificates: [NSURL], completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        ProfileAPI.profilePostTrainerProfileSetup(accept: "application/json", name: name, phone: phone, businessName: businessName, location: location, latitude: latitude, longitude: longitude, businessPhoneNumber: businessPhoneNumber, wesbite: wesbite, serviceId: serviceId , sportTitleId: sportTitleId, photos: photos, trainingPlace: trainingPlace, experienceId: experienceId, termsConditions: termsConditions, certificates: certificates,completion: { data, error in
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

    func getTrainerProfile(completion: @escaping (_ success: Bool) -> ()) {
        
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
      
        TranierAPI.tranierGetGetTranierProfile(accept: "application/json", completion:{ data, error in
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
                self.getTrainer = user
                // Read access token from readable object
                completion(true)
            }
        })
    }
    
    
    func servicesUpdate(services:NSMutableArray,completion: @escaping (_ success: Bool) -> ()){
        
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
        ServicesAPI.servicesUpdate(services: services, accept: "application/json",completion: { data, error in
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

//: MARK: - FormValidation
extension ProfileInfoVM {
    func formValidationProfileInfo(name: String,phone: String) -> Bool {
        if name.isEmpty {
            alertTitle = .Failed
            alertMessage = .NameEmpty
            isShowAlert = true
            return false
        } else if phone.isEmpty {
            alertTitle = .Failed
            alertMessage = .PhoneEmpty
            isShowAlert = true
            return false
        }
        return true
    }
    
    func formValidationsProfileInfo(name: String,phone: String,businessName:String,businessLocation:String,businessPhoneNum:String,website:String,countryCode:String,businessCountryCode:String) -> Bool {
        if name.isEmpty {
            alertTitle = .Failed
            alertMessage = .NameEmpty
            isShowAlert = true
            return false
        } else if countryCode.isEmpty {
            alertTitle = .Failed
            alertMessage = .CountryCodeEmpty
            isShowAlert = true
            return false
        }else if phone.isEmpty {
            alertTitle = .Failed
            alertMessage = .PhoneEmpty
            isShowAlert = true
            return false
        }else if businessName.isEmpty {
            alertTitle = .Failed
            alertMessage = .BusinessNameEmpty
            isShowAlert = true
            return false
        }else if businessLocation.isEmpty {
            alertTitle = .Failed
            alertMessage = .BusinessLocationEmpty
            isShowAlert = true
            return false
        }else if businessCountryCode.isEmpty {
            alertTitle = .Failed
            alertMessage = .CountryCodeEmpty
            isShowAlert = true
            return false
        }else if businessPhoneNum.isEmpty {
            alertTitle = .Failed
            alertMessage = .BusinessPhoneNumberEmpty
            isShowAlert = true
            return false
        }else if website.isEmpty {
            alertTitle = .Failed
            alertMessage = .WebsiteEmpty
            isShowAlert = true
            return false
        }
        return true
    }
    func formValidationsServiceProfileInfo(selectServices:[SelectService]) -> Bool {
        if selectServices.isEmpty {
            alertTitle = .Failed
            alertMessage = .ServiceNameEmpty
            isShowAlert = true
            return false
        }
        return true
    }

    func formValidationsTrainersProfileInfo(trainingPlace: String,trainingExp: String,sportsTitle:String,termsCon:String) -> Bool {
        if trainingPlace.isEmpty {
            alertTitle = .Failed
            alertMessage = .TrainingPlaceEmpty
            isShowAlert = true
            return false
        } else if trainingExp.isEmpty {
            alertTitle = .Failed
            alertMessage = .TrainingExpEmpty
            isShowAlert = true
            return false
        }else if sportsTitle.isEmpty {
            alertTitle = .Failed
            alertMessage = .DogSportsTitleEmpty
            isShowAlert = true
            return false
        }else if termsCon.isEmpty {
            alertTitle = .Failed
            alertMessage = .TermConEmpty
            isShowAlert = true
            return false
        }
        return true
    }
    
    func formValidationsEditProfileInfo(name: String,email: String,phone: String,businessName:String,businessLocation:String,businessPhoneNum:String,website:String,SelectService:[SelectService],images:[NSURL],imagesURLString:[File],jobTraining:String,trainingExp:String,dogSports:String,certificates:[NSURL],cerificateURLString:[File],terms:String,termsStringURL:UIImage?,countryCode:String,businessCountryCode:String) -> Bool {
        if name.isEmpty {
            alertTitle = .Failed
            alertMessage = .NameEmpty
            isShowAlert = true
            return false
        }else if email.isEmpty {
            alertTitle = .Failed
            alertMessage = .EmailEmpty
            isShowAlert = true
            return false
        }else if !Validators().isValidEmailValidator(value: email).isSuccess {
            alertTitle = .Failed
            alertMessage = .InvalidEmail
            isShowAlert = true
            return false
        }
        else if countryCode.isEmpty {
            alertTitle = .Failed
            alertMessage = .countryCodePhoneEmpty
            isShowAlert = true
            return false
        }else if phone.isEmpty {
            alertTitle = .Failed
            alertMessage = .PhoneEmpty
            isShowAlert = true
            return false
        }
        else if businessName.isEmpty {
            alertTitle = .Failed
            alertMessage = .BusinessNameEmpty
            isShowAlert = true
            return false
        }else if businessLocation.isEmpty {
            alertTitle = .Failed
            alertMessage = .BusinessLocationEmpty
            isShowAlert = true
            return false
        }
        else if businessCountryCode.isEmpty {
            alertTitle = .Failed
            alertMessage = .CountryCodeEmpty
            isShowAlert = true
            return false
        }else if businessPhoneNum.isEmpty {
            alertTitle = .Failed
            alertMessage = .BusinessPhoneNumberEmpty
            isShowAlert = true
            return false
        }else if website.isEmpty {
            alertTitle = .Failed
            alertMessage = .WebsiteEmpty
            isShowAlert = true
            return false
        }else if SelectService.isEmpty {
            alertTitle = .Failed
            alertMessage = .ServiceNameEmpty
            isShowAlert = true
            return false
        }else if images.isEmpty && imagesURLString.isEmpty {
            alertTitle = .Failed
            alertMessage = .imageEmpty
            isShowAlert = true
            return false
        }else if jobTraining.isEmpty {
            alertTitle = .Failed
            alertMessage = .TrainingPlaceEmpty
            isShowAlert = true
            return false
        }else if trainingExp.isEmpty {
            alertTitle = .Failed
            alertMessage = .TrainingExpEmpty
            isShowAlert = true
            return false
        }else if dogSports.isEmpty {
            alertTitle = .Failed
            alertMessage = .DogSportsTitleEmpty
            isShowAlert = true
            return false
        }else if certificates.isEmpty && cerificateURLString.isEmpty{
            alertTitle = .Failed
            alertMessage = .certificatesEmpty
            isShowAlert = true
            return false
        }else if terms.isEmpty && termsStringURL == nil {
            alertTitle = .Failed
            alertMessage = .TermConEmpty
            isShowAlert = true
            return false
        }
        return true
    }
    
    func formValidationsAddNewAvailibility(date: String,service:String,times:NSMutableArray) -> Bool {
        if date.isEmpty {
            alertTitle = .Failed
            alertMessage = .selectDateForBookingEmpty
            isShowAlert = true
            return false
        } else if service.isEmpty {
            alertTitle = .Failed
            alertMessage = .ServiceNameEmpty
            isShowAlert = true
            return false
        }else if times.count == 0 {
            alertTitle = .Failed
            alertMessage = .selectPreferredTimeForBookingEmpty
            isShowAlert = true
            return false
        }
        return true
    }
    
}

