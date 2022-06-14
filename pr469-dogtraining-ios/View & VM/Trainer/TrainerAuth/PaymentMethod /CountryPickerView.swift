//
//  CountryPickerView.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 18/05/22.
//

import Foundation
import SwiftUI

struct CountryPickerView: View {
  var pickerOptions: [String]
  var width: CGFloat
  var height: CGFloat
  @Binding var showPicker: Bool
  @Binding var selectedPickerOption: String
  @State var localState : String = ""//<< Here your local State
  
  func selectOption() {
    self.selectedPickerOption = localState //<< Sync the binding with the local State
    withAnimation {
      showPicker.toggle()
    }
  }
  
  func cancel() {
    //<< do nothing here
    withAnimation {
      showPicker.toggle()
    }
  }
  
  var body: some View {
    VStack {
        
        HStack{
            Button(action: selectOption) {
              Text("Select")
            }
            .padding()
            Spacer()
            Button(action: cancel) {
              Text("Cancel")
            }
            .padding()
        }
        
      Picker(
        selection: $localState,
        label: Text("")
      ) {
        ForEach(0 ..< pickerOptions.count) {
            Text("\(self.pickerOptions[$0])")
                .foregroundColor(Color.white)
                .tag(self.pickerOptions[$0])
        }
         
      }
      .pickerStyle(WheelPickerStyle())
      
    }
    .transition(.move(edge: .bottom))
    .onAppear {
        self.localState = selectedPickerOption // << set inital value here
    }
  }
}


