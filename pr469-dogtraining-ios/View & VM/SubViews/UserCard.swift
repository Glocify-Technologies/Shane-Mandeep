//
//  UserCard.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-07.
//

import SwiftUI
import SDWebImageSwiftUI

struct TrainerUserCard: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    
    var image: String
    var name: String
    var detail: String
    var destination: AnyView
    var booking:Booking?
    @State var profileImage: UIImage? = UIImage(systemName: "person.fill")!
    var body: some View {
        NavigationLink(destination: destination.navigationBarHidden(true)) {
            ZStack {
                HStack(alignment: .top, spacing: dWidth * 10/375) {
                    WebImage(url: URL(string: image ))
                        .pausable(false)
                        .purgeable(true)
                        .resizable()
                        .placeholder(Image(uiImage: profileImage!).resizable())
                        .indicator(.activity) // Activity Indicator
                        .scaledToFill()
                        .frame(width: dWidth * 70/375, height: dWidth * 70/375, alignment: .center)
                        .cornerRadius(dWidth * 10/375)
                        .overlay(RoundedRectangle(cornerRadius: dWidth * 10/375)
                                    .stroke(Color.white, lineWidth: dWidth * 2/375))
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .top) {
                            Text(name)
                                .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                                .foregroundColor(Color.white)
                                .padding(.top, dWidth * 15/375)
                                .padding(.bottom, dWidth * 7/375)
                            Spacer()
                            Text(booking?.status ?? "")
                                .font(.customFont(.SFProTextHeavy, Screen.sizeFromWidth(size: 13)))
                                .foregroundColor(Color("#F39C12"))
                                .padding(.vertical, dWidth * 7/375)
                                .padding(.horizontal, dWidth * 16/375)
                                .background(
                                    ZStack {
                                        Color("#F39C12").opacity(0.1)
                                            .clipShape(Rounded(radius: Int(dWidth) * 10/375, edges: [.bottomLeft,.topRight]))
                                            .shadow(color: Color("#F39C12").opacity(0.09), radius: 10, x: 0, y: 4)
                                    })
                        }
                        
                        Text(detail)
                            .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                            .foregroundColor(Color("#C3C3C3"))
                            .lineLimit(1)
                            .frame(width: dWidth * 175/375, height: dWidth * 24/375)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: dWidth * 12/375)
                                        .fill(Color("#434343").opacity(0.45))
                                        .shadow(color: Color("#434343").opacity(0.09), radius: 10, x: 0, y: 4)
                                })
                    } //:VStack
                } //:HStack
                .padding(.bottom, dWidth * 16/375)
                .background(
                    RoundedRectangle(cornerRadius: dWidth * 10/375)
                        .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                        .foregroundColor(Color.black.opacity(0.26))
                        .padding(.leading, dWidth * 13/375)
                )
            } //:ZStack
        }
    }
}

struct UserCard: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    
    var image: String
    var name: String
    var detail: String
    var destination: AnyView
    @State var profileImage: UIImage? = UIImage(systemName: "person.fill")!
    var body: some View {
        NavigationLink(destination: destination.navigationBarHidden(true)) {
            ZStack {
                RoundedRectangle(cornerRadius: dWidth * 10/375)
                    .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                    .foregroundColor(Color.black.opacity(0.26))
                //.background(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                    .frame(width: dWidth * 330.5/375, height: dWidth * 85.5/375)
                
                HStack(spacing: dWidth * 10/375) {
                    ZStack{
                        
                        RoundedRectangle(cornerRadius: dWidth * 10/375)
                        
                            .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                        
                            .foregroundColor(Color.black.opacity(0.26))
                        
                            .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                        WebImage(url: URL(string: image ))
                            .pausable(false)
                            .purgeable(true)
                            .resizable()
                            .placeholder(Image(uiImage: profileImage!).resizable())
                            .indicator(.activity) // Activity Indicator
                            .scaledToFill()
                            .frame(width: dWidth * 102/375, height: dWidth * 102/375, alignment: .center)
                            .cornerRadius(dWidth * 10/375)
                           
                    }

                    VStack(alignment: .leading, spacing: dWidth * 10/375) {
                        Text(name)
                            .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                            .foregroundColor(Color.white)
                        
                        Text(detail)
                            .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                            .foregroundColor(Color.white)
                            .lineLimit(1)
                            .frame(width: dWidth * 230/375, height: dWidth * 24/375)
//                            .padding(.horizontal, dWidth * 5/375)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: dWidth * 12/375)
                                        .fill(Color("#434343").opacity(0.45))
                                        .shadow(color: Color("#434343").opacity(0.09), radius: 10, x: 0, y: 4)
                                })
                        
                    } //:VStack
                } //:HStack
                .offset(x: -15, y: -10)
            } //:ZStack
        }
    }
}

struct AppointmentUserCard: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    
    var image: String
    var name: String
    var detail: String
    var destination: AnyView
    
    var body: some View {
        NavigationLink(destination: destination.navigationBarHidden(true)) {
            ZStack {
                HStack(alignment: .top, spacing: dWidth * 10/375) {
                    Image(image)
                        .resizable()
                        .frame(width: dWidth * 70/375, height: dWidth * 70/375, alignment: .center)
                        .cornerRadius(dWidth * 10/375)
                        .overlay(RoundedRectangle(cornerRadius: dWidth * 10/375)
                                    .stroke(Color.white, lineWidth: dWidth * 2/375))
                    
                    VStack(alignment: .leading, spacing: 0) {
                        HStack(alignment: .top) {
                            Text(name)
                                .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                                .foregroundColor(Color.white)
                                .padding(.top, dWidth * 15/375)
                                .padding(.bottom, dWidth * 7/375)
                            Spacer()
                        }
                        
                        Text(detail)
                            .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                            .foregroundColor(Color("#C3C3C3"))
                            .lineLimit(1)
                            .frame(width: dWidth * 175/375, height: dWidth * 24/375)
                            .background(
                                ZStack {
                                    RoundedRectangle(cornerRadius: dWidth * 12/375)
                                        .fill(Color("#434343").opacity(0.45))
                                        .shadow(color: Color("#434343").opacity(0.09), radius: 10, x: 0, y: 4)
                                })
                    } //:VStack
                } //:HStack
                .padding(.bottom, dWidth * 16/375)
                .background(
                    RoundedRectangle(cornerRadius: dWidth * 10/375)
                        .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                        .foregroundColor(Color.black.opacity(0.26))
                        .padding(.leading, dWidth * 13/375)
                )
            } //:ZStack
        }
    }
}

struct AppointmentUserCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            AppointmentUserCard(image: "People 09", name: "Jhon Doe", detail: "Fri 19, Nov  |  09:00 AM", destination: AnyView(MyProfileView()))
        }
    }
}

struct TrainerUserCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            TrainerUserCard(image: "People 09", name: "Jhon Doe", detail: "Fri 19, Nov  |  09:00 AM", destination: AnyView(MyProfileView()))
        }
    }
}

struct UserCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            UserCard(image: "People 09", name: "Jhon Doe", detail: "3 Farland Street, Brockton, MA… 02401", destination: AnyView(MyProfileView()))
        }
    }
}
