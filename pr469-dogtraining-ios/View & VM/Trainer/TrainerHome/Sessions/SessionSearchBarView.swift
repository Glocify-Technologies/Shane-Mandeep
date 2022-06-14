//
//  SessionSearchBarView.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-03-10.
//

import SwiftUI
struct SessionSearchBarView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Binding var selectedTab: Int
    @Binding var text : String
  
    var left: String
    var right: String
    var viewBackgroundColor: Color
    var backgroundColor: Color
    @Binding var searching: Bool
    @ObservedObject var vms: TrainerSessionVM
    @FocusState var isInputActive: Bool
    var body: some View {
            VStack(spacing: dWidth * 16/375) {
                HStack(spacing: dWidth * 5/375) {
                    Image("outline_search_black_18pt_1x")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                    
                    TextField("Search", text: $text){ startedEditing in
                        if startedEditing {
                            withAnimation {
                                searching = true
                            }
                        }
                    } onCommit: {
                        
                        withAnimation {
                            if vms.searchText.isEmpty == false {
                                if selectedTab == 0 {
                                vms.getAllPaidBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                                }else{
                                    vms.getAllUnpaidBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                        print(vms.allBooking as Any)
                                    }
                                }
                            }else{
                                vms.allBooking?.removeAll()
                                if selectedTab == 0 {
                                    vms.currentPage = 1
                                    vms.getAllPaidBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                        print(vms.allBooking as Any)
                                    }
                                }else{
                                    vms.currentConfirmPage = 1
                                    vms.getAllUnpaidBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                        print(vms.allBooking as Any)
                                    }
                                }
                                
                                searching = false
                            }
                          
                            
                        }
                    }
                    .onSubmit {
                        if selectedTab == 0 {
                        vms.getAllPaidBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                            print(vms.allBooking as Any)
                        }
                        }else{
                            vms.getAllUnpaidBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                print(vms.allBooking as Any)
                            }
                        }
                    }
                    .onChange(of: text){ newValue in
                        print(newValue)
                        if newValue == ""{
                            vms.allBooking?.removeAll()
                            if selectedTab == 0 {
                                vms.currentPage = 1
                                vms.getAllPaidBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }else{
                                vms.currentConfirmPage = 1
                                vms.getAllUnpaidBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }
                           
                            searching = false
                        }else{
                            vms.allBooking?.removeAll()
                            if selectedTab == 0 {
                                vms.getAllPaidBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }else{
                                vms.getAllUnpaidBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }
                           
                            searching = false
                        }
                    }
                    .focused($isInputActive)
                    .toolbar {
                        ToolbarItemGroup(placement: .keyboard) {
                            Spacer()
                            
                            Button("Done") {
                                if vms.searchText == ""{
                                    vms.allBooking?.removeAll()
                                    if selectedTab == 0 {
                                        vms.currentPage = 1
                                        vms.getAllPaidBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                            print(vms.allBooking as Any)
                                        }
                                    }else{
                                        vms.currentConfirmPage = 1
                                        vms.getAllUnpaidBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                            print(vms.allBooking as Any)
                                        }
                                    }
                                    
                                    searching = false
                                }else{
                                    if selectedTab == 0 {
                                        vms.getAllPaidBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                            print(vms.allBooking as Any)
                                    }
                                    }else{
                                        vms.getAllUnpaidBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                            print(vms.allBooking as Any)
                                    }
                                    }
                                   
                                }
                                isInputActive = false
                            }
                        }
                    }
                        .textFieldStyle(PlainTextFieldStyle())
                        .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                        .foregroundColor(Color.white)
                        .keyboardType(.emailAddress)
                } //:HStack
                .padding(.vertical, dWidth * 8/375)
                .padding(.horizontal, dWidth * 9/375)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: dWidth * 18/375)
                            .fill(Color.black.opacity(0.45))
                            .shadow(color: Color("#7E7E7E").opacity(0.09), radius: 10, x: 0, y: 4)
                        RoundedRectangle(cornerRadius: dWidth * 18/375)
                            .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                    })
                
                //Tab view
                HStack(spacing: -10) {
                    //All tab
                    Button(action: {
                        selectedTab = 0
                        if vms.searchText == ""{
                            vms.allBooking?.removeAll()
                            if selectedTab == 0 {
                                vms.currentPage = 1
                                vms.getAllPaidBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }else{
                                vms.currentConfirmPage = 1
                                vms.getAllUnpaidBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }
                            
                            searching = false
                        }else{
                            if selectedTab == 0 {
                                vms.getAllPaidBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                            }
                            }else{
                                vms.getAllUnpaidBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                            }
                            }
                           
                        }
                    }) {
                        getSelectedTabTextView(view: left, selectedTab: selectedTab, tab: 0)
                    }
                                        
                    //Catches tab
                    Button(action: {
                        selectedTab = 1
                        if vms.searchText == ""{
                            vms.allBooking?.removeAll()
                            if selectedTab == 0 {
                                vms.currentPage = 1
                                vms.getAllPaidBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }else{
                                vms.currentConfirmPage = 1
                                vms.getAllUnpaidBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                  print(vms.allBooking as Any)
                                }
                            }
                            
                            searching = false
                        }else{
                            if selectedTab == 0 {
                                vms.getAllPaidBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                            }
                            }else{
                                vms.getAllUnpaidBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                            }
                            }
                           
                        }
                    }) {
                        getSelectedTabTextView(view: right, selectedTab: selectedTab, tab: 1)
                    }
                } //HStack
                .background(
                    RoundedRectangle(cornerRadius: dWidth * 20/375)
                        .fill(backgroundColor)
                )
                .padding(.horizontal, 2)
            } //:VStack
            .padding(dWidth * 15/375)
            .background(
                ZStack {
                    RoundedRectangle(cornerRadius: dWidth * 20/375)
                        .fill(viewBackgroundColor)
                    RoundedRectangle(cornerRadius: dWidth * 20/375)
                        .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                }
            )
    }
    
    @ViewBuilder func getSelectedTabTextView(view: String, selectedTab: Int, tab: Int) -> some View {
        HStack {
            Spacer()
            Text("\(view)")
            Spacer()
        }
        .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 13)))
        .foregroundColor(.white)
        .padding(.vertical, dWidth * 7/375)
        .background(selectedTab == tab ? Color( "#00A100") : Color.clear)
        .overlay(
            RoundedRectangle(cornerRadius: dWidth * 14/375)
                .stroke(selectedTab == tab ? Color("#5CFF5C") : Color.clear, lineWidth: 1)
                .shadow(color: Color("#7E7E7E"), radius: 6, x: 0, y: 2)
        )
    .cornerRadius(dWidth * 14/375)
    }
}
