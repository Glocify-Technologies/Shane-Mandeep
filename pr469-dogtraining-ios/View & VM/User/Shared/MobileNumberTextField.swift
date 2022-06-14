//
//  MobileNumberTextField.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-23.
//

import SwiftUI

struct MobileNumberTextField: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @Binding var textFiled: String
    var mobiletext: String
    var title: String
    var code: String
    @State var countryCode = ""
    @State var countryFlag = ""
    @State var phoneNumber = ""
    @State var y : CGFloat = 300
    @StateObject var vm = ProfileInfoVM()
      
//    @ObservedObject var codeTextField = ObservableTextField()
    @Binding var codeTextField: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(mobiletext)
                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 16/375)
            
            HStack(spacing: dWidth * 12/375) {
                HStack {
                    Text("\(flag(country: getCountryCode(codeTextField != "" ? codeTextField : code  )))")
                        .frame(width: 30, height: 50)
                        .foregroundColor(Color.white)
                    
                    TextField(code, text: $codeTextField)
                        .keyboardType(.phonePad)
                        .frame(width: 40, height: 50)
                        .foregroundColor(Color.white)
                }
                .frame(width: dWidth * 120/375, height: dWidth * 48/375)
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                        RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                    })
                
                TextField(title, text: $textFiled)
                    .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                    .foregroundColor(Color.white)
                    .autocapitalization(.none)
                    .padding()
                    .keyboardType(.phonePad)
                    .background(
                        ZStack {
                            RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                            RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                        })
            } //:HStack
        } //:VStack
    }


    
    func flag(country:String) -> String {
        let base : UInt32 = 127397
        var flag = ""
        for v in country.unicodeScalars {
            flag.unicodeScalars.append(UnicodeScalar(base + v.value)!)
        }
        return flag
    }
    func getCountryCode (_ country : String) -> String
    {
        if let key = countryDictionary.first(where: { $0.value == country })?.key {
            return key
        }
        return ""
    }
    let countryDictionary = ["US":"+1", "RU":"+7", "EG":"+20", "ZA":"+27", "GR":"+30", "NL":"+31", "BE":"+32", "FR":"+33", "ES":"+34", "HU":"+36", "IT":"+39", "RO":"+40", "CH":"+41", "AT":"+43", "GG":"+44", "DK":"+45", "SE":"+46", "NO":"+47", "PL":"+48", "DE":"+49", "PE":"+51", "MX":"+52", "CU":"+53", "AR":"+54", "BR":"+55", "CL":"+56", "CO":"+57", "VE":"+58", "MY":"+60", "AU":"+61", "ID":"+62", "PH":"+63", "NZ":"+64", "SG":"+65", "TH":"+66", "JP":"+81", "KR":"+82", "VN":"+84", "CN":"+86", "TR":"+90", "IN":"+91", "PK":"+92", "AF":"+93", "LK":"+94", "MM":"+95", "IR":"+98", "MA":"+212", "DZ":"+213", "TN":"+216", "LY":"+218", "GM":"+220", "SN":"+221", "MR":"+222", "ML":"+223", "GN":"+224", "CI":"+225", "BF":"+226", "NE":"+227", "TG":"+228", "BJ":"+229", "MU":"+230", "LR":"+231", "SL":"+232", "GH":"+233", "NG":"+234", "TD":"+235", "CF":"+236", "CM":"+237", "CV":"+238", "ST":"+239", "GQ":"+240", "GA":"+241", "BS":"+242", "CD":"+243", "AO":"+244", "GW":"+245", "SC":"+248", "SD":"+249", "RW":"+250", "ET":"+251", "SO":"+252", "DJ":"+253", "KE":"+254", "TZ":"+255", "UG":"+256", "BI":"+257", "MZ":"+258", "ZM":"+260", "MG":"+261", "YT":"+262", "ZW":"+263", "AI":"+264", "MW":"+265", "LS":"+266", "BW":"+267", "SZ":"+268", "KM":"+269", "SH":"+290", "ER":"+291", "AW":"+297", "FO":"+298", "GL":"+299", "GI":"+350", "PT":"+351", "LU":"+352", "IE":"+353", "IS":"+354", "AL":"+355", "MT":"+356", "CY":"+357", "AX":"+358", "BG":"+359", "LT":"+370", "LV":"+371", "EE":"+372", "MD":"+373", "AM":"+374", "BY":"+375", "AD":"+376", "MC":"+377", "SM":"+378", "VA":"+379", "UA":"+380", "RS":"+381", "ME":"+382", "HR":"+385", "SI":"+386", "BA":"+387", "MK":"+389", "CZ":"+420", "SK":"+421", "LI":"+423", "FK":"+500", "BZ":"+501", "GT":"+502", "SV":"+503", "HN":"+504", "NI":"+505", "CR":"+506", "PA":"+507", "HT":"+509", "GP":"+590", "BO":"+591", "GY":"+592", "EC":"+593", "GF":"+594", "PY":"+595", "MQ":"+596", "SR":"+597", "UY":"+598", "AN":"+599", "TL":"+670", "AQ":"+672", "BN":"+673", "NR":"+674", "PG":"+675", "TO":"+676", "SB":"+677", "VU":"+678", "FJ":"+679", "PW":"+680", "WF":"+681", "CK":"+682", "NU":"+683", "WS":"+685", "KI":"+686", "NC":"+687", "TV":"+688", "PF":"+689", "TK":"+690", "FM":"+691", "MH":"+692", "KP":"+850", "HK":"+852", "MO":"+853", "KH":"+855", "LA":"+856", "BD":"+880", "TW":"+886", "MV":"+960", "LB":"+961", "JO":"+962", "SY":"+963", "IQ":"+964", "KW":"+965", "SA":"+966", "YE":"+967", "OM":"+968", "PS":"+970", "AE":"+971", "BH":"+973", "QA":"+974", "BT":"+975", "MN":"+976", "NP":"+977", "TJ":"+992", "TM":"+993", "AZ":"+994", "GE":"+995", "KG":"+996", "UZ":"+998"]

}

struct MobileNumberTextField_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
            MobileNumberTextField(textFiled: .constant(""), mobiletext: "Mobile", title: "type", code: "+64", codeTextField: .constant(""))
        }
    }
}
class ObservableTextField: ObservableObject {
    
    @Published var value = "" {
        didSet {
            if value.count > 3 {
                value = String(value.prefix(3))
            }
        }
    }
    
}
