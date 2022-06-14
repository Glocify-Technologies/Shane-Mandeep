//
//  SearchBar.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-07.
//

import SwiftUI
let buttonGradientT = Gradient(colors: [Color("Color#17A5DB"), Color("Color#22D0D3")])

struct SearchBar: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Binding var text : String
    @Binding var searching: Bool
    @ObservedObject var vms: HomeVM
    @FocusState var isInputActive: Bool
    
    var body: some View {
        HStack(spacing: 5) {
            Image("outline_search_black_18pt_1x")
                .foregroundColor(Color.white)
                .clipped()
                .frame(width: dWidth * 24/375, height: dWidth * 22/375)
            
            TextField("", text: $text){ startedEditing in
                if startedEditing {
                    withAnimation {
                        searching = true
                    }
                }
            } onCommit: {
                
                withAnimation {
                    if vms.searchText.isEmpty == false {
                        vms.getAllTrainersSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                            print(vms.allTrainer as Any)
                        }
                    }else{
                        vms.allTrainer?.removeAll()
                        vms.currentPage = 1
                        vms.getAllTrainers(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                            print(vms.allTrainer as Any)
                        }
                        searching = false
                    }
                  
                    
                }
            }
            .onSubmit {
                vms.getAllTrainersSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                    print(vms.allTrainer as Any)
                }

            }
            .onChange(of: text){ newValue in
                print(newValue)
                if newValue == ""{
                    vms.allTrainer?.removeAll()
                    vms.currentPage = 1
                    vms.getAllTrainers(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                        print(vms.allTrainer as Any)
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
                            vms.allTrainer?.removeAll()
                            vms.currentPage = 1
                            vms.getAllTrainers(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                print(vms.allTrainer as Any)
                            }
                            searching = false
                        }else{
                            vms.getAllTrainersSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                print(vms.allTrainer as Any)
                        }
                        }
                        isInputActive = false
                    }
                }
            }
                .textFieldStyle(PlainTextFieldStyle())
                .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                .foregroundColor(Color.white)
                .keyboardType(.default)
        }
        .frame(width: dWidth * 290/375, height: dWidth * 14/375)
        .padding(.all, dWidth * 10/375)
        .background(
            ZStack {
                RoundedRectangle(cornerRadius: dWidth * 18/375)
                    .fill(Color.black.opacity(0.45))
                    .shadow(color: Color("#7E7E7E").opacity(0.09), radius: 10, x: 0, y: 4)
                RoundedRectangle(cornerRadius: dWidth * 18/375)
                    .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
            })
    }
}

struct ToggleButton: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Binding var selectedTab: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dWidth * 25/375)
                .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                .foregroundColor(Color.black.opacity(0.26))
            //.background(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                .frame(width: dWidth * 343.5/375, height: dWidth * 60.5/375)
            
                //Tab view
                HStack(spacing: 0) {
                    //All tab
                    Button(action: {
                        selectedTab = 0
                    }) {
                        if selectedTab == 0{
                            getSelectedTabTextView(view: "My Profile")
                        }else{
                            getUnselectedTabTextView(view: "My Profile")
                        }
                    }
                                        
                    //Catches tab
                    Button(action: {
                        selectedTab = 1
                    }) {
                        if selectedTab == 1{
                            getSelectedTabTextView(view: "Pet Profile")
                        }else{
                            getUnselectedTabTextView(view: "Pet Profile")
                        }
                    }
                } //HStack
                .background(Color("#7E7E7E"))
                .cornerRadius(dWidth * 14/375)
                .overlay(
                    RoundedRectangle(cornerRadius: dWidth * 14/375)
                        .stroke(Color("#7E7E7E"), lineWidth: dWidth * 1/375)
//                        .shadow(color: Color("#7E7E7E"), radius: 6, x: 0, y: 2)
                )
        } //:ZStack
    }
    
    @ViewBuilder func getSelectedTabTextView(view: String) -> some View {
        Text("\(view)")
            .font(.customFont(.SFProTextSemibold, Screen.sizeFromWidth(size: 13)))
            .foregroundColor(.white)
            .padding()
            .frame(width: dWidth * 150/375, height: dWidth * 29/375)
            .background(Color("#00A100"))
            .overlay(
                RoundedRectangle(cornerRadius: dWidth * 14/375)
                    .stroke(Color("#5CFF5C"), lineWidth: dWidth * 2/375)
            )
            .cornerRadius(dWidth * 14/375)
    }
    
    @ViewBuilder func getUnselectedTabTextView(view: String) -> some View {
        
        Text("\(view)")
            .font(.customFont(.SFProTextMedium, Screen.sizeFromWidth(size: 14)))
            .foregroundColor(Color.white)
            .padding()
            .frame(width: dWidth * 150/375, height: dWidth * 29/375)
    }
}

