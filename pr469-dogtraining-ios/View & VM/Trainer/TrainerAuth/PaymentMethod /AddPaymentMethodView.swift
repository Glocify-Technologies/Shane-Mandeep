//
//  AddPaymentMethodView.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 18/05/22.
//

import Foundation
import SwiftUI
import Stripe

struct AddPaymentMethodView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var vm = PaymentMethodVM()
    @State var countries: [String] = []
    @State var isCountrySelected = false
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @State var selection = ""
    @State var isSubmitLinkActive: Bool = false
    @State private var selectedCountry: String = ""
    @State var showsDatePicker = false
    @State var Expdate: Date? = nil
    @State var selectExpDate: String? = nil
    @State var isSaveLinkActive: Bool = false
    var body: some View {
            ZStack(alignment: .top) {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    NavBarWithBackButton(title: "Add Card") {
                        presentationMode.wrappedValue.dismiss()
                    }.padding(.top, 10)
                VStack(alignment: .leading, spacing: dWidth * 10/375)  {
                  
                    Text("Add Card Details")
                        .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 16)))
                        .padding([.leading,.trailing], 20)
                        .foregroundColor(Color.white)
                    CardInputTextfield(title: "Card Number",placeHoleder: "Please enter your card number", keyboard: .phonePad, isValidation: Validators().nonEmptyValidator(value: vm.CardNumber).isSuccess, isValidationRuntime: $vm.CardNumberValidation, textFiled: $vm.CardNumber)
                        .validate(with: vm.CardNumber, validation: Validators().nonEmptyValidator)
                        .padding(.top, dWidth * 20/375)
                        .padding([.leading,.trailing], 20)
                       
                    
                    HStack{
//                        DatePickerTextField(placeholder: "Select Date", date: $Expdate).frame(height: 60)
                        CardExpDateInputField(title: "Exp. Date",placeHoleder: "MM/YY", keyboard: .phonePad, isValidation: Validators().nonEmptyValidator(value: Globals.dateFormatter.string(from: vm.Expdate)).isSuccess, isValidationRuntime: $vm.CardExpDateValidation, textFiled: $vm.selectedDate,Expdate: vm.Expdate,selectExpdate: $selectExpDate)
                            .validate(with: Globals.dateFormatter.string(from: vm.Expdate), validation: Validators().nonEmptyValidator)
                            .padding(.top, dWidth * 20/375)
                            .padding([.leading,.trailing], 20)
                        CardCVVInputTextfield(placeHoleder: "XXXX", name: "CVC", textfiled: $vm.CVC, keyboard: .default)
                            .validate(with: vm.CVC, validation: Validators().nonEmptyValidator)
                            .padding(.top, dWidth * 20/375)
                            .padding([.leading,.trailing], 20)
                    }
//                    if showsDatePicker {
//                        DatePicker("",selection:$Expdate, displayedComponents: .date)
//                                    .datePickerStyle(WheelDatePickerStyle())
//                                    .foregroundColor(Color.white)
//
//                        }
                    VStack{
                        Button(action: {
                            isCountrySelected.toggle()
                        }, label: {
                            DropDownList(title: "Country", name:selectedCountry, option: "", image: "outline_expand_more_black_18pt_1x")
                        .padding(.top, dWidth * 16/375)
                        .padding([.leading,.trailing], 20)

                        })
                        
                        if isCountrySelected{
                            CountryPickerView(
                                     pickerOptions: countries,
                                     width: 300,
                                     height: 150,
                                     showPicker: $isCountrySelected,
                                     selectedPickerOption: $selectedCountry
                            
                            )
                                .foregroundColor(Color.white)
                        }
                                 
                    }//VStack
                    
                    HStack{
                        Image(uiImage: isSaveLinkActive == true ? UIImage(named: "outline_check_box_black_18pt_2x")! : UIImage(named: "outline_check_box_outline_blank_black_18pt_1x")!)
                            .resizable()
                            .foregroundColor(Color("#00C600"))
                            .frame(width: dWidth * 30/375, height: dWidth * 30/375, alignment: .center)
                            .cornerRadius(dWidth * 10/375)
                            .padding(.leading,dWidth * 16/375)
                        
                        Text("Save this card")
                            .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 16)))
                            .padding([.leading,.trailing], 5)
                            .foregroundColor(Color.white)
                    }.onTapGesture {
                        isSaveLinkActive.toggle()
                    }
                    Spacer()
                  
                }
//                    NavigationLink (
//                        destination: AnyView(_fromValue: "").navigationBarHidden(true),
//                        isActive: $isSubmitLinkActive,
//                        label: {
                            ButtonCommon(buttonName: "Save Card", someAction: {
                              
                                let stripeCardParams = STPCardParams()
                                stripeCardParams.number = vm.CardNumber
                                let expiryParameters = selectExpDate?.components(separatedBy: "/")
                                stripeCardParams.expMonth = UInt(expiryParameters?.first ?? "0") ?? 0
                                stripeCardParams.expYear = UInt(expiryParameters?.last ?? "0") ?? 0
                                stripeCardParams.cvc = vm.CVC
                                let isValid = isCardDetailValid(cardNumber: vm.CardNumber, month: UInt(expiryParameters?.first ?? "0") ?? 0, year: UInt(expiryParameters?.last ?? "0") ?? 0, cvv: vm.CVC)
                                    
                                if isValid == true{
                                    vm.createStripeToken(stripeCardParams: stripeCardParams){ success,token  in
                                        vm.addNewPaymentMethod(paymentMethodId: token, isDefaultMethod: "0") { value in
                                            print("")
                                            if value == true{
    //                                            isSubmitLinkActive.toggle()
                                                presentationMode.wrappedValue.dismiss()
                                            }
                                          
                                        }
                                    }
                                }else{
                                    vm.isShowAlert = true
                                    vm.alertTitle = "Stripe"
                                    vm.alertMessage = "InValid Card Info. "
                                }
                               
                              
                            }).frame(alignment: .center)
                            
                         .padding(.top, dWidth * 40/375)
                        .padding(.bottom, dWidth * 30/375)
                    Spacer()
                }
            }.onAppear {
                for code in NSLocale.isoCountryCodes  {
                    let id = NSLocale.localeIdentifier(fromComponents: [NSLocale.Key.countryCode.rawValue: code])
                    let name = NSLocale(localeIdentifier: "en_UK").displayName(forKey: NSLocale.Key.identifier, value: id) ?? "Country not found for code: \(code)"
                    countries.append(name)
                }
                
                print(countries)
            }
            .alert(isPresented: $vm.isShowAlert) {
             Alert(
                title: Text(vm.alertTitle),
                 message: Text(vm.alertMessage),
                 dismissButton: .default(Text("Okay"), action: {
                     
                 })
             )
         }
        
       
    }
    
    func isCardDetailValid(cardNumber : String, month : UInt, year : UInt, cvv : String) -> Bool {
        let params = STPCardParams()
        params.number = cardNumber
        params.expMonth = month
        params.expYear = year
        params.cvc = cvv
        if STPCardValidator.validationState(forCard: params) == .valid {
            return true
        } else {
            return false
        }
    }
}
