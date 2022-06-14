//
//  ProfileInfoOne.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/17/21.
//

import SwiftUI

struct ProfileInfoOne: View {
    @State var fullName: String
    @State var fullNameValidation = false
    @StateObject var vm = ProfileInfoVM()
    @State var isProfileTwoActive = false
    var body: some View {
        ZStack{
          backgroundColor
            VStack{
                HeaderView(headerName: "Complete Your Profile")
                GeometryReader{ geometry in
                    ScrollView(.vertical, showsIndicators: true){
                        VStack(alignment: .center, spacing: 20){
                            //MARK: - FULL NAME
                            InputTextField(title: "Full Name", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.fullNameText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.fullNameText)
                                .validate(with: vm.fullNameText, validation: Validators().nonEmptyValidator)
                            
                            //MARK: - MOBILE
                            
                            //MARK: - BUSINESS NAME
                            InputTextField(title: "Business Name", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.fullNameText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.fullNameText)
                                .validate(with: vm.fullNameText, validation: Validators().nonEmptyValidator)
                            //MARK: - BUSINESS LOCATION
                            InputTextField(title: "Business Location", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.fullNameText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.fullNameText)
                                .validate(with: vm.fullNameText, validation: Validators().nonEmptyValidator)
                            //MARK: - BUSINESS PHONE NUMBER
                            
                            //MARK: - WEBSITE
                            InputTextField(title: "Website", keyboard: .default, isValidation: Validators().nonEmptyValidator(value: vm.fullNameText).isSuccess, isValidationRuntime: $vm.fullNameValidation, textFiled: $vm.fullNameText)
                                .validate(with: vm.fullNameText, validation: Validators().nonEmptyValidator)
                            //MARK: - SERVICES
                            
                            //MARK: - IMAGES
                            
                            //MARK: - NEXT BUTTON
                            NavigationLink(destination: ProfileInfoTwo(),
                                           isActive: $isProfileTwoActive,
                                           label: {
                                ButtonCommon(buttonName: "Next", someAction: {
                                    isProfileTwoActive.toggle()
                                })
                            })
                            
                        }
                    }
                    
                }
            }//end Vstack
        }//end ZStack
        .edgesIgnoringSafeArea(.all)
    }
}

struct ProfileInfoOne_Previews: PreviewProvider {
    static var previews: some View {
        ProfileInfoOne(fullName: "")
    }
}
