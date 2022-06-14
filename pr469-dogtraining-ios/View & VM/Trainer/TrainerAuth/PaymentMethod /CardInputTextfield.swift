//
//  CardInputTextfield.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 18/05/22.
//

import Foundation
import SwiftUI

struct CardInputTextfield: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])

    var title: String
    var placeHoleder: String
    var keyboard: UIKeyboardType
    var isValidation :Bool
    
    //MARK: - When user hit the submit button
    @Binding var isValidationRuntime :Bool
    
    //MARK: - textFiled
    @Binding var textFiled: String
    @State var isShowingValidation: Bool = false
    
    var body: some View {
        VStack(alignment: .leading){
           Text(title)
                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 16/375)
            
            HStack{
                TextField(placeHoleder, text: $textFiled)
                    .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                    .foregroundColor(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .keyboardType(keyboard)
                    .onChange(of: textFiled, perform: {
                        value in
                        isShowingValidation = true
                        
                        isValidationRuntime = true
                        if value.count == 4 || value.count == 9 || value.count == 14
                        {
                            textFiled += " "
                        }else if value.count > 19{
                            textFiled = String(value.prefix(19))
                        }
                    })
                
                if isValidationRuntime {
                    if isShowingValidation {
                        Button(action: {
                            if !isValidation{
                                textFiled = ""
                            }
                        }, label: {
                            Image(isValidation ? "outline_done_black_18pt_1x": "")
                                .resizable()
                                .foregroundColor(.white)
                                .frame(width: dWidth * 20/375, height: dWidth * 20/375)
                        })
                            .padding()
                    }
                }else {
                    Button(action: {
                        if isValidation{
                            textFiled = ""
                        }
                        isValidationRuntime.toggle()
                    }, label: {
                        Image("")
                            .resizable()
                            .foregroundColor(.white)
                            .frame(width: dWidth * 20/375, height: dWidth * 20/375)
                    })
                        .padding()
                }
                Spacer()
                //Image(systemName: "xmark.circle")
            }
            .background(
                ZStack {
                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                })
                .padding(.top,dWidth * 4/375)
            
        }//end VStack
    }
}

struct CardInputTextfield_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
            CardInputTextfield(title: "Hello World", placeHoleder: "Hello World", keyboard: .emailAddress, isValidation: true, isValidationRuntime: .constant(true), textFiled: .constant("Hello"))
        }
    }
}
