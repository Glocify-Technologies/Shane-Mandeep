//
//  TrainerEditServiceView.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-03-11.
//

import SwiftUI

struct TrainerEditServiceView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    let rows: [GridItem] = [

        GridItem(.fixed(160), spacing: 20, alignment: .top)

    ]

    @State var isSubmitLinkActive: Bool = false
    @State var isTrainingSerive = false
    @State var isDogSportTitle = false
    @State var fullName: String
    @StateObject var vm = ProfileInfoVM()
    @State var privateText: String = ""
    @State var virtualText: String = ""
    @ObservedObject var vms: ProfileInfoVM
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack{
                NavBarWithBackButton(title: "Edit Your Services") {
                   presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView(showsIndicators: false) {
                    
                    
                    //MARK: - TrainingExpDropDown
                    ZStack(alignment: .top) {
                        if isTrainingSerive {
                            EditTrainingServiceDropDown(vms:vms,textFiled: $vm.ServicesText, serviceId: $vm.ServicesId, vm: vm)
                                .offset(y: 21)
                        }
                        Button(action: {
                            isTrainingSerive.toggle()
                        }, label: {
                            DropDownList(title: "Services Provided", name: vm.ServicesText != "" ? vm.ServicesText : "Please select", option: "", image: "outline_expand_more_black_18pt_1x")
                        })
                    }.padding(.top, dWidth * 16/375)
                    

                   
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                                
                            LazyHGrid(rows: rows) {
                                if let allServices = vms.selectEditServices {

                                    ForEach(0..<(allServices.count), id: \.self) { i in
                                        VStack{
                                            HStack(spacing : 18){
                                            
                                                serviceView(text: Binding<String>.init(get: {
                                                    "\(vms.selectEditServices[i].price ?? 0)"
                                                }, set: { new in
                                                    vms.selectEditServices[i].price = Int(new)
                                                }), image: "outline_monetization_on_black_18pt_1x" ,title: allServices[i].name ?? "")
                                        }.padding(.top, 30)
                                        HStack{
                                        Text("Per/Hour")
                                                .padding(.leading, dWidth * 16/375)

                                            
                                        }
                                        .font(Font.custom("SFProText-Regular", size: dWidth * 14/375))
                                        .foregroundColor(Color.white)
                                            .padding(.top, dWidth * 20/375)
                                        }
                                    }
                                }
                               
                            }
                        }

                    //MARK: - Save BUTTON
                    NavigationLink (
                        destination: PaymentMethodView(vms: vms).navigationBarHidden(true),
                        isActive: $isSubmitLinkActive,
                       

                        label: {
                            ButtonCommon(buttonName: "Save", someAction: {
                                let allServicesArr: NSMutableArray = NSMutableArray()
                                allServicesArr.removeAllObjects()//.removeAllObjects()
                                for i in 0..<(vms.selectEditServices.count)
                                {
                                    
                                    let jsonDataDict: NSMutableDictionary = NSMutableDictionary()
                                    if !allServicesArr.contains(vms.selectEditServices[i].service_id){
                                        jsonDataDict.setValue(vms.selectEditServices[i].price, forKey: "price")
                                        jsonDataDict.setValue(vms.selectEditServices[i].service_id, forKey: "service_id")
                                        allServicesArr.add(jsonDataDict)
                                    }
                                    
                                }
                                if vm.formValidationsServiceProfileInfo(selectServices: vms.selectEditServices) {
                                    vm.servicesUpdate(services: allServicesArr) { success in
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
                                
//                               isSubmitLinkActive.toggle()
                            })
                        }) .navigationViewStyle(.stack)
                 

                       // .padding(.bottom, dWidth * 100/375)
                    .padding(.top, dWidth * 150/375)
                        
                } //:ScrollView
               .padding(16)
            } //:VStack
        }.onFirstAppear{
            vm.loadData()
        } //:ZStack
    }
}

