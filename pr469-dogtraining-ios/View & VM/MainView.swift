//
//  Main.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-08.
//

import SwiftUI

//struct MainView: View {
//    @State var showSidebar = false
//    @State var Destination : AnyView? = AnyView(HomeView())
//    
//    var body: some View {
//        NavigationView{
//            ZStack{
//                if showSidebar{
//                    SideMenuView(showSidebar: $showSidebar, selection: $Destination)
//                        .navigationBarHidden(true)
//                }
//                Destination
//                    .transition(.move(edge: .bottom))
//                    .modifier(MenuButton(showSidebar: $showSidebar))
////                HomeView()
////                    .transition(.move(edge: .bottom))
////                    .modifier(MenuButton(showSidebar: $showSidebar))
////                    .navigationTitle("Home")
//            }
//            .onAppear{
//                if showSidebar{
//                    showSidebar.toggle()
//                }
//            }
//        }
//    }
//    
//}


struct DetailsView : View{
    var viewName : String
    var body: some View {
        ZStack {
            Color.white
            HStack{
                Text(viewName)
            }
            .navigationTitle(viewName)
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

