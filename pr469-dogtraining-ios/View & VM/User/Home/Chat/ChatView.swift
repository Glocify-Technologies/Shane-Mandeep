//
//  ChatView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-07.
//

import SwiftUI

struct ChatView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width

    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavBarWithoutBackButtonTransparent(title: "Chat")
                
                ScrollView(showsIndicators: false) {
                    LazyVStack(spacing: 16) {
                        ChatUserView(image: "People 09", name: "Emily Wilis", time: "2.13P.M", address: "3 Farland Street, Brockton, MA 0240124685864668")
                        ChatUserView(image: "People 05", name: "Lucy Eleanor", time: "2.13P.M", address: "3 Farland Street, Brockton, MA 0240124685864668")
                        ChatUserView(image: "People 08", name: "Bennet", time: "2.13P.M", address: "3 Farland Street, Brockton, MA 0240124685864668")
                        ChatUserView(image: "People 04", name: "Barry", time: "2.13P.M", address: "3 Farland Street, Brockton, MA 0240124685864668")
                        ChatUserView(image: "People 06", name: "Saly Zoy", time: "2.13P.M", address: "3 Farland Street, Brockton, MA 0240124685864668")
                        Spacer()
                    }
                }
            }
        } //:ZStack
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])
        .navigationBarTitle("")
        .navigationBarHidden(true)
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
