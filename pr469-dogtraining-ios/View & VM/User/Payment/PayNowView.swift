//
//  PayNowView.swift
//  pr469-dogtraining-ios
//
//  Created by Sandaruwan Bamunusinghe on 2022-03-11.
//

import SwiftUI

struct PayNowView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let dWidth = UIScreen.main.bounds.width
    let dHeight = UIScreen.main.bounds.height
    var booking: Booking?
    @State var totalPrice = ""
    @State var isPayNowLinkActive = false
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                //Navigation view
                HStack(alignment: .center) {
                    Image("ic_back") // set back image
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width*28/375, height: UIScreen.main.bounds.width*28/375, alignment: .top)
                        .foregroundColor(.white)
                      .clipped()
                      .onTapGesture {
                          presentationMode.wrappedValue.dismiss()
                      }
                    
                        Spacer()
                        Text("Pay Now")
                        .font(Font.custom("SFProText-Semibold", size: UIScreen.main.bounds.width * 16/375))
                            .foregroundColor(Color.white)
                        Spacer()
                    Rectangle()
                        .fill(Color.clear)
                        .frame(width: UIScreen.main.bounds.width*28/375)
                    
                    }//HStack
                    .padding(.horizontal,12)
                    .frame(height:UIScreen.main.bounds.height*44/812)
                    .padding(.top, (UIDevice.modelName.contains("iPhone 8 Plus") || UIDevice.modelName.contains("iPhone 7") || UIDevice.modelName.contains("iPhone 7 Plus") || UIDevice.modelName.contains("iPhone 8") || UIDevice.modelName.contains("iPhone SE")) ? 26 : 40)
                
                Text("Please check the following details and process your payment")
                    .font(Font.custom("SFProText-Regular", size: UIScreen.main.bounds.width * 16/375))
                        .foregroundColor(Color.white)
                        .padding(.top, dHeight*24/812)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .padding(.horizontal, dWidth*24/375)
                        .padding(.bottom, dHeight*24/812)
                
                PayNowCardView(date:booking?.date ?? "", time: booking?.time ?? "",bookingDetail : booking)
                    .padding(.horizontal, dWidth*16/375)
                NavigationLink (
                    destination: PaymentCardView(totalCost:totalPrice,booking: booking).navigationBarHidden(true),
                    isActive: $isPayNowLinkActive,
                    label: {
                        ButtonCommon(buttonName: booking?.is_paid == "1" ? "Paid" : "Pay Now", someAction: {
                            isPayNowLinkActive.toggle()
                        })
                        .padding(.top, dHeight*30/812)
                    }
                )
               
                Spacer()
                
            }//VStack
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            
        }//ZStack
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])
        .navigationBarTitle("")
        .navigationBarHidden(true)
        .onAppear{
            booking?.trainer?.services?.forEach({ service in
                if booking?.serviceId == "\(service._id ?? 0)"{
                    totalPrice = service.pivot?.price ?? ""
            }
          
            })
             
        }
    }
}

struct PayNowView_Previews: PreviewProvider {
    static var previews: some View {
        PayNowView()
    }
}
