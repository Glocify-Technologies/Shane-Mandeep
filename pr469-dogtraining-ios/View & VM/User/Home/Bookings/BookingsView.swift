//
//  BookingsView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-07.
//

import SwiftUI

struct BookingsView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @ObservedObject var vm:BookingsVM
    @State var selectedTab : Int = 0
    @State var showActionSheet = false
    @State var isPayNowViewActive = false
    @State var searching = false
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavBarWithoutBackButtonTransparent(title: "Bookings") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                BookingSearchBarWithToggle(selectedTab:$selectedTab, text: $vm.searchText, left: "Confirmed", right: "Pending", viewBackgroundColor: Color(.black).opacity(0.05), backgroundColor: Color(.gray).opacity(0.2),searching: .constant(false),vms: vm)
                    .padding(.bottom, dWidth * 24/375)
                    .padding(.horizontal, dWidth * 16/375)
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ForEach(0 ..< (vm.booking?.count ?? 0), id: \.self ,content: { item in
                            BookingsUserCard(date: vm.booking?[item].date ?? "", time: vm.booking?[item].time ?? "", image: vm.booking?[item].trainer?.users?.avatarUrl ?? "", name: vm.booking?[item].trainer?.users?.name ?? "", centre: vm.booking?[item].trainer?.businessName ?? "", address: vm.booking?[item].trainer?.location ?? "", isPaid: vm.booking?[item].is_paid ?? "", onDelete: {
                                vm.userCardArray.remove(at: item)
                            }, onPaymentAction: {isGoToBookings in
                                if !isGoToBookings{
                                    if vm.booking?[item].is_paid != "1"{
                                        isPayNowViewActive.toggle()
                                }
                                    
                                }else{
                                    showActionSheet.toggle()
                                }
                                
                            })
                            NavigationLink("",
                                           destination: PayNowView(booking: vm.booking?[item]),
                                           isActive: $isPayNowViewActive)
                        }
                                
                        )
                        if (vm.confirmBookingsFull == false){
                            if searching == false{
                            ProgressView()
                                .onAppear {
                                    
                                        vm.getConfirmBookings(searchText: vm.searchText, page: vm.currentPage + 1, perPage: vm.perPage) { success in
                                            
                                        }
                                    }
                                }
                        }
                        Spacer()
                    } //:LazyVStack
                    .padding(.horizontal, dWidth * 16/375)
                } //:ScrollView
                .padding(.bottom, dWidth * 55/375)
            } //:VStack
            
            if showActionSheet{
                VStack{
                    VStack{
                    Text("Pay Later")
                    .font(.custom("SFProText-Semibold", size: dWidth * 17/375))
                    .foregroundColor(Color.black)
                    .padding(.bottom, 0)
                    
                    Text("Trainer will be notified.")
                    .font(.custom("SFProText-Regular", size: dWidth * 13/375))
                    .foregroundColor(Color.black)
                    }
                    .padding()
                    
                    Divider()
                    Button(action: {
                        showActionSheet.toggle()
                    }, label: {
                        Text("Go To Bookings")
                            .font(.custom("SFProText-Semibold", size: dWidth * 17/375))
                            .foregroundColor(Color.blue)
                            .padding(.vertical, 8)

                    })
                    
                    Divider()
                    Button(action: {
                        showActionSheet.toggle()
                    }, label: {
                        Text("Okay")
                            .font(.custom("SFProText-Semibold", size: dWidth * 17/375))
                            .foregroundColor(Color.blue)
                            .padding(.vertical, 8)

                    })
                    
                }
                .frame(width: 270)
                .background(Color.white.opacity(0.95))
                .cornerRadius(12)
                .padding()
            }
            
           
        } //:ZStack
        
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct BookingsView_Previews: PreviewProvider {
    static var previews: some View {
        BookingsView(vm: BookingsVM())
    }
}
