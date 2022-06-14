//
//  TrainerHomeView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-02.
//

import SwiftUI

struct TrainerHomeView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @State var selectedTab : Int = 0
    @ObservedObject var vms: TrainerHomeVM
    @State var searching = false
    var body: some View {
        ZStack {
            Image("bg_img_intro")
                .resizable()
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: dWidth * 16/375) {
                NavBarWithoutBackButtonTransparent(title: "Home") {
                    presentationMode.wrappedValue.dismiss()
                }
//                SearchBar(text: $vms.searchText, searching: $searching,vms:vms)

                SearchBarWithToggle(selectedTab: $selectedTab, text: $vms.searchText, left: "All", right: "Confirmed", viewBackgroundColor: Color("#7E7E7E").opacity(0.09), backgroundColor: Color.clear,searching: $searching, vms:vms)
                    .padding(.horizontal, dWidth * 16/375)
                
                List{
                    ForEach(vms.allBooking ?? [Booking]()) { Booking in
                        TrainerUserCard(image: Booking.users?.avatarUrl ?? "", name: Booking.users?.name ?? "", detail: Booking.time ?? "",destination: AnyView(ViewAppointmentView(vms: vms, booking:Booking)), booking:Booking)
                    }.listRowBackground(backgroundColor)
                    if (vms.trainerListFull == false){
                        if searching == false{
                        ProgressView()
                            .onAppear {
                                if selectedTab == 0 {
                                    vms.getBookingList(searchText: vms.searchText, page: vms.currentPage + 1, perPage: vms.perPage) { success in
                                        
                                    }
                                }else{
                                    vms.getConfirmBookingList(searchText: vms.searchText, page: vms.currentConfirmPage + 1, perPage: vms.perPage) { success in
                                        
                                    }
                                }
                                    
                                }
                            }
                    }
                    
                }.onAppear {
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                    UITableView.appearance().separatorColor = .clear
                    UITableView.appearance().backgroundView = nil
                    UITableViewCell.appearance().backgroundView = nil
                    UITableViewCell.appearance().contentView.backgroundColor = UIColor.clear
                    UITableView.appearance().backgroundView?.backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundView?.backgroundColor = UIColor.clear

                }

            } //:VStack
        
        } //:ZStack
        .onAppear{
            if selectedTab == 0 {
                vms.getBookingList(searchText: vms.searchText, page: vms.currentPage + 1, perPage: vms.perPage) { success in
                    
                }
            }else{
                vms.getConfirmBookingList(searchText: vms.searchText, page: vms.currentConfirmPage + 1, perPage: vms.perPage) { success in
                    
                }
            }
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])
    }
}

