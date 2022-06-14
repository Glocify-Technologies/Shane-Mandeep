//
//  PickerView.swift
//  pr469-dogtraining-ios
//
//  Created by Sandaruwan Bamunusinghe on 2022-03-11.
//

import SwiftUI

struct PickerView: View {
  var pickerOptions: [Int]
  var width: CGFloat
  var height: CGFloat
  @Binding var showPicker: Bool
  @Binding var selectedPickerOption: Int
  @State var localState : Int = 1//<< Here your local State
  
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


