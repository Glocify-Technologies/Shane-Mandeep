//
//  TrainerTabBar.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-07.
//

import SwiftUI

struct TrainerTabItem {
    var caption: String
    var image: String
    var imageDeselect: String
}

class TrainerMainTabVM: ObservableObject {
    @Published var showTrainerTabBar = true
    @Published var tab = 0
    @Published var tabItems = [
        TrainerTabItem(caption: "Home", image: "baseline_home_black_18pt_1x", imageDeselect: "baseline_home_black_18pt_1x"),
        TrainerTabItem(caption: "Bookings", image: "baseline_event_black_12pt_1x", imageDeselect: "baseline_event_black_12pt_1x"),
        TrainerTabItem(caption: "Chat", image: "baseline_chat_black_18pt_1x", imageDeselect: "baseline_chat_black_18pt_1x"),
        TrainerTabItem(caption: "More", image: "baseline_more_vert_black_12pt_1x", imageDeselect: "baseline_more_vert_black_12pt_1x")
    ]
}

struct TrainerTabItemView: View {
    var item: Int
    @EnvironmentObject var vm : TrainerMainTabVM
    
    var caption: String
    var captionDeselect: String
    var image: String
    var imageDeselect: String
    
    let sHeight = UIScreen.main.bounds.height
    let sWidth = UIScreen.main.bounds.width
    
    var body: some View {
        Button(
            action: {
                vm.tab = item
            },
            label: {
                VStack(spacing: 0) {
                    Image(vm.tab == item ? image : imageDeselect)
                        .resizable()
                        .foregroundColor(vm.tab == item ? Color("#00C600") : Color("#666666"))
                        .frame(width: sWidth * 28/375, height: sWidth * 28/375, alignment: .center)
                    
                    if vm.tab == item {
                        Image(captionDeselect)
                            .resizable()
                            .foregroundColor(Color("#00C600"))
                            .frame(width: sWidth * 6/375, height: sWidth * 6/375, alignment: .center)
                    } else {
                        Text(caption)
                            .font(Font.custom("SFProText-Medium", size: item == 3 ? 9 : 10))
                            .foregroundColor(Color("#666666"))
                    }
                }
                .ignoresSafeArea()
            }
        )
            .frame(width: sWidth * 50/375, alignment: .center)
            .ignoresSafeArea()
    }
}


struct TrainerTabBar: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    
    @EnvironmentObject var vm : MainTabVM
    
    var body: some View {
        HStack{
            TrainerTabItemView(item: 0, caption: "Home", captionDeselect: "baseline_circle_black_18pt_1x", image: "baseline_home_black_18pt_1x", imageDeselect: "baseline_home_black_18pt_1x")
            Spacer()
            TrainerTabItemView(item: 1, caption: "Availability", captionDeselect: "baseline_circle_black_18pt_1x", image: "baseline_event_black_12pt_1x", imageDeselect: "baseline_event_black_12pt_1x")
            Spacer()
            TrainerTabItemView(item: 2, caption: "Sessions", captionDeselect: "baseline_circle_black_18pt_1x", image: "outline_groups_black_18pt_1x", imageDeselect: "outline_groups_black_18pt_1x")
            Spacer()
            TrainerTabItemView(item: 3, caption: "Chat", captionDeselect: "baseline_circle_black_18pt_1x", image: "baseline_chat_black_18pt_1x", imageDeselect: "baseline_chat_black_18pt_1x")
            Spacer()
            TrainerTabItemView(item: 4, caption: "More", captionDeselect: "baseline_circle_black_18pt_1x", image: "baseline_more_vert_black_12pt_1x", imageDeselect: "baseline_more_vert_black_12pt_1x")
        }
        .ignoresSafeArea()
        .padding(.vertical, 0)
        .padding(.top, dWidth * 10/375)
        .padding(.bottom, dWidth * 10/375)
        .padding(.horizontal, UIScreen.main.bounds.width * 15/375)
        .background(
            Color("#232325-1")
                .clipShape(Rounded(radius: 10))
                .ignoresSafeArea(.container, edges: .bottom)
                .shadow(color: Color.black.opacity(0.09), radius: 30, x: 0.0, y: -1))
    }
}

struct TrainerTabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            TrainerTabBar().environmentObject(TrainerMainTabVM())
        }
    }
}
