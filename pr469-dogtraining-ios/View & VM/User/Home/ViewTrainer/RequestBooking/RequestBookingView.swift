//
//  RequestBookingView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-19.
//

import SwiftUI
import RappleProgressHUD

struct RequestBookingView: View {
    @State var isPreferedTimeViewSelected: Bool = false
    @State var isPetProfilePressed = false
    @State var isPreferedServiceViewSelected = false
    
    @State var tab = 0
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @State var trainerData: Trainer?
    @ObservedObject var vm = AddPetProfileVM()
    @State var isSubmitLinkActive: Bool = false
    @State private var date = Date()
    @State var selectedDate = Date()
    @State var selectedDateStr = String()
    @State var selectedOnlyDate = String()
    @State var selectedTime = Date()
    @State var selectedTimeStr = String()
    @State var timeList: [String] = []
    @State var services: [Service] = []
    @State var getAvailability: [Time]? = []
    @State var petProfile: [PetProfile] = []
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: Screen.sizeFromWidth(size: 16)) {
                NavBarWithBackButton(title: "Request Booking") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading) {
                        CalendarView(selectedDate: $selectedDate, selectedDateStr: $selectedDateStr,selectedOnlyDateStr: $selectedOnlyDate) .onChange(of:selectedDateStr){newValue in
                            var serviceId = ""
                            vm.selectPreferedServices.forEach { SelectServices in
                                serviceId = "\(SelectServices.service_id ?? 0)"
                            }
                            if selectedOnlyDate != "" && serviceId != ""{
                               
                                vm.getAllAvailabeServices(date:selectedOnlyDate,serviceId: serviceId,trainerId:"\(trainerData?._id ?? 0)") { success in
                                    getAvailability = vm.getAvailabilityservices
                                }
                            }
                        }
                           
                            .padding(.bottom, dWidth * 28/375)
                        
                        VStack(spacing: dWidth * 28/375) {
                            ZStack(alignment: .top) {
                                if isPreferedServiceViewSelected {
                                    PreferredServiceView(vms:vm,textFiled: $vm.ServicesText, serviceId: $vm.ServicesId, vm: vm,services:$services)
                                        .offset(y: dWidth * 22/375)
                                        .onChange(of:vm.ServicesText ){newValue in
                                            var serviceId = ""
                                            vm.selectPreferedServices.forEach { SelectServices in
                                                serviceId = "\(SelectServices.service_id ?? 0)"
                                            }
                                            if selectedOnlyDate != "" && serviceId != ""{
                                               
                                                vm.getAllAvailabeServices(date:selectedOnlyDate,serviceId: serviceId,trainerId:"\(trainerData?._id ?? 0)") { success in
                                                    getAvailability = vm.getAvailabilityservices
                                                }
                                            }
                                        }
                                }
                                Button(action: {
                                    isPreferedServiceViewSelected.toggle()
                                }, label: {
                                    DropDownList(title: "Select Service", name: vm.ServicesText != "" ? vm.ServicesText : "Please select" , option: "", image: "outline_expand_more_black_18pt_1x")
                                    
                                })
                            }
                            
                            ZStack(alignment: .top) {
                                if isPreferedTimeViewSelected {
                                    PreferedTimeView(timelist: timeList, times: $getAvailability,textFiled: $selectedTimeStr,timeId: $vm.timeId)
                                        .offset(y: dWidth * 36/375)
                                        .padding(.bottom, (dWidth * 22/375))
                                }
                                Button(action: {
                                    isPreferedTimeViewSelected.toggle()
                                }, label: {
                                    DropDownList(title: "Select Your Preferred Time", name: selectedTimeStr != "" ? selectedTimeStr : "Please select", option: "", image: "outline_expand_more_black_18pt_1x")
                                })
                            }
                            
                            ZStack(alignment: .top) {
                                if isPetProfilePressed {
                                    PetProfileSelectView(textFiled: $vm.petProfileText, petProfileId: $vm.petProfileId, petProfile: $petProfile)
                                        .offset(y: dWidth * 22/375)
                                }
                                Button(action: {
                                    isPetProfilePressed.toggle()
                                }, label: {
                                    DropDownList(title: "Select Your Pet Profile", name: vm.petProfileText != "" ? vm.petProfileText : "Please select", option: "", image: "outline_expand_more_black_18pt_1x")
                                })
                            }
                            
                            NavigationLink (
                                destination: MainTabView().navigationBarHidden(true),
                                isActive: $isSubmitLinkActive,
                                label: {
                                    ButtonCommonLarge(buttonName: "Request for booking", someAction: {
                                        var serviceId = Int()
                                        var petProfileId = Int()
                                        vm.selectPetProfile.forEach { SelectPetProfile in
                                            petProfileId = SelectPetProfile._id ?? 0
                                        }
                                        vm.selectPreferedServices.forEach { SelectServices in
                                            serviceId = SelectServices.service_id ?? 0
                                        }
                                        print(selectedDate)
                                        if vm.formValidationsServiceProfileInfo(selectDate: selectedDateStr, time: selectedTimeStr, service: vm.ServicesText, petProfile: vm.petProfileText){
                                            vm.bookingsPostAddNewBooking(trainerId: "\(trainerData?._id ?? 0)", date: selectedDateStr, serviceId: "\(serviceId)", time: selectedTimeStr, petProfileId: vm.petProfileId) { success in
                                                print("")
                                                isSubmitLinkActive.toggle()
                                            }
                                        }
                                        
                                    })
                                        .alert(isPresented: $vm.isShowAlert) {
                                        Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), primaryButton: .cancel(), secondaryButton: .default(Text("Ok")))}
                                }) .isDetailLink(false)
                               
                                .padding(.bottom, dWidth * 66/375)
                        }//VStack
                    } .padding()
                } //:ScrollView
                
            } //:VStack
            .onAppear{
                vm.getServices { success in
//                    print(vms.services)
                    services = vm.services
                }
                vm.getAllPetProfile { success in
                    petProfile = vm.petProfile
                }
               
                UIDatePicker.appearance().tintColor = UIColor.init(.green)
            }
        }
        
        //:ZStack
    }
}

struct RequestBookingView_Previews: PreviewProvider {
    static var previews: some View {
        RequestBookingView()
    }
}
