//
//  ManagePaymentView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-10.
//

import SwiftUI

struct ManagePaymentView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @StateObject var vm = ForgotPasswordVM()
    @State var isLoginLinkActive: Bool = false
    @State var isDataEmptyActive: Bool = true
    @State var Message: String = ""
  
    @State var profileImage: UIImage? = UIImage(systemName: "person.fill")!
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack{
                NavBarWithBackButton(title: "Manage Payment Method") {
                    presentationMode.wrappedValue.dismiss()
                }
                if isDataEmptyActive == false{
                
                HStack(spacing: dWidth * 16/375) {
                    Image(uiImage: profileImage!)
                        .resizable()
                        .frame(width: dWidth * 52/375, height: dWidth * 52/375, alignment: .center)
                        .cornerRadius(dWidth * 10/375)
                        .overlay(RoundedRectangle(cornerRadius: dWidth * 10/375)
                        .stroke(Color.white, lineWidth: dWidth * 2/375))
                    Text(vm.userEmail)
                        .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                        .foregroundColor(Color.white)
                    Spacer()
                    Image("baseline_close_black_12pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .foregroundColor(Color("#E84118"))
                        .padding(.trailing, dWidth * 16/375)
                        .onTapGesture {
                            print("")
                            vm.deletTrainerMethods(paymentMethodId: vm.userId) { success in
                                print("Success")
                                vm.getTrainersPaymentMethods { success,data  in
                                    print(vm.methods as Any)
                                    if data?.payload == ""{
                                        isDataEmptyActive = true
                                        Message = data?.message ?? ""
                                    }else{
                                        isDataEmptyActive = false
                                    }
                                    
                                }
                            }
                        }
                }
                .padding(dWidth * 5/375)
                .background(
                    RoundedRectangle(cornerRadius: dWidth * 10/375)
                        .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                        .foregroundColor(Color.black.opacity(0.26))
                )
                .padding(dWidth * 16/375)
                }else{
                    HStack(alignment:.center,spacing: dWidth * 16/375) {
                        Text(Message)
                        
                    }.padding(dWidth * 5/375)
                        .padding(.top,dWidth-100)
                }
                Spacer()
            } //:VStack
        } //:ZStack as Any
        .onAppear {
            vm.getTrainersPaymentMethods { success,data  in
                print(vm.methods as Any)
                if data?.payload == ""{
                    isDataEmptyActive = true
                    Message = data?.message ?? ""
                }else{
                    isDataEmptyActive = false
                    
                }
            }
        }
    }
}

struct ManagePaymentView_Previews: PreviewProvider {
    static var previews: some View {
        ManagePaymentView()
    }
}
