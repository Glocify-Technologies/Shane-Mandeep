//
//  TrainerMainTabView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-07.
//

import SwiftUI

struct TrainerMainTabView: View {
    @StateObject var viewModel = TrainerMainTabVM()
    @ObservedObject var vms: ProfileInfoVM

    var body: some View {
        ZStack(alignment: .bottom) {
            switch viewModel.tab {
            case 0 :
                TrainerHomeView(vms: TrainerHomeVM())
            case 1 :
                AvailabilityView(vms: vms)
            case 2 :
                TrainerSessionsView(vms: TrainerSessionVM())
            case 3 :
                ChatView()
            case 4 :
                TrainerMoreView()
            default:
                TrainerHomeView(vms: TrainerHomeVM())
            }
            if viewModel.showTrainerTabBar {
                TrainerTabBar()
            }
        }
        .environmentObject(viewModel)
    }
}
//
//struct TrainerMainTabView_Previews: PreviewProvider {
//    static var previews: some View {
//        TrainerMainTabView(, vms: <#ProfileInfoVM#>)
//    }
//}
