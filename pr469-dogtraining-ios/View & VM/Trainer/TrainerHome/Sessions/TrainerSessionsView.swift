//
//  TrainerSessionsView.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-03-10.
//

import Foundation


import SwiftUI

struct TrainerSessionsView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @ObservedObject var vms: TrainerSessionVM
    @State var searching = false
    @State var selectedTab : Int = 0
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
           
            
            VStack(spacing: dWidth * 16/375) {
                NavBarWithoutBackButtonTransparent(title: "Client Sessions") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                SessionSearchBarView(selectedTab: $selectedTab,text: $vms.searchText, left: "Paid", right: "Paying Later", viewBackgroundColor: Color("#7E7E7E").opacity(0.09), backgroundColor: Color.clear,searching: $searching, vms:vms)
                    .padding(.horizontal, dWidth * 16/375)
                
//                ScrollView(showsIndicators: false) {
//                    LazyVStack(spacing: 16) {
//                        SessionCardView(image: "People 09", name: "Lily Beth", detail: "Wed 23, Dec  |  09:55 AM", destination: AnyView(ViewSessionView()))
//                        SessionCardView(image: "People 05", name: "Jesica Ruth", detail: "Fri 19, Nov  |  09:00 AM", destination: AnyView(ViewSessionView()))
//                        SessionCardView(image: "People 02", name: "Jhon Doe", detail: "Fri 19, Nov  |  09:00 AM", destination: AnyView(ViewSessionView()))
//                        SessionCardView(image: "People 06", name: "Emily Michel", detail: "Fri 19, Nov  |  09:00 AM", destination: AnyView(ViewSessionView()))
//                        Spacer()
//                    }
//                    .padding(.top, dWidth * 16/375)
//                    .padding(.horizontal, dWidth * 16/375)
//                }
                List{
                    ForEach(vms.allBooking ?? [Booking]()) { Booking in
                        SessionCardView(image: Booking.users?.avatarUrl ?? "", name: Booking.users?.name ?? "", detail: Booking.time ?? "",destination: AnyView(ViewSessionView(vms:vms,booking: Booking)), booking:Booking)
                    }.listRowBackground(backgroundColor)
                    if (vms.trainerListFull == false){
                        if searching == false{
                        ProgressView()
                            .onAppear {
                                if selectedTab == 0 {
                                    vms.getAllPaidBookings(searchText: vms.searchText, page: vms.currentPage + 1, perPage: vms.perPage) { success in
                                        
                                    }
                                }else{
                                    vms.getAllUnpaidBookings(searchText: vms.searchText, page: vms.currentConfirmPage + 1, perPage: vms.perPage) { success in
                                        
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
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])
    }
}

struct TrainerSessionsView_Previews: PreviewProvider {
    static var previews: some View {
        TrainerSessionsView(vms: TrainerSessionVM())
    }
}
