//
//  BusinessDetails.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-11.
//

import SwiftUI

struct BusinessDetails: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    let servicesList = [["lesson": "Private Lessons","rate":"$100/per hour"], ["lesson":"Virtual Lessons","rate":"$90/per hour"], ["lesson":"Group Lessons","rate":"$70/per hour"], ["lesson":"Boarding & Training", "rate":"$100/per hour"]]
    @State var trainerData: Trainer?
    var body: some View {
        ZStack(alignment: .top) {
            
            VStack(alignment: .leading, spacing: dWidth * 6/375) {
                
                HStack{
                VStack(alignment: .leading){
                Text("Business Name")
                        .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                    .foregroundColor(Color("#848484"))
                    .padding(.bottom, 2)
                    
                    Text(trainerData?.businessName ?? "")
                        .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                    .foregroundColor(Color.white)
                    
                Text("Services Provided")
                        .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 12)))
                    .foregroundColor(Color("#848484"))
                    .padding(.top, dWidth * 16/375)
                    .padding(.bottom, 2)
                
                    VStack(alignment: .leading, spacing: 8) {
                        ScrollView(showsIndicators: false){
                                LazyVStack{
                                    ForEach((0..<(trainerData?.services!.count)! ), id: \.self) { id in
                                        HStack{
                                            Text(trainerData?.services?[id].service ?? "")
                                                .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                                                .foregroundColor(Color.white)
                                                .lineLimit(1)
                                                .padding(.leading, dWidth * 12/375)
                                                
                                            Spacer()
                                            Text("$\(trainerData?.services?[id].pivot?.price ?? "")")
                                                .font(.customFont(.SFProTextMedium, Screen.sizeFromWidth(size: 13)))
                                                .foregroundColor(Color.white)
                                                .lineLimit(1)
                                                .padding(.trailing, dWidth * 12/375)
                                        }//HStack
                                        .frame(width: dWidth * 300/375, height: dWidth * 30/375)
                                        .cornerRadius(dWidth * 100/375)
                                        .background(
                                            ZStack {
                                                RoundedRectangle(cornerRadius: dWidth * 22/375)
                                                    .fill(Color("#434343").opacity(0.45))
                                                    .shadow(color: Color("#434343").opacity(0.09), radius: 10, x: 0, y: 4)
                                            })
                                        .padding(.bottom, 2)
                                    }//ForEach
                                }//LazyVStack
                            }//ScrollView
                }
                Spacer()
            }//VStack
                .padding(.all, 14)
                    Spacer()
            }//HStack
            } //:VStack
            .frame(width: dWidth * 342.5/375, height: dWidth * 278/375)
            .background(RoundedRectangle(cornerRadius: dWidth * 10/375)
                            .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                            .foregroundColor(Color.black.opacity(0.26))
                            
            )
        } //:ZStack
    }
}

struct BusinessDetails_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            BusinessDetails()
        }
    }
}
