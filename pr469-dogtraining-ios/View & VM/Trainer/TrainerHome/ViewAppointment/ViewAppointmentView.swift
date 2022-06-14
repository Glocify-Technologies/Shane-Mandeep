//
//  ViewAppointmentView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-09.
//

import SwiftUI
import XCTest

struct ViewAppointmentView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @State var isCompleteLinkActive: Bool = false
    @State var isCancelLinkActive: Bool = false
    @ObservedObject var vms: TrainerHomeVM
    var booking:Booking?
    @State var serviceName = ""
    @State var status = ""
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavBarWithBackButtonTransparent(title: "View Appointment") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView {
                    Text(status != "" ? status : booking?.status ?? "")
                        .font(.customFont(.SFProTextHeavy, Screen.sizeFromWidth(size: 13)))
                        .foregroundColor(Color("#F39C12"))
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: dWidth * 12/375)
                                    .fill(Color("#F39C12").opacity(0.19))
                                    .shadow(color: Color("#F39C12").opacity(0.09), radius: 10, x: 0, y: 4)
                                    .frame(width: dWidth * 89/375, height: dHeight * 26/875, alignment: .center)
                            })
                        .padding(.top, dWidth * 16/375)
                        .padding(.bottom, dWidth * 20/375)

                    //:Top Trainer Details
                    ViewAppointmentUserCard(date: booking?.date ?? "", time: booking?.time ?? "",image: booking?.users?.avatarUrl ?? "", name: booking?.users?.name ?? "", type: serviceName, phoneNumber: booking?.users?.phone ?? "")
                        .padding(.bottom, dWidth * 20/375)
                    
                    HStack {
                        Text("Dog Profile")
                            .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 16)))
                        .foregroundColor(Color("#C3C3C3"))
                        .padding(.leading, dWidth * 16/375)
                        Spacer()
                    }

                    ZStack {
                        RoundedRectangle(cornerRadius: dWidth * 10/375)
                            .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                            .foregroundColor(Color("#191919").opacity(0.26))
                            .frame(width: dWidth * 342.5/375, height: dWidth * 400/375)
                        
                        VStack(alignment: .leading, spacing: dWidth * 20/375) {
                            HStack {
                                Text(booking?.petProfile?.petName ?? "")
                                    .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 14)))
                                    .foregroundColor(Color.white)
                                Spacer()
                            } //:HStack
                            .padding(.bottom, dWidth * 10/375)
                            
//                            Text("Pet Name")
//                                .font(Font.custom("SFProText-Regular", size: dWidth * 12/375))
//                                .foregroundColor(Color("#848484"))
//                            Text("Coffee")
//                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
//                                .foregroundColor(Color("#C3C3C3"))
//                                .padding(.bottom, dWidth * 10/375)

                            HStack(spacing: dWidth * 40/375) {
                                Text("Breed")
                                    .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 12)))
                                    .foregroundColor(Color("#7E7E7E"))
                                Spacer()
                                Text("Age")
                                    .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 12)))
                                    .foregroundColor(Color("#7E7E7E"))
                                Text("Gender")
                                    .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 12)))
                                    .foregroundColor(Color("#7E7E7E"))
                                Spacer()
                            } //:HStack
                            .padding(.bottom, dWidth * 10/375)

                            HStack(spacing: dWidth * 40/375) {
                                Text(booking?.petProfile?.breed ?? "")
                                    .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 12)))
                                    .foregroundColor(Color.white)
                                    .lineLimit(1)
                                Text(booking?.petProfile?.age ?? "")
                                    .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 12)))
                                    .foregroundColor(Color.white)
                                Text(booking?.petProfile?.gender ?? "")
                                    .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 12)))
                                    .foregroundColor(Color.white)
                                Spacer()
                            } //:HStack
                            .padding(.bottom, dWidth * 10/375)

                            Text("Treatment History")
                                .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 12)))
                                .foregroundColor(Color("#7E7E7E"))
                            Text(booking?.petProfile?.treatment?[0].treatment ?? "")
                                .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 13)))
                                .foregroundColor(Color.white)
                                .padding(.bottom, dWidth * 10/375)

                            Text("Description")
                                .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 12)))
                                .foregroundColor(Color("#7E7E7E"))
                            Text(booking?.petProfile?._description ?? "")
                                .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 13)))
                                .foregroundColor(Color.white)
                        } //:VStack
                        .padding(dWidth * 33/375)
                    } //:ZStack
                    if booking?.status == "Pending" && status == ""{
                    NavigationLink (
                        destination: RequestBookingView().navigationBarHidden(true),
                        isActive: $isCompleteLinkActive,
                        label: {
                            ButtonCommon(buttonName: booking?.status == "Confirmed" ? "Confirmed" : "Confirm Appointment", someAction: {
//                                isCompleteLinkActive.toggle()
                                if booking?.status != "Cancel" && booking?.status != "Confirmed"{
                                vms.acceptBooking(id: "\(booking?._id ?? 0)") { success in
                                        status = "Confirmed"
                                }
                                }
                            })})
                        .padding(.top, dWidth * 30/375)
                    
                        NavigationLink (
                            destination: ChangePasswordView().navigationBarHidden(true),
                            isActive: $isCancelLinkActive,
                            label: {
                                ButtonCommonBlack(buttonName: booking?.status == "Cancel" ? "Canceled" : "Cancel Appointment", someAction: {
                                    if booking?.status != "Cancel"{
                                        vms.cancelBooking(id: "\(booking?._id ?? 0)") { success in
                                                status = "Cancel"
                                        }
                                    }
                                    
    //                                isCancelLinkActive.toggle()
                                }, color: "#FFFFFF")
                            })
                            .padding(.top, dWidth * 16/375)
                            .padding(.bottom, dWidth * 32/375)
                    }
                   
                    Spacer()
                }
            } //:VStack
            //            .padding(.horizontal, dWidth * 16/375)
        }.onAppear{
            booking?.trainer?.services?.forEach({ service in
                if service._id == Int(booking?.serviceId ?? ""){
                    self.serviceName = service.service ?? ""
                }
               
                
            })
        }
        
        //:ZStack
    }
}

struct ViewAppointmentView_Previews: PreviewProvider {
    static var previews: some View {
        ViewAppointmentView(vms: TrainerHomeVM())
    }
}
