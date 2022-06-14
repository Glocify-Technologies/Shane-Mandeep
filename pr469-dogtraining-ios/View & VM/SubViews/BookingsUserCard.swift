//
//  BookingsUserCard.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-10.
//

import SwiftUI
import SDWebImageSwiftUI
struct BookingsUserCard: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325-1"), Color("#191919-2")])
    @State var isCompleteLinkActive: Bool = false
    
//    var index: Int
    @State private var chatView = false
    @State private var offset = CGFloat(0.0)
    @State private var restingOffset = CGFloat(0.0)
    @GestureState private var isDragging = false

    var date: String
    var time: String
    var image: String
    var name: String
    var centre: String
    var address: String
    var isPaid: String
    var onDelete: () -> ()
    var onPaymentAction: (Bool)->()
    
    @State var showAlert = false
    @State var alertTitle = ""
    @State var alertMessage = ""
    @State var profileImage: UIImage? = UIImage(systemName: "person.fill")!
    var body: some View {
        ZStack {
            HStack {
                Spacer()
                Button(
                    action: {
                        offset = 0
                        restingOffset = 0
                        onDelete()
                    },
                    label: {
                        VStack {
                            Image("baseline_close_black_12pt_1x")
                                .resizable()
                                .foregroundColor(Color.black)
                                .frame(width: dWidth * 28/375, height: dWidth * 28/375)
                                .background(
                                    RoundedRectangle(cornerRadius: 14).fill(Color("#E84118"))
                            )
                            Text("Cancel")
                                .font(Font.custom("SFProText-Regular", size: dWidth * 14/375))
                                .foregroundColor(Color("#E84118"))
                        }
                    }
                )
            }.padding(.horizontal, dWidth * 30/375)

                    VStack(spacing: dWidth * 16/375) {
                        HStack {
                            Text(date)
                                .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                                .foregroundColor(Color("#C3C3C3"))
                                .lineLimit(1)

                            Spacer()
                            Text(time)
                                .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                                .foregroundColor(Color("#C3C3C3"))
                                .lineLimit(1)
                        }
                        .padding(.horizontal, dWidth * 10/375)
                        .padding(.vertical, dWidth * 4/375)
                        .background(
                            ZStack {
                                RoundedRectangle(cornerRadius: dWidth * 12/375)
                                    .fill(Color("#434343").opacity(0.45))
                                    .shadow(color: Color("#434343").opacity(0.09), radius: 10, x: 0, y: 4)
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
                                NavigationLink (
                                    destination: ViewTrainerView().navigationBarHidden(true),
                                    isActive: $isCompleteLinkActive,
                                    label: {
                                Text(name)
                                            .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                                    .foregroundColor(Color.white)
                                    })
                                Text(centre)
                                    .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                                    .foregroundColor(Color("#00C600"))
                                
                                HStack {
                                    Image("baseline_place_black_18pt_1x")
                                        .resizable()
                                        .frame(width: dWidth * 14/375, height: dHeight * 14/875, alignment: .center)
                                        .foregroundColor(Color("#00C600"))
                                    
                                    Text(address)
                                        .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                                        .foregroundColor(Color("#848484"))
                                        .lineLimit(1)
                                } //:HStack
                            } //:VStack
                        } //:HStack
                        
                        HStack{
                            
                            HStack {
                                Spacer()
                                Text("Pay Later")
                                Spacer()
                            }
                            .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 13)))
                            .foregroundColor(Color("#5CFF5C"))
                            .padding(.vertical, dWidth * 7/375)
                            .background( Color.clear)
                            .overlay(
                                RoundedRectangle(cornerRadius: dWidth * 14/375)
                                    .stroke(Color("#5CFF5C"), lineWidth: 1)
                                    .shadow(color: Color("#7E7E7E"), radius: 6, x: 0, y: 2)
                            )
                        .cornerRadius(dWidth * 14/375)
                        .onTapGesture {
                            onPaymentAction(true)
                        }
                            
                            Spacer()
                            
                        HStack {
                            Spacer()
                            Text(isPaid == "1" ? "Paid" : "Pay Now")
                            Spacer()
                        }
                        .font(.custom("SFProText-Semibold", size: dWidth * 13/375))
                        .foregroundColor(.white)
                        .padding(.vertical, dWidth * 7/375)
                        .background( Color( "#00A100"))
                        .overlay(
                            RoundedRectangle(cornerRadius: dWidth * 14/375)
                                .stroke(Color("#5CFF5C"), lineWidth: 1)
                                .shadow(color: Color("#7E7E7E"), radius: 6, x: 0, y: 2)
                        )
                    .cornerRadius(dWidth * 14/375)
                    .onTapGesture {
                        onPaymentAction(false)
                    }
                            
                        }
                        
                    } //:VStack
                    .padding(dWidth * 16/375)
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text(alertTitle),
                            message: Text(alertMessage),
                            dismissButton: .default(Text("Okay"), action: {
                                
                            })
                        )
                    }
                    .background(
                        ZStack {
                            RoundedRectangle(cornerRadius: dWidth * 10/375)
                                .fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                            RoundedRectangle(cornerRadius: dWidth * 10/375)
                                .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                            .foregroundColor(Color.black.opacity(0.26))
                        }
                    )
//            })
                .offset(x: offset)
                .gesture(
                    DragGesture()
                        .updating($isDragging, body: { value, state, _ in
                            state = true
                        })
                        .onChanged({ value in
                            onUpdating(value: value)
                        })
                        .onEnded({ value in
                            onEnded(value: value)
                        })
                )
        }//Zstack
        
    }
    func onUpdating(value: DragGesture.Value) {
        if value.translation.width < 0 && isDragging {//&& value.translation.width >= -85{
            offset = restingOffset + value.translation.width
        }
    }
    
    func onEnded(value: DragGesture.Value) {
        withAnimation {
            if value.translation.width <= -130 {
                offset = -120
                restingOffset = -120
            } else {
                offset = 0
                restingOffset = 0
            }
        }
        
    }
}

struct BookingsUserCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            BookingsUserCard(date:"Wed 27, Oct", time: "11.00 AM", image: "People 09", name: "Alison Cara", centre: "Dog Training Centre", address: "3 Farland Street, Brockton, MA 02401", isPaid:"", onDelete: {}, onPaymentAction: {_ in })
        }
    }
}
