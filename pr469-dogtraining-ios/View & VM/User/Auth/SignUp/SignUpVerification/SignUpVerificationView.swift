////
////  SignUpVerificationView.swift
////  pr469-dogtraining-ios
////
////  Created by Sachindra Fernando on 12/17/21.
////
//
import SwiftUI

struct SignUpVerificationView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @StateObject var vm = SignUpVerificationVM()
    @State var isCompleteLinkActiveUser: Bool = false
    @State var isCompleteLinkActiveTrainer: Bool = false
    @State var isFirstResponder = false
    @EnvironmentObject var viewModel : UserNavigate
    
    @FocusState private var vmCodeoneVal1: Bool
    @FocusState private var vmCodeoneVal2: Bool
    @FocusState private var vmCodeoneVal3: Bool
    @FocusState private var vmCodeoneVal4: Bool
    
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack{
                NavBarWithBackButton(title: "Sign Up") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                Text("Please enter your verification")
                    .font(.custom("SFProText-Regular", size: dWidth * 24/375))
                    .foregroundColor(Color.white)
                    .padding(.top, dWidth * 48/375)
                
                Text("The verification code has been sent to your dedicated email")
                    .font(.custom("SFProText-Regular", size: dWidth * 16/375))
                    .foregroundColor(Color.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, dWidth * 8/375)
                
                //MARK: - VERIFICATION CODE
                HStack {
                    TypeVerificationCode(textField: $vm.codeone)
                       .focused($vmCodeoneVal1)
                        .multilineTextAlignment(.center)
                        .background(
                            ZStack {
                                RoundedRectangle (cornerRadius: dWidth * 5/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                                RoundedRectangle (cornerRadius: dWidth * 5/375).stroke(Color("#00C600"),lineWidth: dWidth * 0.5/375)
                            })
                        .onReceive(vm.codeone.publisher.collect()) { Output in
                            if Output.count == 1 && vmCodeoneVal1 == true {
                                vmCodeoneVal1 = false
                                vmCodeoneVal2 = true
                                vmCodeoneVal3 = false
                                vmCodeoneVal4 = false
                            }
                        }
                    TypeVerificationCode(textField: $vm.codetwo)
                        .focused($vmCodeoneVal2)
                        .multilineTextAlignment(.center)
                        .background(
                            ZStack {
                                RoundedRectangle (cornerRadius: dWidth * 5/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                                RoundedRectangle (cornerRadius: dWidth * 5/375).stroke(Color("#00C600"),lineWidth: dWidth * 0.5/375)
                            })
                        .onReceive(vm.codetwo.publisher.collect()) { Output in
                            if Output.count == 1 && vmCodeoneVal2 == true {
                                //vmCodeoneVal3.toggle()
                                vmCodeoneVal1 = false
                                vmCodeoneVal2 = false
                                vmCodeoneVal3 = true
                                vmCodeoneVal4 = false
                            }
                        }
                    TypeVerificationCode(textField: $vm.codethree)
                        .focused($vmCodeoneVal3)
                        .multilineTextAlignment(.center)
                        .background(
                            ZStack {
                                RoundedRectangle (cornerRadius: dWidth * 5/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                                RoundedRectangle (cornerRadius: dWidth * 5/375).stroke(Color("#00C600"),lineWidth: dWidth * 0.5/375)
                            })
                        .onReceive(vm.codethree.publisher.collect()) { Output in
                            if Output.count == 1 && vmCodeoneVal3 == true {
                                vmCodeoneVal1 = false
                                vmCodeoneVal2 = false
                                vmCodeoneVal3 = false
                                vmCodeoneVal4 = true
                            }
                        }
                    TypeVerificationCode(textField: $vm.codefour)
                        .focused($vmCodeoneVal4)
                        .multilineTextAlignment(.center)
                        .background(
                            ZStack {
                                RoundedRectangle (cornerRadius: dWidth * 5/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                                RoundedRectangle (cornerRadius: dWidth * 5/375).stroke(Color("#00C600"),lineWidth: dWidth * 0.5/375)
                            })
                        .onReceive(vm.codefour.publisher.collect()) { Output in
                            print(Output)
                        }
                }
                .padding(.top, dWidth * 32/375)
                 
                //MARK: - NEXT BUTTON
                ButtonCommon(buttonName: "Next", someAction: {
                   
                    if vm.formValidationVerification() {
                        let code = Int(vm.codeone + vm.codetwo + vm.codethree + vm.codefour)
                        vm.verifyVerificationCode(code: code ?? 0){ success in
                            if viewModel.isUser  {
                                isCompleteLinkActiveUser = true
                            } else {
                                isCompleteLinkActiveTrainer =  true
                            }
                        }
                       
                       
                    }
                }).padding(.top, dWidth * 48/375)
                
                NavigationLink (
                    destination: CompleteProfileView(fullName: "").navigationBarHidden(true),
                    isActive: $isCompleteLinkActiveUser,
                    label: {})
                    .alert(isPresented: $vm.showAlert) {
                        Alert(title: Text(vm.alertTitle), message: Text(vm.alertMessage),primaryButton: .cancel(), secondaryButton: .default(Text("Ok")){
            //                isSigninLinkActive = true
                        })
                    }
                NavigationLink (
                    destination: ProfileInfoOne(text: "", fullName: "").navigationBarHidden(true),
                    isActive: $isCompleteLinkActiveTrainer,
                    label: {})
                Spacer()
                
                //MARK: - RESEND LINK
                HStack{
                    Text("Didn't receive the verification code?")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                    Button(action: {
                        print("Button action")
                        vm.verification { success in
                            print("")
                        }
                    }) {
                        Text("Resend")
                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                            .foregroundColor(Color("#00C600"))                    }
                    
//                    Text("Resend")
//                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                        .foregroundColor(Color("#00C600"))
                }
                .padding(.bottom, dWidth * 44/375)
            } //:VStack
        } //:ZStack
    }
}

struct SignUpVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpVerificationView()
    }
}
