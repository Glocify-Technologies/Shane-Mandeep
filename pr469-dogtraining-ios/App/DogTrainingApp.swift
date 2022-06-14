//
//  iBSwiftUIExampleApp.swift
//  iBSwiftUIExample
//
//  Created by Sandhun Senavirathna on 2021-03-02.
//

import SwiftUI
import Stripe

@main
struct DogTrainingApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView(vms: ProfileInfoVM())
//            PaymentMethodView(vms: ProfileInfoVM())
//            AddPaymentMethodView()
        }
    }
}
