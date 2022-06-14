//
//  FSCalendarView.swift
//  GratiBox
//
//  Created by Praveen Nirmal on 7/2/22.
//

import SwiftUI
import UIKit
import FSCalendar

struct FSCalendarView: UIViewRepresentable {
    
    //MARK: - PROPERTIES
    @Binding var pageCurrent: Date
    @Binding var selectedDate: Date
    @Binding var selectedOnlyDateStr: String

    @Binding var selectedDateStr: String
    var calendar = FSCalendar()
    
    //make the UI
    func makeUIView(context: Context) -> FSCalendar {
        calendar.dataSource = context.coordinator
        calendar.delegate = context.coordinator
        //MARK:- Header (top month and year area)
        /// Font color of the header
        calendar.appearance.headerTitleColor = UIColor(Color.clear)
        calendar.appearance.headerTitleFont = UIFont(name: "SF Pro Text Medium", size: 14)
        /// HIde next and previous months from header
        calendar.appearance.headerMinimumDissolvedAlpha = 0
        
        //MARK:- Today
        /// Colour of title (date)
        calendar.appearance.titleTodayColor =  UIColor(Color.white)
        /// Background colour when selected
        calendar.appearance.todaySelectionColor =  UIColor(Color(.black))
        /// Override the default colour of the background shape
        calendar.appearance.todayColor = UIColor(Color(.black))
        
        //MARK:- Other Day
        /// Background colour when selected
        calendar.appearance.selectionColor = UIColor(Color("#00A100"))
        calendar.appearance.titleDefaultColor = UIColor(Color.white)
        /// Border colour when selected
        calendar.appearance.borderSelectionColor = UIColor(Color("#5CFF5C"))
        /// Font of the date
        calendar.appearance.titleFont = UIFont(name: "SF Pro Text Light", size: 14)
        /// Selected date title (date) colour
        calendar.appearance.titleSelectionColor = UIColor(Color.white)
        
        //MARK:- Week Day
        /// Weekday title's font colour
        calendar.appearance.weekdayTextColor = UIColor(Color.white)
        calendar.appearance.weekdayFont = UIFont(name: "SF Pro Text Bold", size: 14)
        /// Weekday title style to shows one letter
        calendar.appearance.caseOptions = FSCalendarCaseOptions.weekdayUsesSingleUpperCase
        
        /// Corner radius of the background shape; 1(circle) - 0(square)
        calendar.appearance.borderRadius = 1
        
        /// Style of the previous and next month dates appear as placeholders
        calendar.placeholderType = .fillHeadTail
        
        
        return calendar
    }
    
    //update calendar view when click on left or right button
    func updateUIView(_ uiView: FSCalendar, context: Context) {
        uiView.setCurrentPage(pageCurrent, animated: true)
    }
    
    func makeCoordinator() -> FSCalendarView.Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDataSource {
        var parent: FSCalendarView
        
        init(_ parent: FSCalendarView) {
            self.parent = parent
        }
        
        func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
            parent.pageCurrent = calendar.currentPage
        }
        
        //selectedate of calendar
        func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
            parent.selectedDate = calendar.selectedDate ?? Date()
            let df = DateFormatter()
               df.dateFormat = "yyyy-MM-dd hh:mm:ss"
               let now = df.string(from: date)
               print("Date: \(now)")
            parent.selectedDateStr = now
            let dff = DateFormatter()
            dff.dateFormat = "yyyy-MM-dd"
               let nows = dff.string(from: date)
               print("Date: \(nows)")
            parent.selectedOnlyDateStr = nows
        }
        
        //disable future dates from selection
        //        func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        //            if date > calendar.today ?? Date() {
        //                return false
        //            }
        //            if date < Date() {
        //                return false
        //            }
        //            else {
        //                return true
        //            }
        //        }
    }
}

struct FSCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            FSCalendarView(pageCurrent: .constant(Date()), selectedDate: .constant(Date()), selectedOnlyDateStr: .constant(""), selectedDateStr: .constant(""))            .frame(width: Screen.width - 32, height: Screen.width - 32)
        }
    }
}
