//
//  PaymentCardView.swift
//  pr469-dogtraining-ios
//
//  Created by Sandaruwan Bamunusinghe on 2022-03-11.
//

import SwiftUI

struct PaymentCardView: View {
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let dWidth = UIScreen.main.bounds.width
    let dHeight = UIScreen.main.bounds.height
    @ObservedObject var vm = PaymentMethodVM()
    @State var isPayNowLinkActive = false
    @State var cards = [Cards]()
    @State var selectedCardId = ""
    @State var totalCost = ""
    var booking: Booking?
    @State var isAddCardLinkActive = false
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @State var profileImage: UIImage? = UIImage(systemName: "person.fill")!
    let servicesList = [["lesson": "6666 XXXX XXXX 8877","rate":"$100/per hour"], ["lesson":"6666 XXXX XXXX 8877","rate":"$90/per hour"], ["lesson":"6666 XXXX XXXX 8877","rate":"$70/per hour"], ["lesson":"6666 XXXX XXXX 8877", "rate":"$100/per hour"]]
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment:.leading){
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
                Text("Payment Methods")
                    .font(Font.custom("SFProText-Semibold", size: UIScreen.main.bounds.width * 16/375))
                    .foregroundColor(Color.white)
                    .padding([.leading,.trailing],UIScreen.main.bounds.width * 16/375)
                //                List {
                ScrollView(showsIndicators: false){
                    LazyVStack{
                        ForEach(0..<cards.count, id: \.self) { i in
                            PaymentView(isShow:false,name:"CVC",placeHoleder: "XXXX", textField:.constant(""),cvcTxt:$vm.CVC, index: i,cards:cards, cardId: $selectedCardId)
                        }.listRowBackground(Color.clear)
                    }
                    VStack(alignment:.leading){
                        Text("Other Methods")
                            .font(Font.custom("SFProText-Semibold", size: UIScreen.main.bounds.width * 16/375))
                            .foregroundColor(Color.white)
                            .padding([.trailing,.top],UIScreen.main.bounds.width * 16/375)
                        HStack{
                            Text("Credit / Debit Card")
                                .font(Font.custom("SFProText-Semibold", size: UIScreen.main.bounds.width * 16/375))
                                .foregroundColor(Color.white)
                                .padding(.leading, 10)
                            Spacer()
                            Image(uiImage: UIImage(named: "visa")!)
                                .resizable()
                                .frame(width: dWidth * 45/375, height: dWidth * 30/375, alignment: .center)
                                .scaledToFill()
                                .cornerRadius(dWidth * 5/375)
                                .padding(.trailing,dWidth * 5/375)
                            
                                .background( ZStack{
                                    Color("#003473")
                                        .edgesIgnoringSafeArea(.all)
                                }.cornerRadius(5))
                            Image(uiImage: UIImage(named: "maestro")!)
                                .resizable()
                                .frame(width: dWidth * 45/375, height: dWidth * 30/375, alignment: .center)
                                .scaledToFill()
                                .cornerRadius(dWidth * 5/375)
                                .background( ZStack{
                                    Color("#003473")
                                        .edgesIgnoringSafeArea(.all)
                                }.cornerRadius(5))
                                .padding(.trailing,10)
                        }.onTapGesture{
                            isAddCardLinkActive.toggle()
                        }
                        .frame(width: UIScreen.main.bounds.width-32,height: 50)
                        .background(
                            ZStack {
                                RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                                RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#00C600"),lineWidth: dWidth * 1/375)
                            })
                        VStack(alignment: .center){
//                        NavigationLink (
//                            destination: AddPaymentMethodView().navigationBarHidden(true),
//                            isActive: $isPayNowLinkActive,
//                            label: {
                                ButtonCommon(buttonName: totalCost != "" ? "Pay Now $\(totalCost)": "Pay Now", someAction: {
                                    vm.payNow(paymentMethodId: selectedCardId, bookingId: "\(booking?._id ?? 0)", amount: "2") { success in
                                        print(success)
                                        presentationMode.wrappedValue.dismiss()
                                    }
//                                    isPayNowLinkActive.toggle()
                                })
                                    .padding(.top, dHeight*30/812)
//                            }
//                        )
                        }.frame(width: UIScreen.main.bounds.width-32, alignment: .center)
                    }.frame(width: UIScreen.main.bounds.width-32, alignment: .leading)
                }
                .padding(.top, 8)
                .padding(.leading, 16)
                .padding(.trailing, 16)
                
            }//VStack
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height, alignment: .center)
            
        }//ZStack
        .onAppear{
            vm.getPaymentMethods(){ success in 
                cards = vm.Cards
                print(cards)
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])
        .navigationBarTitle("")
        .navigationBarHidden(true)
        
        NavigationLink("",
                       destination: AddPaymentMethodView().navigationBarHidden(true),
                       isActive: $isAddCardLinkActive)
    }
}

