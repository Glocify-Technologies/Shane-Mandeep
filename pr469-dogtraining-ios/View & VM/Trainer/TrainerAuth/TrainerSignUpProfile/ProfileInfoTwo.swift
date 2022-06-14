//
//  ProfileInfoTwo.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/17/21.
//

import SwiftUI

struct ProfileInfoTwo: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
   
    @State var isSubmitLinkActive: Bool = false
    @State var isTrainingExperience = false
    @State var isDogSportTitle = false
    @State var fullName: String
    @State var service : [Service] = []
    @ObservedObject var vms: ProfileInfoVM
    @StateObject var vm = ProfileInfoVM()
    var getTrainerProfile: TrainerProfileModel
    @State var text: String
    @State var selectService:[SelectService] = []
    @State var itemService:Service?
    @State var trainerProfileModel = TrainerProfileModel()
    @State var arr:NSMutableArray?
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                NavBarWithBackButton(title: "Complete Your Profile") {
                    vms.selectServices.removeAll()
                    presentationMode.wrappedValue.dismiss()
                }
                
//                ScrollView(showsIndicators: false) {
                    
                    VStack(alignment: .leading, spacing: dWidth * 20/375) {
                        
                        Text("Services Provided")
                            .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                            .foregroundColor(Color.white)
                            .padding(.leading, dWidth * 16/375)
                            .padding(.top, 24)
                        
                        //MARK: - Dog Sport Titles Menu
                        List {
                            ForEach(0..<vms.services.count, id: \.self) { i in
                                ServiceRateView(name: vms.services[i].service ?? "no value", textField:Binding<String>(
                                    get: {vms.services[i].pivot?.price ?? ""}, set: {vms.services[i].pivot?.price = $0}) , arr: arr ?? [], selectService: selectService,vms: vms, service:vms.services[i], serviceId: vms.services[i]._id ?? 0,index: i)
                                   }.listRowBackground(backgroundColor)
                               }
                        .padding(.top, -48)
                        .padding(.leading, -16)
                         .padding(.trailing, -16)
                            .onAppear {
                                UITableView.appearance().separatorStyle = .none
                                UITableView.appearance().backgroundColor = UIColor.clear
                                UITableViewCell.appearance().backgroundColor = UIColor.clear
                                UITableView.appearance().separatorColor = .clear
                                UITableView.appearance().backgroundView = nil
                                UITableViewCell.appearance().backgroundView = nil
                                UITableViewCell.appearance().contentView.backgroundColor = UIColor.clear
                                UITableView.appearance().backgroundView?.backgroundColor = UIColor.clear
                                UITableViewCell.appearance().backgroundView?.backgroundColor = UIColor.clear

                            }
//                            ServiceRateView(name: self.service[0].service ?? "no value", textField: .constant("100"))
                            
//                            ServiceRateView(name: "Virtual Lessons", textField: .constant("100"))
//                            ServiceRateView(name: "Boarding & Training", textField: .constant("100"))
//                            ServiceRateView(name: "Group Clases", textField: .constant("100"))
//                        }.padding(.top,5)

                    }
                    
                    //MARK: - NEXT BUTTON
                    NavigationLink (
                        
                        destination: ProfileInfoThree(vms: vms, fullName: "", vmss: vms, documentFileURL: NSURL(), getTrainerProfile: trainerProfileModel).navigationBarHidden(true),
                        isActive: $isSubmitLinkActive,
                        label: {
                            ButtonCommon(buttonName: "Next", someAction: {
                               
                                trainerProfileModel = TrainerProfileModel(name: getTrainerProfile.name,phone:  getTrainerProfile.phone, lat: getTrainerProfile.lat, long: getTrainerProfile.long, location: getTrainerProfile.location, business_name: getTrainerProfile.business_name, business_phone_number: getTrainerProfile.business_phone_number, wesbite: getTrainerProfile.wesbite,services: vms.selectServices)
                                if vm.formValidationsServiceProfileInfo(selectServices: vms.selectServices) {
                                    // SignIn Network Request
                                    isSubmitLinkActive.toggle()
                                }
                               
                            })
                        })
                    
                    .alert(isPresented: $vm.isShowAlert) {
                        Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage), dismissButton: .default(Text("Ok")))}
                        .padding(.top, dWidth * 40/375)
                        .padding(.bottom, dWidth * 30/375)
                    
//                } //:ScrollView
            } //:VStack
            
        }.onAppear {
           // vms.selectServices.removeAll()
            vms.loadSportsData()
            vms.loadExperienceData()
        } //:ZStack
        
    }
}


//struct ProfileInfoTwo_Previews: PreviewProvider {
//
//    static let trainerProfile = TrainerProfileModel(name: "", lat: 0.0, long: 0.0, location: "", business_name: "", business_phone_number: "", wesbite: "", training_place: "", experience_id: "")
//    static var previews: some View {
//
//        ProfileInfoTwo(fullName: "", vms:ProfileInfoVM(), getTrainerProfile: trainerProfile)
//    }
//
//}