struct SearchBarWithToggle: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Binding var selectedTab: Int
    @Binding var text : String
  
    var left: String
    var right: String
    var viewBackgroundColor: Color
    var backgroundColor: Color
    @Binding var searching: Bool
    @ObservedObject var vms: TrainerHomeVM
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
                                vms.getBookingListSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                                }else{
                                    vms.getConfirmBookingListSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                        print(vms.allBooking as Any)
                                    }
                                }
                            }else{
                                vms.allBooking?.removeAll()
                                if selectedTab == 0 {
                                    vms.currentPage = 1
                                    vms.getBookingList(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                        print(vms.allBooking as Any)
                                    }
                                }else{
                                    vms.currentConfirmPage = 1
                                    vms.getConfirmBookingList(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                        print(vms.allBooking as Any)
                                    }
                                }
                                
                                searching = false
                            }
                          
                            
                        }
                    }
                    .onSubmit {
                        if selectedTab == 0 {
                        vms.getBookingListSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                            print(vms.allBooking as Any)
                        }
                        }else{
                            vms.getConfirmBookingListSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
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
                                vms.getBookingList(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }else{
                                vms.currentConfirmPage = 1
                                vms.getConfirmBookingList(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }
                           
                            searching = false
                        }else{
                            vms.allBooking?.removeAll()
                            if selectedTab == 0 {
                                vms.getBookingList(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }else{
                                vms.getConfirmBookingList(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
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
                                        vms.getBookingList(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                            print(vms.allBooking as Any)
                                        }
                                    }else{
                                        vms.currentConfirmPage = 1
                                        vms.getConfirmBookingList(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                            print(vms.allBooking as Any)
                                        }
                                    }
                                    
                                    searching = false
                                }else{
                                    if selectedTab == 0 {
                                        vms.getBookingListSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                            print(vms.allBooking as Any)
                                    }
                                    }else{
                                        vms.getConfirmBookingListSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
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
                                vms.getBookingList(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }else{
                                vms.currentConfirmPage = 1
                                vms.getConfirmBookingList(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }
                            
                            searching = false
                        }else{
                            if selectedTab == 0 {
                                vms.getBookingListSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                            }
                            }else{
                                vms.getConfirmBookingListSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
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
                                vms.getBookingList(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                                }
                            }else{
                                vms.currentConfirmPage = 1
                                vms.getConfirmBookingList(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                  print(vms.allBooking as Any)
                                }
                            }
                            
                            searching = false
                        }else{
                            if selectedTab == 0 {
                                vms.getBookingListSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.allBooking as Any)
                            }
                            }else{
                                vms.getConfirmBookingListSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
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


struct BookingSearchBarWithToggle: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Binding var selectedTab: Int
    @Binding var text : String
  
    var left: String
    var right: String
    var viewBackgroundColor: Color
    var backgroundColor: Color
    @Binding var searching: Bool
    @ObservedObject var vms: BookingsVM
    @FocusState var isInputActive: Bool
    var body: some View {
            VStack(spacing: dWidth * 16/375) {
                HStack(spacing: dWidth * 5/375) {
                    Image("outline_search_black_18pt_1x")
                        .resizable()
                        .foregroundColor(Color.white)
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                    
                    TextField("", text: $text){ startedEditing in
                        if startedEditing {
                            withAnimation {
                                searching = true
                            }
                        }
                    } onCommit: {
                        
                        withAnimation {
                            if vms.searchText.isEmpty == false {
                                if selectedTab == 0 {
                                vms.getConfirmBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
                                }
                                }else{
                                    vms.getPendingBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                        print(vms.booking as Any)
                                    }
                                }
                            }else{
                                vms.booking?.removeAll()
                                if selectedTab == 0 {
                                    vms.currentPage = 1
                                    vms.getConfirmBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                        print(vms.booking as Any)
                                    }
                                }else{
                                    vms.currentConfirmPage = 1
                                    vms.getPendingBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                        print(vms.booking as Any)
                                    }
                                }
                                
                                searching = false
                            }
                          
                            
                        }
                    }
                    .onSubmit {
                        if selectedTab == 0 {
                        vms.getConfirmBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                            print(vms.booking as Any)
                        }
                        }else{
                            vms.getPendingBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                print(vms.booking as Any)
                            }
                        }
                    }
                    .onChange(of: text){ newValue in
                        print(newValue)
                        if newValue == ""{
                            vms.booking?.removeAll()
                            if selectedTab == 0 {
                                vms.currentPage = 1
                                vms.getConfirmBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
                                }
                            }else{
                                vms.currentConfirmPage = 1
                                vms.getPendingBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
                                }
                            }
                           
                            searching = false
                        }else{
                            vms.booking?.removeAll()
                            if selectedTab == 0 {
                                vms.getConfirmBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
                                }
                            }else{
                                vms.getPendingBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
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
                                    vms.booking?.removeAll()
                                    if selectedTab == 0 {
                                        vms.currentPage = 1
                                        vms.getConfirmBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                            print(vms.booking as Any)
                                        }
                                    }else{
                                        vms.currentConfirmPage = 1
                                        vms.getPendingBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                            print(vms.booking as Any)
                                        }
                                    }
                                    
                                    searching = false
                                }else{
                                    if selectedTab == 0 {
                                        vms.getConfirmBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                            print(vms.booking as Any)
                                    }
                                    }else{
                                        vms.getPendingBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                            print(vms.booking as Any)
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
                            vms.booking?.removeAll()
                            if selectedTab == 0 {
                                vms.currentPage = 1
                                vms.getConfirmBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
                                }
                            }else{
                                vms.currentConfirmPage = 1
                                vms.getPendingBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
                                }
                            }
                            
                            searching = false
                        }else{
                            if selectedTab == 0 {
                                vms.getConfirmBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
                            }
                            }else{
                                vms.getPendingBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
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
                            vms.booking?.removeAll()
                            if selectedTab == 0 {
                                vms.currentPage = 1
                                vms.getConfirmBookings(searchText: vms.searchText, page: vms.currentPage, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
                                }
                            }else{
                                vms.currentConfirmPage = 1
                                vms.getPendingBookings(searchText: vms.searchText, page: vms.currentConfirmPage, perPage: vms.perPage) { success in
                                  print(vms.booking as Any)
                                }
                            }
                            
                            searching = false
                        }else{
                            if selectedTab == 0 {
                                vms.getConfirmBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
                            }
                            }else{
                                vms.getPendingBookingsSearch(searchText: vms.searchText, page: 0, perPage: vms.perPage) { success in
                                    print(vms.booking as Any)
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
struct ToggleButton_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            ToggleButton(selectedTab: .constant(0))
                .padding()
        }
    }
}

struct SearchBarWithToggle_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            SearchBarWithToggle(selectedTab: .constant(0), text: .constant("Search"), left: "Pending", right: "Confirmed", viewBackgroundColor: Color.red, backgroundColor: Color.white, searching: .constant(false),vms:TrainerHomeVM())
                .padding()
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.blue
            SearchBar(text: .constant("Search"), searching: .constant(false), vms: HomeVM())
                .padding()
        }
    }
}
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
