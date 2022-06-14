//
//  ServiceRateView.swift
//  pr469-dogtraining-ios
//
//  Created by Uresha Lakshani on 2022-03-11.
//

import SwiftUI

struct ServiceRateView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @State var isShow : Bool = false
    var name: String
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @Binding var textField: String
    var arr = NSMutableArray()
    @State var selectService:[SelectService] = []
    @ObservedObject var vms: ProfileInfoVM
    var service: Service?
    var serviceId: Int
     var index: Int
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            
            VStack(alignment: .leading){
                HStack{
                    Button(action: {
                        let selctSer = SelectService(service_id: serviceId , price: Int(textField) ?? 0, name: name)
                        if ((vms.selectServices.contains(where: { ($0.service_id ) == serviceId })) != true) {
                            selectService.append(selctSer)
                            if vms.selectServices.count != 0{
                                vms.selectServices += selectService
                            }else{
                                vms.selectServices = selectService
                            }
                            
                            arr.add(selctSer)
                            print(arr)
                        }
                        if isShow {
                            
                            if let serviceIndex = vms.selectServices.firstIndex(where: {($0.service_id ?? 0) == selctSer.service_id}) {
                                
                                vms.selectServices.remove(at: serviceIndex)
                                
                            }
                            
                        }
                        isShow.toggle()
                    }, label: {
                        Image(isShow ? "outline_radio_button_checked_black_18pt_1x" : "outline_radio_button_unchecked_black_18pt_1x")
                            .foregroundColor(Color("#00C600"))
                            .frame(width: dWidth * 16/375, height: dWidth * 16/375)
                            .padding(.leading, 16)
                        
                    })
                    Text(name)
                        .foregroundColor(Color.white)
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                    
                    Spacer()
                }
                .padding(.vertical, 12)
                
                if isShow{
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text("Rate Per Hour")
                            .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                            .foregroundColor(Color.white)
                            .padding(.leading, 16)
                        HStack(spacing: 10){
                            Image("outline_monetization_on_black_18pt_1x")
                                .foregroundColor(Color.white)
                                .frame(width: dWidth * 16/375, height: dWidth * 16/375)
                                .padding()
                            TextField("100", text: titleBindingFor(vms.services[index]))
                            { startedEditing in
                                if startedEditing {
                                    withAnimation {

                                    }
                                }
                            }

                        .onChange(of: vms.services[index].priceNew){ newValue in
                            textField = newValue
                            let selctSer = SelectService(service_id: vms.services[index]._id , price: Int(textField) ?? 0, name: vms.services[index].service)
                            if selectService.contains(where: {$0.service_id == vms.services[index]._id}){
                                let indexs = selectService.firstIndex(where: {$0.service_id == vms.services[index]._id})
                                selectService[indexs ?? 0].price = Int(vms.services[index].priceNew) ?? 0
                                let vmsIndex = vms.selectServices.firstIndex(where: {$0.service_id == vms.services[index]._id})
                                vms.selectServices[vmsIndex ?? 0].price = Int(vms.services[index].priceNew) ?? 0
                            }
                        }
                        .onSubmit {
                            print("")
                        }
                          
                        .foregroundColor(.white)
                        .keyboardType(.decimalPad)
                            Spacer()
                        }
                        .background(
                            ZStack {
                                RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                                RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                            })
                        .padding(10)
                    }
                    
                }
            }
            .background(
                ZStack {
                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                })
            //        .frame(width: UIScreen.main.bounds.width)
            .padding(.horizontal, 0)
        }
    }
    func titleBindingFor(_ event: Service) -> Binding<String> {
      return Binding<String>.init {
            event.pivot?.price ?? ""
        } set: { new in
            vms.services[index].pivot?.price = new
            vms.services[index].priceNew = new
            print(vms.services[index].priceNew)
        }

    }
}

public struct SelectService: Codable,Hashable {
    
    
    //    public let id = UUID()
    public var service_id: Int?
    public var price: Int?
    public var name: String?
    
    //    public var createdAt: String?
    //    public var updatedAt: String?
    
    public init(service_id: Int?, price: Int?,name: String?) {
        self.service_id = service_id
        self.price = price
        self.name = name
        //        self.createdAt = createdAt
        //        self.updatedAt = updatedAt
    }
    
    public enum CodingKeys: String, CodingKey {
        case service_id = "service_id"
        case price = "price"
        case name = "service"
        
        //        case createdAt = "created_at"
        //        case updatedAt = "updated_at"
    }
    
    
}

public struct SelectPetProfile: Codable,Hashable{
    
    
    public var _id: Int?
    public var profileName: String?
    public var petName: String?
    public var userId: String?
    public var breed: String?
    public var age: String?
    public var gender: String?
    public var _description: String?
    //    public var createdAt: String?
    //    public var updatedAt: String?
    //    public var treatment: Treatment?
    public var isShow = false
    
    
    public init(_id: Int?, profileName: String?, petName: String?, userId: String?, breed: String?, age: String?, gender: String?, _description: String?) {
        self._id = _id
        self.profileName = profileName
        self.petName = petName
        self.userId = userId
        self.breed = breed
        self.age = age
        self.gender = gender
        self._description = _description
        //        self.createdAt = createdAt
        //        self.updatedAt = updatedAt
        //        self.treatment = treatment
    }
    
    public enum CodingKeys: String, CodingKey {
        case _id = "id"
        case profileName = "profile_name"
        case petName = "pet_name"
        case userId = "user_id"
        case breed
        case age
        case gender
        case _description = "description"
        //        case createdAt = "created_at"
        //        case updatedAt = "updated_at"
        //        case treatment
    }
    
    
}
