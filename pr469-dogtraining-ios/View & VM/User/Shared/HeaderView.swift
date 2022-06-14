//
//  HeaderView.swift
//  pr469-dogtraining-ios
//
//  Created by Sachindra Fernando on 12/16/21.
//

import SwiftUI

struct HeaderView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    //MARK: - SCREEN NAVIGATION
    var headerName: String
    var body: some View {
        HStack{
            Button(action: {
              self.presentationMode.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.backward")

                    .foregroundColor(.white)
            })
            
            Spacer()
            Text("\(headerName)")
              .foregroundColor(.white)
              
            Spacer()
            
              ZStack {
                  HStack {
                  }.frame(width: dWidth * 24/375)
              } //:ZStack
        } //:HStack
        .padding(.top,dWidth * 39/375)
        .padding(.leading,dWidth * 16/375)
        .padding(.trailing,dWidth * 16/375)
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView(headerName: "")
            .previewLayout(.sizeThatFits)
    }
}
