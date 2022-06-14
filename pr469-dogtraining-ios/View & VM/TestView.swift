//
//  TestView.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-04-02.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack{
            Button {
                PersistenceController.shared.deleteUserData()
                let contentView = ContentView(vms: ProfileInfoVM())
                 UIApplication.shared.windows
                     .first { $0.isKeyWindow }?
                     .rootViewController = UIHostingController(rootView: contentView)
            } label: {
                Text("Logout")
            }
            
            Spacer()

        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
