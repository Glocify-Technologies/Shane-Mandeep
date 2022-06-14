//
//  NotificationView.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-03-10.
//

import SwiftUI

struct NotificationView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavBarWithBackButton(title: "Notifications") {
                    presentationMode.wrappedValue.dismiss()
                }
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ViewNotificationView(title: "Pay Later", time: "2:13PM", content: "John Doe, will pay later")
                        ViewNotificationView(title: "Paid", time: "Yesterday", content: "Shawn Mendis, has pain in full")
                        ViewNotificationView(title: "Pay Later", time: "2:13PM", content: "John Doe, will pay later")
                        ViewNotificationView(title: "Pay Later", time: "2:13PM", content: "John Doe, will pay later")
                        ViewNotificationView(title: "Pay Later", time: "2:13PM", content: "John Doe, will pay later")
                                             
                        ViewNotificationView(title: "Pay Later", time: "2:13PM", content: "John Doe, will pay later")
                        Spacer()
                    }
                }
            }
        } //:ZStack
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
