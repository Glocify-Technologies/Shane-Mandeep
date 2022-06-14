//
//  MainTabView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-07.
//

import SwiftUI

struct MainTabView: View {
    @StateObject var viewModel = MainTabVM()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            switch viewModel.tab { 
            case 0 :
                HomeView(vms: HomeVM())
            case 1 :
                BookingsView(vm: BookingsVM())
            case 2 :
                ChatView()
            case 3 :
                MoreView()
            default:
                HomeView(vms: HomeVM())
            }
            if viewModel.showTabBar {
                TabBar()
            }
        }
        .environmentObject(viewModel)
        
    }
}
//
struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
