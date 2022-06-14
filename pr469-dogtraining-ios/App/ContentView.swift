//
//  ContentView.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-02.
//

import SwiftUI
import Combine
import Stripe

public let Authenticated = PassthroughSubject<Bool, Never>()

public func IsAuthenticated() -> Bool {
    return PersistenceController.shared.loadUserData() != nil
}

struct ContentView: View {
    @State var localUserData:LocalUserData = PersistenceController.shared.loadUserData() ?? LocalUserData()
    @State var isAuthenticated = IsAuthenticated()
    @ObservedObject var loginViewModel = LoginVM()
    @ObservedObject var userNavigate = UserNavigate()
    @ObservedObject var vms: ProfileInfoVM
    var body: some View {
        NavigationView {
            Group {
                if isAuthenticated{
                    if localUserData.userRole == "TRAINER"{
                        TrainerMainTabView(vms: vms)
                    }else{
                        MainTabView()
                    }
                 } else {
                    SplashView()
                }
              
            }
        } .navigationViewStyle(.stack)
        .environmentObject(userNavigate)
        .onAppear{
            StripeAPI.defaultPublishableKey = "pk_test_51L5MuZFmf8FdDZk7cwdwoewaed6EZDKF53Oi10qboML869Lbvnt8KL0sKLHodAYkKR58SOwKFePBZ6Muv5mjzwMK00Mdf0eyIR"
        }
    }
    
  
}

class UserNavigate: ObservableObject {
    @Published var isUser: Bool = true
}
