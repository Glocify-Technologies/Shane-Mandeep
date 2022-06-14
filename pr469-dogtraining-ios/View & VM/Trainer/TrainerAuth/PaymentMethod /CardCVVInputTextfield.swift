//
//  CardCVVInputTextfield.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 18/05/22.
//

import Foundation
import SwiftUI
struct CardCVVInputTextfield: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    
    var placeHoleder: String
    var name: String
    @Binding var textfiled: String
    @State var isToggle = false
    var keyboard: UIKeyboardType
    var body: some View {
        VStack(alignment: .leading){
            Text(name)
                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 16/375)
            
            HStack{
//                if self.isToggle{
//                    TextField(name, text: $textfiled)
//                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                        .foregroundColor(Color.white)
//                        .padding()
//                }
//                else{
                    SecureField(placeHoleder, text: $textfiled)
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                        .padding()
                        .onChange(of: textfiled) { newValue in
                            if newValue.count > 4
                            {
                                textfiled = String(newValue.prefix(4))
                            }
                        }
//                }
                
//                Button(action: {
//                    self.isToggle.toggle()
//                }, label: {
                    Image("info")
                        .resizable()
                        .foregroundColor(Color("#00C600"))
                        .frame(width: dWidth * 20/375, height: dWidth * 20/375)
//                })
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

struct CardCVVInputTextfield_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
            InputPasswordField(name: "Hello", textfiled: .constant(""))
        }
    }
}
