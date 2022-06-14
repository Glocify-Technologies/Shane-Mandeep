//
//  UserTypeView.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/17/21.
//

import SwiftUI

struct UserTypeView: View {
    @State var isSelected = 0
    @State var isUserTapped = false
    @State var isTrainerTapped = false
    
    var body: some View {
        ZStack{
            Image("bg_img_intro")
                .resizable()
                .scaledToFill()
            VStack{
                HeaderView(headerName: "Sign Up")
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(alignment: .center, spacing: 20){
                            Text("LOGO \nHERE")
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(Color.green)
                                .font(.system(size: 45, weight: .bold))
                            
                            Text("Select Account Type")
                                .font(ManropeBoldCustom(size: 17))
                                .foregroundColor(.white)
                            //MARK: - SELECT USER TYPE
                            HStack{
                                //type user
                                NavigationLink(destination: SignupView(), isActive: $isUserTapped){
                                    Button(action: {
                                        self.isSelected = 1
                                    }, label: {
                                        Text("User")
                                            .font(ManropeBoldCustom(size: 15))
                                            .foregroundColor(.white)
                                            .frame(width: 150, height: 75)
                                            .cornerRadius(5.0)
                                            .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(isSelected == 1 ? Color.green : Color.white, lineWidth: 1.0))
                                    })
                                }

                                //type trainer
                                NavigationLink(destination: SignupView(), isActive: $isTrainerTapped){
                                    Button(action: {
                                        self.isSelected = 2
                                    }, label: {
                                        Text("Trainer")
                                            .font(ManropeBoldCustom(size: 15))
                                            .foregroundColor(.white)
                                            .frame(width: 150, height: 75)
                                            .cornerRadius(5.0)
                                            .overlay(RoundedRectangle(cornerRadius: 8.0).stroke(isSelected == 2 ? Color.green : Color.white, lineWidth: 1.0))
                                    })
                                }
                            }//end Hstack
                            
                            Spacer()
                            
                            //MARK: - SIGN UP BUTTON
                            ButtonCommon(buttonName: "Sign Up", someAction: {
                                if isSelected == 1{
                                    self.isUserTapped = true
                                }else if isSelected == 2{
                                    self.isTrainerTapped = true
                                }
                            })
                        }
                    }//end ScrollV
                    
                }//end geo
            }//end VStack
        }//end ZStack
        .edgesIgnoringSafeArea(.all)
    }
}

struct UserTypeView_Previews: PreviewProvider {
    static var previews: some View {
        UserTypeView()
    }
}
