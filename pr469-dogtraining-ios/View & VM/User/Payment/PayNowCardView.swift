//
//  PayNowCardView.swift
//  pr469-dogtraining-ios
//
//  Created by Sandaruwan Bamunusinghe on 2022-03-11.
//

import SwiftUI

struct PayNowCardView: View {
    let dWidth = UIScreen.main.bounds.width
    let dHeight = UIScreen.main.bounds.height
    let buttonGradient = Gradient(colors: [Color("#232325-1"), Color("#191919-2")])
    var date: String
    var time: String
    @State var serviceName: String? = ""
    @State var servicePrice: String? = ""
    var bookingDetail: Booking?
    var body: some View {
        ZStack {

                    VStack(spacing: dWidth * 16/375) {
                        HStack {
                            Text(date)
                                .font(Font.custom("SFProText-Regular", size: dWidth * 13/375))
                                .foregroundColor(Color("#C3C3C3"))
                                .lineLimit(1)
                                .multilineTextAlignment(.leading)

                            Spacer()
                            Text(time)
                                .font(Font.custom("SFProText-Regular", size: dWidth * 13/375))
                                .foregroundColor(Color("#C3C3C3"))
                                .lineLimit(1)
                                .multilineTextAlignment(.trailing)
                                .padding(.trailing, 12)
                        }
                        .padding(.horizontal, dWidth * 10/375)
                        .padding(.vertical, dWidth * 4/375)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: dWidth * 12/375)
                                    .fill(Color("#434343").opacity(0.45))
                                    .shadow(color: Color("#434343").opacity(0.09), radius: 10, x: 0, y: 4)
                            })
                        
            
            VStack( spacing: 10){
                HStack{
                    Text("Trainer Name")
                        .font(Font.custom("SFProText-Regular", size: dWidth * 13/375))
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                    Spacer()
                    Text(bookingDetail?.trainer?.users?.name ?? "")
                        .font(Font.custom("SFProText-Semibold", size: dWidth * 13/375))
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                }
                
                HStack{
                    Text("Cost per/HR - " + "\(serviceName ?? "")")
                        .font(Font.custom("SFProText-Regular", size: dWidth * 13/375))
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                    Spacer()
                    Text("$\(servicePrice ?? "")")
                        .font(Font.custom("SFProText-Semibold", size: dWidth * 13/375))
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                }
                
                HStack{
                    Text("Total Cost")
                        .font(Font.custom("SFProText-Regular", size: dWidth * 16/375))
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                    Spacer()
                    Text("$\(servicePrice ?? "")")
                        .font(Font.custom("SFProText-Semibold", size: dWidth * 16/375))
                        .foregroundColor(Color.white)
                        .lineLimit(1)
                }
            }
                    }//VStack
                        
                    } //:ZStack
                    .padding(dWidth * 16/375)
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: dWidth * 10/375)
                                .fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                            RoundedRectangle(cornerRadius: dWidth * 10/375)
                                .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                            .foregroundColor(Color.black.opacity(0.26))
                        }
                    )
                    .onAppear{
                        bookingDetail?.trainer?.services?.forEach({ service in
                            if bookingDetail?.serviceId == "\(service._id ?? 0)"{
                                serviceName = service.service ?? ""
                                servicePrice = service.pivot?.price ?? ""
                        }
                      
                        })
                         
                    }
        
//            })
        }//Zstack
        
    }


struct PayNowCardView_Previews: PreviewProvider {
    static var previews: some View {
        PayNowCardView(date: "\(Date())", time: "2:54 PM", serviceName: "", servicePrice:"")
    }
}
