//
//  AvailabilityView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-12.
//

import SwiftUI

struct AvailabilityView: View {
    @State var isPreferedTimeViewSelected: Bool = false
    @State var isServiceViewSelected: Bool = false
    @State var isPetProfilePressed = false
    @ObservedObject var vms: ProfileInfoVM

    @State var tab = 0
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    
    @StateObject var vm = AddPetProfileVM()
    @State var isSubmitLinkActive: Bool = false
    @State var selectedDate = Date()
    @State var startDate = Date()
    @State var endDate = Date()
    @State var selectedTimes = String()
    @State var selectedDateStr = String()
    @State var selectedOnlyDateStr = String()
    @State var allServices = [Service]()
    @State var selectTime = [SelectTime]()
    @State private var date = Date()
    @State var startDateStr = String()
    @State var endDateStr = String()
    var body: some View {
        ZStack{
           
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: dWidth * 16/375) {
                NavBarWithoutBackButtonTransparent(title: "Availability") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading,spacing: dWidth * 16/375) {
                        CalendarView(selectedDate: $selectedDate, selectedDateStr: $selectedDateStr, selectedOnlyDateStr: $selectedOnlyDateStr)
                        Text("Services Provided")
                            .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 14)))
                            .foregroundColor(Color.white)
                       
                        ZStack(alignment: .top) {
                           
                            
                            if isServiceViewSelected {
                                PreferredServiceView(vms:vm,textFiled: $vm.ServicesText, serviceId: $vm.ServicesId, vm: vm,services:$allServices)
//                                    .offset(y: dWidth * 22/375)
                                   
                            }
                            Button(action: {
                                isServiceViewSelected.toggle()
                            }, label: {
                                AvailabilityDropDownList(name: vm.ServicesText != "" ? vm.ServicesText : "Please select", image: "outline_expand_more_black_18pt_1x")
                            })
                                .overlay(RoundedRectangle(cornerRadius: dWidth * 10/375)
                                            .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375))
                            
                        }
                        .padding(.bottom,dWidth * 22/375)
                            ZStack(alignment: .top) {
                                if isPreferedTimeViewSelected {
                                    if selectTime.count != 0{
                                        AvailabilityDropDown(selectTime:$selectTime,startDate: $startDate,endDate: $endDate, selectedTimes:  $selectedTimes,startDateStr:$startDateStr,endDateStr:$endDateStr)
                                    }
                                   
                                }
                                Button(action: {
                                    withAnimation(.linear(duration: 1)) {
                                        isPreferedTimeViewSelected.toggle()
                                    }
                                   
                                }, label: {
                                    AvailabilityTimesDropDownList(name: selectedTimes != "" ? selectedTimes : "Schedule a new time", image: "outline_add_black_18pt_1x",startDate: $startDate, endDate: $endDate, show: $isPreferedTimeViewSelected,startDateStr:$startDateStr,endDateStr:$endDateStr, showToast: .constant(false), message: .constant("please select start and end time"), selectTime: $selectTime, selectedTimes: $selectedTimes)
                                })

                                    .overlay(RoundedRectangle(cornerRadius: dWidth * 10/375)
                                                .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375))

                            }
                    } .padding()
                    
                    NavigationLink (
                        destination: TrainerMainTabView(vms: vms).navigationBarHidden(true),
                        isActive: $isSubmitLinkActive,
                        label: {
                            ButtonCommonLarge(buttonName: "Confirm", someAction: {
                                let allTimeArr: NSMutableArray = NSMutableArray()
                                for i in 0..<(selectTime.count)
                                {
                                    let jsonDataDict: NSMutableDictionary = NSMutableDictionary()
                                    if !allTimeArr.contains(selectTime[i].id){
                                        jsonDataDict.setValue(selectTime[i].start_time, forKey: "start_time")
                                        jsonDataDict.setValue(selectTime[i].end_time, forKey: "end_time")
                                        allTimeArr.add(jsonDataDict)
                                    }
                                    
                                }
                                if vms.formValidationsAddNewAvailibility(date: selectedDateStr, service: vm.ServicesId, times: allTimeArr){
                                    vm.addAvailabeServices(date: selectedDateStr, serviceId: vm.ServicesId, times: allTimeArr) { success in
                                        isSubmitLinkActive.toggle()
                                    }
                                }
                               
                            })
                        })
                        .padding(.bottom, 80)
                } //:ScrollView
            } //:VStack
            .onAppear{
                UIDatePicker.appearance().tintColor = UIColor.init(.green)
            }
        }.onAppear{
            vms.getServices { success in
                allServices = vms.services
            }
        }

        //:ZStack
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])
    }
   
}

//struct AvailabilityView_Previews: PreviewProvider {
//    static var previews: some View {
//        AvailabilityView()
//    }
//}
