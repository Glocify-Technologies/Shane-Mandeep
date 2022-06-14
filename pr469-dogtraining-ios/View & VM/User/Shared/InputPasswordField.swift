//
//  InputPasswordField.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/16/21.
//

import SwiftUI

struct InputPasswordField: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    
    
    var name: String
    @Binding var textfiled: String
    @State var isToggle = false
    
    var body: some View {
        VStack(alignment: .leading){
            Text(name)
                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 16/375)
            
            HStack{
                if self.isToggle{
                    TextField(name, text: $textfiled)
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                        .padding()
                }
                else{
                    SecureField(name, text: $textfiled)
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                        .padding()
                }
                
                Button(action: {
                    self.isToggle.toggle()
                }, label: {
                    Image(self.isToggle ? "outline_visibility_off_black_20pt_1x": "outline_visibility_black_18pt_1x")
                        .resizable()
                        .foregroundColor(Color("#00C600"))
                        .frame(width: dWidth * 20/375, height: dWidth * 20/375)
                })
                    .padding()
            } //:HStack
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .background(
                ZStack {
                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                })
            .padding(.top,dWidth * 5/375)
            
        }//end VStack
    }
}

struct InputPasswordField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
            InputPasswordField(name: "Hello", textfiled: .constant(""))
        }
    }
}
