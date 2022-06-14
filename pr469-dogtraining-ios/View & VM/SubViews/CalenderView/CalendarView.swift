//
//  CalendarView.swift
//  GratiBox
//
//  Created by Praveen Nirmal on 20/1/22.
//

import Foundation
import SwiftUI


struct CalendarView: View {    
    @Binding var selectedDate: Date
    @State var crntPage: Date = Date()
    @State var selectedYear = 2022
    @Binding var selectedDateStr: String
    @Binding var selectedOnlyDateStr: String
    @State private var showYears = false
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    
    var body: some View {
        VStack {
            FSCalendarView(pageCurrent: $crntPage, selectedDate: $selectedDate, selectedOnlyDateStr: $selectedOnlyDateStr, selectedDateStr: $selectedDateStr)
                .padding(5)
                .frame(width: Screen.width - 32, height: Screen.width - 32, alignment: .center)
                .padding(.top, 35)
        }
        .background(
            ZStack {
                RoundedRectangle (cornerRadius: Screen.sizeFromWidth(size: 10)).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                RoundedRectangle (cornerRadius: Screen.sizeFromWidth(size: 10)).stroke(Color("#7E7E7E"),lineWidth: 0.5)
            })
        .overlay(
            GeometryReader { geo in
                VStack(spacing: 0) {
                    HStack(spacing: Screen.sizeFromWidth(size: 5)) {
                        /// Prveious Month
                        Button(action: {
                            /// Substarcting one month for  the current date
                            self.crntPage = Calendar.current.date(byAdding: .month, value: -1, to: self.crntPage)!
                        }, label: {
                            Image("outline_arrow_back_ios_black_18pt_1x")
                                .resizable()
                                .frame(width: Screen.sizeFromWidth(size: 24), height: Screen.sizeFromWidth(size: 24))
                                .foregroundColor(Color("#00C600"))
                                .padding(.horizontal, 5)
                        })
                        
                        Spacer()
                        Text(crntHeader(crntPage))
                            .font(.customFont(.SFProTextMedium, Screen.sizeFromWidth(size: 14)))
                            .foregroundColor(Color.white)
                            .padding(.leading, 6)
                        Spacer()
                        
                        /// Next Month
                        Button(action: {
                            /// Adding one month for the current date
                            self.crntPage = Calendar.current.date(byAdding: .month, value: 1, to: self.crntPage)!
                        }, label: {
                            Image("outline_arrow_forward_ios_black_18pt_1x")
                                .resizable()
                                .frame(width: Screen.sizeFromWidth(size: 24), height: Screen.sizeFromWidth(size: 24))
                                .foregroundColor(Color("#00C600"))
                                .padding(.horizontal, 5)
                        })
                    }
                    .padding(.horizontal, 16)
                    .frame(height: 50, alignment: .center)
                    .background(
                        ZStack {
                            RoundedRectangle (cornerRadius: Screen.sizeFromWidth(size: 18)).fill(Color.black.opacity(0.45))
                            RoundedRectangle (cornerRadius: Screen.sizeFromWidth(size: 18)).stroke(Color("#7E7E7E"),lineWidth: 0.5)
                        })
                    .padding(.horizontal, 14)
                    .padding(.top, 21)
                    
                    if showYears {
                        Picker("", selection: $selectedYear) {
                            ForEach(1990...2100, id: \.self) {
                                Text(String($0))
                            }
                        }
                        .pickerStyle(InlinePickerStyle())
                        .frame(height: geo.size.height - 50)
                        .background(
                            RoundedRectangle(cornerRadius: 13).fill(Color.white)
                        )
                        .transition(.move(edge: .top))
                    }
                }
            }
            ,alignment: .topLeading)
    }
    
    func crntHeader(_ crntPage: Date) -> String {
        /// Creating formatter to get yearly string
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "MMMM yyyy"
        /// Getting current  date year as a String and Convert  to an Int
        let crntYear = yearFormatter.string(from: crntPage)
        
        return crntYear
        
    }
}


struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            CalendarView(selectedDate: .constant(Date()), selectedDateStr: .constant(""), selectedOnlyDateStr: .constant(""))
        }
    }
}
