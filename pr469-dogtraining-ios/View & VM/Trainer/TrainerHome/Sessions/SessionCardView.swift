//
//  SessionCardView.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-03-10.
//

import SwiftUI
import SDWebImageSwiftUI
struct SessionCardView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    
    var image: String
    var name: String
    var detail: String
    var destination: AnyView
    var booking:Booking?
    @State var serviceName = ""
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
                            Text(serviceName)
                                .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                                .foregroundColor(Color("#00C600"))
                                .padding(.vertical, dWidth * 7/375)
                                .padding(.horizontal, dWidth * 16/375)
//                                .background(
//                                    ZStack {
//                                        Color("#F39C12").opacity(0.1)
//                                            .clipShape(Rounded(radius: Int(dWidth) * 10/375, edges: [.bottomLeft,.topRight]))
//                                            .shadow(color: Color("#F39C12").opacity(0.09), radius: 10, x: 0, y: 4)
//                                    })
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
            .onAppear{
                booking?.trainer?.services?.forEach({ service in
                    if service._id == Int(booking?.serviceId ?? ""){
                        self.serviceName = service.service ?? ""
                    }
                   
                    
                })
            }
        }
    }
}

struct SessionCardView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            UserCard(image: "People 09", name: "Jhon Doe", detail: "3 Farland Street, Brockton, MA… 02401", destination: AnyView(MyProfileView()))
        }
    }
}
