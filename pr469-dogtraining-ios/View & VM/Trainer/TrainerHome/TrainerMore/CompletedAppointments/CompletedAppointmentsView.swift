//
//  CompletedAppointmentsView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-10.
//

import SwiftUI

struct CompletedAppointmentsView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @StateObject var vm = ForgotPasswordVM()
    @State var isLoginLinkActive: Bool = false
    
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack{
                NavBarWithBackButton(title: "Completed Appointments") {
                    presentationMode.wrappedValue.dismiss()
                }
                ZStack {
                    RoundedRectangle(cornerRadius: dWidth * 26/375)
                        .foregroundColor(Color.black.opacity(0.12))
                        .frame(width: dWidth * 343.5/375, height: dWidth * 64.5/375)
                    SearchBar(text: .constant("Search"), searching: .constant(false), vms: HomeVM())
                } //:ZStack
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: dWidth * 20/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                        RoundedRectangle (cornerRadius: dWidth * 20/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 0.5/375)
                    })
                
                ScrollView {
                    VStack {
                        AppointmentUserCard(image: "People 09", name: "Sonya Medison", detail: "Fri 19, Nov  |  09:00 AM", destination: AnyView(ViewCompletedAppointmentsView()))
                        AppointmentUserCard(image: "People 05", name: "Emily Wilson", detail: "Fri 19, Nov  |  09:00 AM", destination: AnyView(ViewCompletedAppointmentsView()))
                        AppointmentUserCard(image: "People 04", name: "Ricky", detail: "Fri 19, Nov  |  09:00 AM", destination: AnyView(ViewCompletedAppointmentsView()))
                        Spacer()
                    } //:VStack
                }
                .padding(dWidth * 16/375)
            } //:VStack
        } //:ZStack
    }
}

struct CompletedAppointmentsView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedAppointmentsView()
    }
}
