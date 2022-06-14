//
//  PhoneNumberField.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/20/21.
//

import SwiftUI

struct PhoneNumberField: View {
    var title: String
    @Binding var textFiled: String
    var keyboard: UIKeyboardType
    
    var body: some View {
        VStack(alignment: .leading){
            Text(title)
                 .foregroundColor(Color.white)
                 .padding(.horizontal)
                 .font(ManropeMediumCustom(size: 14))
            
            HStack{
                HStack{
                    Image("img_signup_flags_aus")
                    Text("+61")
                    .font(.custom("Poppins-Medium", size: 12))
                }
                .frame(height: 44)
                .padding(.horizontal,15)
                .overlay(RoundedRectangle(cornerRadius: 2.0).stroke(Color("backgroundBorder"), lineWidth: 1.0))
                
                TextField("236618300", text: $textFiled)
                    .foregroundColor(Color("#212322"))
                    .font(Font.custom("Manrope-SemiBold", size: 14))
                    .frame(height: 44)
                    .padding(.leading,15)
                    .background(Color.white)
                    .cornerRadius(2)
                    .overlay(RoundedRectangle(cornerRadius: 2.0).stroke(Color("backgroundBorder"), lineWidth: 1.0))
                    .shadow(color: Color("loginShadow"), radius: 10)
                    .keyboardType(.numberPad)
            }
        }
    }
}

struct PhoneNumberField_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberField(title: "", textFiled: .constant(""), keyboard: .default)
    }
}
