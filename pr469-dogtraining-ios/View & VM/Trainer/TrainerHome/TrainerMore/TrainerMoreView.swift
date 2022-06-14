//
//  TrainerMoreView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-09.
//

import SwiftUI

struct TrainerMoreView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @StateObject var vm = MoreVM()
//    @ObservedObject var vms: ProfileInfoVM

    var body: some View {
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)

                VStack {
                    NavBarWithoutBackButtonTransparent(title: "More")
                    
                    ScrollView{
                    VStack(spacing: dWidth * 16/375) {
                        MoreButtonView(text: "My Profile", image: "baseline_account_circle_black_18pt_1x", destination: AnyView(TrainerProfileView(vms: ProfileInfoVM())))
                    MoreButtonView(text: "View Completed Appointments", image: "baseline_description_black_18pt_1x", destination: AnyView(CompletedAppointmentsView()))
                    MoreButtonView(text: "Manage Payment Method", image: "baseline_description_black_18pt_1x", destination: AnyView(ManagePaymentView()))
                    
                    MoreButtonView(text: "Notifications", image: "baseline_info_black_18pt_1x", destination: AnyView(NotificationView()))
                    MoreButtonView(text: "About Us", image: "baseline_info_black_18pt_1x", destination: AnyView(AboutUsView()))
                    MoreButtonView(text: "Terms & Conditions", image: "baseline_description_black_18pt_1x", destination: AnyView(TermsConditionsView()))
                    MoreButtonView(text: "Privacy Policy", image: "baseline_shield_black_18pt_1x", destination: AnyView(PrivacyPolicyView()))
                    MoreButtonView(text: "Contact Us", image: "baseline_call_black_18pt_1x", destination: AnyView(ContactUsView()))
                    Spacer()
                    
                        
                    Button(action: {
                        vm.isShowAlert.toggle()
                    }) {
                        Text("Logout")
                            .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 14)))
                            .foregroundColor(Color("#E84118"))
                            .padding()
                            .background(
                                ZStack {
                                    RoundedRectangle (cornerRadius: dWidth * 10/375).fill(Color("#191919"))
                                    RoundedRectangle (cornerRadius: dWidth * 10/375).stroke(Color("#E84118"),lineWidth: dWidth * 1.5/375)
                                }.frame(width: dWidth * 343.5/375, height: dWidth * 48.5/375))
                    }.padding(.bottom, dWidth * 80/375)
                } //:VStack
              .padding(dWidth * 16/375)
                }
            }
            } .alert(isPresented: $vm.isShowAlert) {
                /// To check wheather the showAlert become true from an Error in network call or from Log Out button
                if !vm.alertMessage.isEmpty {
                    /// Returns alert when there is an Error
                    return Alert(title: Text(verbatim: .Error), message: Text(vm.alertMessage), dismissButton: .cancel(Text("Ok")){
                        vm.alertMessage = ""
                    }
                    )
                } else {
                    /// Return alert when there is no Errors in View model
                    return Alert(
                        title: Text("Log Out"),
                        message: Text("Are you sure you want to log out?"),
                        primaryButton: .default(
                            Text("Yes"),
                            action: {
                                /// To do the network call in main thread, Otherewise showAlert variable toggle lately
                                vm.isShowAlert = false
                                /// If this is a normal user Log Out network request runs
                                vm.logOutUser(){ success in
                                    if success {
                                        print(" ❌ User Logout success ! ❌ ")
                                    }
                                }
                                
                                //MARK: - CLEAN LOACL USER
                                PersistenceController.shared.deleteUserData()
                                
                                let contentView = ContentView(vms: ProfileInfoVM())
                                UIApplication.shared.windows
                                    .first { $0.isKeyWindow }?
                                    .rootViewController = UIHostingController(rootView: contentView)
                            }
                        ),
                        secondaryButton: .cancel()
                    )
                }
            }//:ZStack
            .ignoresSafeArea(.keyboard, edges: .bottom)
            .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])
            .navigationBarTitle("More")
            .navigationBarTitleDisplayMode(.inline)
    }
}

//struct TrainerMoreView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainerMoreView(, vms: <#ProfileInfoVM#>)
//    }
//}
