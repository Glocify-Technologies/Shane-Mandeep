//
//  TabBar.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-07.
//

import SwiftUI

struct TabItem {
    var caption: String
    var image: String
    var imageDeselect: String
}

class MainTabVM: ObservableObject {
    @Published var showTabBar = true
    @Published var tab = 0
    @Published var tabItems = [
        TabItem(caption: "Home", image: "baseline_home_black_18pt_1x", imageDeselect: "baseline_home_black_18pt_1x"),
        TabItem(caption: "Bookings", image: "baseline_event_black_12pt_1x", imageDeselect: "baseline_event_black_12pt_1x"),
        TabItem(caption: "Chat", image: "baseline_chat_black_18pt_1x", imageDeselect: "baseline_chat_black_18pt_1x"),
        TabItem(caption: "More", image: "baseline_more_vert_black_12pt_1x", imageDeselect: "baseline_more_vert_black_12pt_1x")
    ]
}

struct TabItemView: View {
    var item: Int
    @EnvironmentObject var vm : MainTabVM
    
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
        //        .background(Color.gray)
    }
}


struct TabBar: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    
    @EnvironmentObject var vm : MainTabVM
    
    var body: some View {
        HStack{
            //            ForEach(0 ..< vm.tabItems.count, id: \.self) {item in
            //                if item != 0 { Spacer() }
            //                TabItemView(item: item)
            //            }
            TabItemView(item: 0, caption: "Home", captionDeselect: "baseline_circle_black_18pt_1x", image: "baseline_home_black_18pt_1x", imageDeselect: "baseline_home_black_18pt_1x")
            Spacer()
            TabItemView(item: 1, caption: "Bookings", captionDeselect: "baseline_circle_black_18pt_1x", image: "baseline_event_black_12pt_1x", imageDeselect: "baseline_event_black_12pt_1x")
            Spacer()
            TabItemView(item: 2, caption: "Chat", captionDeselect: "baseline_circle_black_18pt_1x", image: "baseline_chat_black_18pt_1x", imageDeselect: "baseline_chat_black_18pt_1x")
            Spacer()
            TabItemView(item: 3, caption: "More", captionDeselect: "baseline_circle_black_18pt_1x", image: "baseline_more_vert_black_12pt_1x", imageDeselect: "baseline_more_vert_black_12pt_1x")
        }
        .ignoresSafeArea()
        .padding(.vertical, 0)
        .padding(.top, dWidth * 10/375)
        .padding(.bottom, dWidth * 10/375)
        .padding(.horizontal, UIScreen.main.bounds.width*15/375)
        .background(
            Color("#232325-1")
                .clipShape(Rounded(radius: 10))
                .ignoresSafeArea(.container, edges: .bottom)
                .shadow(color: Color.black.opacity(0.09), radius: 30, x: 0.0, y: -1)
        )
        
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            TabBar().environmentObject(MainTabVM())
        }
    }
}