struct PaymentCardView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentCardView()
    }
}



struct PaymentView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @State var isShow : Bool = false
    var name: String
    @State var profileImage: UIImage? = UIImage(systemName: "person.fill")!
    var placeHoleder: String

    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @Binding var textField: String
    @Binding var cvcTxt: String
    let servicesList = [["lesson": "Private Lessons","rate":"$100/per hour"], ["lesson":"Virtual Lessons","rate":"$90/per hour"], ["lesson":"Group Lessons","rate":"$70/per hour"], ["lesson":"Boarding & Training", "rate":"$100/per hour"]]
    var index: Int
    @State var cards :[Cards] = []
    @Binding var cardId: String
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            HStack{
            VStack(alignment: .leading){
                HStack{
                    Image(uiImage: profileImage!)
                        .resizable()
                        .frame(width: dWidth * 52/375, height: dWidth * 30/375, alignment: .center)
                        .cornerRadius(dWidth * 10/375)
                        .overlay(RoundedRectangle(cornerRadius: dWidth * 10/375)
                        .stroke(Color.white, lineWidth: dWidth * 2/375))
                        .padding(.leading,dWidth * 16/375)
                        .padding(.top,-15)
                    VStack{
                        Text("XXXX XXXX XXXX \(cards[index].card_last4 ?? "")")
                            .foregroundColor(Color.white)
                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                            .padding([.leading,.trailing],dWidth * 16/375)
                        
//                        Text("Credit /Debit Card")
                        Text(cards[index].card_brand ?? "")
                            .foregroundColor(Color.white)
                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                            .padding([.leading,.trailing,.bottom],dWidth * 16/375)
                            .padding(.top,3)
                    }
                   
                   
                    Spacer()
                }
                .padding(.vertical, 12)
               
                if cards[index].id == cardId{
                    
                    VStack(alignment: .leading, spacing: 4){
                       
                        HStack(spacing: 10){
//                            $vm.CVC
                            HStack{
             
                                    SecureField(placeHoleder, text:$cvcTxt )
                                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                                        .foregroundColor(Color.white)
                                        .padding()
              
                                    Image("info")
                                        .resizable()
                                        .foregroundColor(Color("#00C600"))
                                        .frame(width: dWidth * 20/375, height: dWidth * 20/375)
                                    .padding()
                            } //:HStack
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                            .background(
                                ZStack {
                                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                                })
                           
                            .padding(.leading,dWidth * 90/375)
                            .padding(.trailing,dWidth * 16/375)
                            .padding(.top,-10)
                            .padding(.bottom,dWidth * 16/375)
                        }

                    }
                    
                }
            }
            .background(
                ZStack {
                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                })
            
            .padding(.horizontal, 0)
            
            Button(action: {
                isShow.toggle()
                if isShow == true{
                    self.cards[index].isShow = true
                    cardId = self.cards[index].id ?? ""
                }else{
                    self.cards[index].isShow = false
                    cardId = ""
                }

                            }, label: {
                                Image(cards[index].id == cardId ? "outline_radio_button_checked_black_18pt_1x" : "outline_radio_button_unchecked_black_18pt_1x")
                                    .foregroundColor(Color("#00C600"))
                                    .frame(width: dWidth * 16/375, height: dWidth * 16/375)
                                    .padding(.leading, 16)
                                
                            })
            }
        }
    }
//    func titleBindingFor(_ event: Service) -> Binding<String> {
//      return Binding<String>.init {
//            event.pivot?.price ?? ""
//        } set: { new in
//            vms.services[index].pivot?.price = new
//            vms.services[index].priceNew = new
//            print(vms.services[index].priceNew)
//        }
//
//    }
}
