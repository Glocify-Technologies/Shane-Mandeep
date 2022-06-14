//
//  DatePickerTextField.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 18/05/22.
//

import Foundation
import SwiftUI

struct DatePickerTextField: UIViewRepresentable {
    private let textField = UITextField()
    private let datePicker = UIDatePicker()
    private let helper = Helper()
    private let cureentDate = Date()
    public var placeholder: String
    @Binding public var date: Date?
    @Binding public var expDate: String?
//    @Binding public var selectDate: String?
    @ObservedObject var vm = PaymentMethodVM()
    
    
    func makeUIView(context: Context) -> UITextField {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.minimumDate = cureentDate
        datePicker.addTarget(self.helper, action: #selector(self.helper.dateValueChanged), for: .valueChanged)
        textField.textColor = UIColor.white
        textField.placeholder = placeholder
        textField.inputView = datePicker
        //textField.borderStyle = .roundedRect
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: helper, action: #selector(helper.doneButtonTapped))
        
        toolbar.setItems([flexibleSpace, doneButton], animated: true)
        textField.inputAccessoryView = toolbar
        
        helper.onDateValueChanged = {
            date = datePicker.date
        }
        
        helper.onDoneButtonTapped = {
            if date == nil {
                date = datePicker.date
               
            }
            if let selectedDate = date {
                print(Globals.dateFormatter.string(from: selectedDate))
                vm.selectedDate = Globals.dateFormatter.string(from: selectedDate)
               
            }
            textField.resignFirstResponder()
        }
        
        return textField
    }
    
    func updateUIView(_ uiView: UITextField, context: Context) {
        if let selectedDate = date {
            uiView.text = Globals.dateFormatter.string(from: selectedDate)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Helper {
        public var onDateValueChanged: (() -> Void)?
        public var onDoneButtonTapped: (() -> Void)?
        
        @objc func dateValueChanged() {
            onDateValueChanged?()
        }
        
        @objc func doneButtonTapped() {
            onDoneButtonTapped?()
           
        }
    }
    
    class Coordinator {}
}
struct Globals {
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/YY"
        
        return formatter
    }()
}
