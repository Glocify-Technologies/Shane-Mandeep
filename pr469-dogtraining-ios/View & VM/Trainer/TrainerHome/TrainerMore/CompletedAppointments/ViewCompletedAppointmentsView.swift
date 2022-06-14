//
//  ViewCompletedAppointmentsView.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-03-10.
//

import SwiftUI

struct ViewCompletedAppointmentsView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @State var isCompleteLinkActive: Bool = false
    @State var isCancelLinkActive: Bool = false
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavBarWithBackButtonTransparent(title: "View Completed Appointments") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView {


                    //:Top Trainer Details
                    ViewAppointmentUserCard(date: "Fri 19, Nov", time: "09:00 AM",image: "People 09", name: "Emily Watson", type: "Private Lesson", phoneNumber: "")
                        .padding(.bottom, dWidth * 20/375)
                    
                    HStack {
                        Text("Dog Profile")
                            .font(Font.custom("SFProText-SemiBold", size: dWidth * 16/375))
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
                                Text("Coffee")
                                    .font(Font.custom("SFProText-Bold", size: dWidth * 14/375))
                                    .foregroundColor(Color.white)
                                Spacer()
                            } //:HStack
                            .padding(.bottom, dWidth * 2/375)

                            HStack(spacing: dWidth * 40/375) {
                                Text("Breed")
                                    .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                    .foregroundColor(Color("#7E7E7E"))
                                Spacer()
                                Text("Age")
                                    .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                    .foregroundColor(Color("#7E7E7E"))
                                Text("Gender")
                                    .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                    .foregroundColor(Color("#7E7E7E"))
                                Spacer()
                            } //:HStack
                            .padding(.bottom, dWidth * 4/375)

                            HStack(spacing: dWidth * 40/375) {
                                Text("Border Collie")
                                    .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                    .foregroundColor(Color.white)
                                    .lineLimit(1)
                                Text("3 Years")
                                    .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                    .foregroundColor(Color.white)
                                Text("Male")
                                    .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                    .foregroundColor(Color.white)
                                Spacer()
                            } //:HStack
                            .padding(.bottom, dWidth * 10/375)

                            Text("Treatment History")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color("#7E7E7E"))
                            Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                                .foregroundColor(Color.white)
                                .padding(.bottom, dWidth * 10/375)

                            Text("Description")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 12/375))
                                .foregroundColor(Color("#7E7E7E"))
                            Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ")
                                .font(Font.custom("SFProText-SemiBold", size: dWidth * 13/375))
                                .foregroundColor(Color.white)
                        } //:VStack
                        .padding(dWidth * 33/375)
                        
                       
                       
                    
                       
                    } //:ZStack
                    
                    HStack{
                    Text("Amount Paid")
                            .padding(.leading, dWidth * 16/375)
                        Spacer()
                    Text("$100")
                            .padding(.trailing, dWidth * 16/375)

//                        .padding(.top, 0)
//                        .padding(.bottom, dWidth * 32/375)
                        
                    }
                    .font(Font.custom("SFProText-Regular", size: dWidth * 16/375))
                    .foregroundColor(Color.white)
                        .padding(.top, dWidth * 20/375)
                
                        
//
                }
            } //:VStack
                   // .padding(.horizontal, dWidth * 16/375)
                    
        } //:ZStack
        
      
    }
}

struct ViewCompletedAppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        ViewCompletedAppointmentsView()
    }
}
