//
//  ViewTrainerUserCard.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-11.
//

import SwiftUI
import SDWebImageSwiftUI

struct ViewTrainerUserCard: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    
    var image: String
    var name: String
    var address: String
    var phoneNum: String
    @State var profileImage: UIImage? = UIImage(systemName: "person.fill")!
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dWidth * 10/375)
                .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                .foregroundColor(Color.black.opacity(0.26))
            //.background(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                .frame(width: dWidth * 342.5/375, height: dWidth * 102.5/375)
            
            HStack(spacing: dWidth * 10/375) {
                WebImage(url: URL(string: image ))
                    .pausable(false)
                    .purgeable(true)
                    .resizable()
                    .placeholder(Image(uiImage: profileImage!).resizable())
                    .indicator(.activity) // Activity Indicator
                    .scaledToFill()
                    .frame(width: dWidth * 70/375, height: dHeight * 70/875, alignment: .center)
                    .cornerRadius(dWidth * 10/375)
                    .overlay(RoundedRectangle(cornerRadius: dWidth * 10/375)
                                .stroke(Color("#E3E3E3"), lineWidth: dWidth * 2/375))
                VStack(alignment: .leading, spacing: dWidth * 6/375) {
                    HStack {
                        Text(name)
                            .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                            .foregroundColor(Color.white)
                        Spacer()
                        Image("baseline_call_black_18pt_1x")
                            .resizable()
                            .frame(width: dWidth * 24/375, height: dHeight * 24/875, alignment: .center)
                            .foregroundColor(Color("#00C600"))
                            .padding(.trailing, 32)
                            .onTapGesture {
                                if phoneNum != ""{
                                    let telephone = "tel://"
                                     let formattedString = telephone + phoneNum
                                     guard let url = URL(string: formattedString) else { return }
                                     UIApplication.shared.open(url)
                                }
                               
                            }
                        
                    }
                    Text(address)
                        .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                        .foregroundColor(Color("#848484"))
                        .lineLimit(1)
                        .frame(width: dWidth * 232/375, height: dWidth * 20/375)
                } //:VStack
            } //:HStack
            .padding(.leading, dWidth * 32/375)
        } //:ZStack
    }
}

struct ViewAppointmentUserCard: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    
    var date: String
    var time: String
    var image: String
    var name: String
    var type: String
    var phoneNumber: String
    @State var profileImage: UIImage? = UIImage(systemName: "person.fill")!
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dWidth * 10/375)
                .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                .foregroundColor(Color.black.opacity(0.26))
            //.background(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                .frame(width: dWidth * 342.5/375, height: dWidth * 142.5/375)
            
            VStack(spacing: dWidth * 20/375) {
                HStack {
                    Text(date)
                        .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                        .foregroundColor(Color("#C3C3C3"))
                        .lineLimit(1)
//                        .frame(width: dWidth * 164/375, height: dWidth * 24/375)
                        .padding(.horizontal, dWidth * 40/375)
                    Spacer()
                    Text(time)
                        .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                        .foregroundColor(Color("#C3C3C3"))
                        .lineLimit(1)
                        .padding(.horizontal, dWidth * 40/375)

                }.background(
                    ZStack {
                        RoundedRectangle(cornerRadius: dWidth * 12/375)
                            .fill(Color("#434343").opacity(0.45))
                            .shadow(color: Color("#434343").opacity(0.09), radius: 10, x: 0, y: 4)
                            .frame(width: dWidth * 310/375, height: dWidth * 24/375)
                })


                HStack(spacing: dWidth * 10/375) {
                    WebImage(url: URL(string: image ))
                        .pausable(false)
                        .purgeable(true)
                        .resizable()
                        .placeholder(Image(uiImage: profileImage!).resizable())
                        .indicator(.activity) // Activity Indicator
                        .scaledToFill()
                        .frame(width: dWidth * 70/375, height: dHeight * 70/875, alignment: .center)
                        .cornerRadius(dWidth * 10/375)
                        .overlay(RoundedRectangle(cornerRadius: dWidth * 10/375)
                                    .stroke(Color("#E3E3E3"), lineWidth: dWidth * 2/375))
                    
                    VStack(alignment: .leading, spacing: dWidth * 6/375) {
                        HStack {
                            Text(name)
                                .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                                .foregroundColor(Color.white)
                            Spacer()
                            Image("baseline_call_black_18pt_1x")
                                .resizable()
                                .frame(width: dWidth * 24/375, height: dHeight * 24/875, alignment: .center)
                                .foregroundColor(Color("#00C600"))
                                .padding(.trailing, 32)
                                .onTapGesture {
                                    let telephone = "tel://"
                                     let formattedString = telephone + phoneNumber
                                     guard let url = URL(string: formattedString) else { return }
                                     UIApplication.shared.open(url)
                                }
                            
                        }
                        Text(type)
                            .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 14)))
                            .foregroundColor(Color("#00C600"))
                    } //:VStack
                } //:HStack
                .padding(.leading, dWidth * 32/375)
            }
        } //:ZStack
    }
}

struct ViewAppointmentUserCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            ViewAppointmentUserCard(date: "Fri 19, Nov", time: "09:00 AM",image: "People 09", name: "Emily Watson", type: "Private Lesson", phoneNumber: "")
        }
    }
}

struct ViewTrainerUserCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            ViewTrainerUserCard(image: "People 09", name: "Jhon Doe", address: "3 Farland Street, Brockton, MA 0240124685864668", phoneNum: "")
        }
    }
}
