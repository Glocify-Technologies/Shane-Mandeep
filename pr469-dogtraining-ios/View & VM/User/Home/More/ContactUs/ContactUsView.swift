//
//  ContactUsView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-17.
//

import SwiftUI

struct ContactUsView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @StateObject var vm = ContactUsVM()
    @State var email : String = ""
    @State var userMessage: String = ""
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavBarWithBackButton(title: "Contact Us") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Text("Have a question? \nGet in touch and we’ll get back to you.")
                    .font(.custom("SF Pro Semibold", size: dWidth * 16/375))
                    .foregroundColor(Color.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .padding(.top, dWidth * 32/375)
                
                HStack {
                    Text("Message")
                        .font(.custom("SF Pro Semibold", size: dWidth * 16/375))
                        .foregroundColor(Color.white)
                        .padding(.top, dWidth * 24/375)
                        .padding(.leading, dWidth * 32/375)
                    Spacer()
                }
                
                TextEditor(text: $userMessage)
                    .background(Color.clear)
                    .navigationTitle("About you")
                    .foregroundColor(Color.white)
                    .frame(width: dWidth * 342/375, height: dWidth * 224/375)
                    .cornerRadius(10)
                    .onAppear{
                        UITextView.appearance().backgroundColor = .clear
                    }
//                    .colorMultiply(Color("#191919"))
                    .background(
                        ZStack {
                            RoundedRectangle (cornerRadius: dWidth * 10/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                            RoundedRectangle (cornerRadius: dWidth * 10/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 0.5/375)
                            
                            
                        })
                ButtonCommon(buttonName: "Submit", someAction: {
                    // Form Validation
                    if vm.formValidationContactUs(userMessage: userMessage) {
                        vm.contactUs(userMessage: userMessage) { success in
                            if success {
                                
                            }
                        }
                    }
                })
                    .padding(.top, dWidth * 24/375)
                
                Spacer()
                ContactUsButtonView(text: "Call Us", image: "baseline_call_black_18pt_1x", destination: AnyView(ContactUsView()))
                    .padding(.bottom, dWidth * 16/375)
                
                ContactUsButtonView(text: "Visit Our Website", image: "outline_open_in_new_black_12pt_1x", destination: AnyView(ContactUsView()))
                    .padding(.bottom, dWidth * 67/375)
            } //:VStack
        }.alert(isPresented: $vm.showAlert) {
            Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage),primaryButton: .cancel(), secondaryButton: .default(Text("Ok")){
//                isSigninLinkActive = true
            })
        }
        //:ZStack
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}
