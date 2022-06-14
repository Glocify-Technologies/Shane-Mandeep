//
//  PreferredServiceView.swift
//  pr469-dogtraining-ios
//
//  Created by Sandaruwan Bamunusinghe on 2022-03-10.
//

import SwiftUI

struct PreferredServiceView: View {
    
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var vms: AddPetProfileVM
  
    @Binding var textFiled: String
    @Binding var serviceId: String
    @StateObject var vm:AddPetProfileVM
    @Binding var services: [Service] 
    var arr = NSMutableArray()
    @State var selectService:[SelectService] = []
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dWidth * 10/375)
                .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                .foregroundColor(Color.black.opacity(0.26))
                .frame(width: dWidth * 355/375, height: dWidth * 224/375)
            
            VStack(spacing: dWidth * 16/375) {
                List {
                    ForEach(services, id: \.self) { service in
                        HStack {
                            //                                       {
                            Button(action: {
                                let index = services.firstIndex(of: service)
                                selectService.removeAll()
                                 if (!(vms.selectPreferedServices.contains(where: { ($0.service_id ) == service._id }))) {
                                let selctSer = SelectService(service_id: Int(service._id ?? 0) , price: Int(textFiled) ?? 0, name: service.service)
                                selectService.append(selctSer)
                               
                                services[index ?? 0].isShow = true
//                                 if vms.selectServices.count != 0{
//                                     vms.selectServices += selectService
//                                 }else{
                                     vms.selectPreferedServices = selectService
//                                 }
                               
                                arr.add(selctSer)
                                print(arr)
                                 }else{
                                     services[index ?? 0].isShow = false
                                 }
                               
                                vms.isServicesShow.toggle()
                                if services[index ?? 0].isShow{
                                    
                                    serviceId = "\(service._id ?? 0)"
                                    textFiled =  service.service ?? ""
                                    
                                }else{
                                    textFiled = ""
                                    if vms.selectPreferedServices.count != 0{
                                        vms.selectPreferedServices.forEach { item in
                                            if service._id == item.service_id{
                                                let i = vms.selectPreferedServices.firstIndex(of: item)
                                                vms.selectPreferedServices.remove(at: i!)
                                                services[index ?? 0].isShow = false
                                            
                                            
                                        }
                                        
                                    }
                                    
                                }
                                }
//                               vms.ServicesText = ""
//                               vms.selectServices.forEach { Service in
//                                   if vms.ServicesText != ""{
//                                       vms.ServicesText = vms.ServicesText + "," + (Service.name ?? "")
//                                   }else{
//                                       vms.ServicesText =  Service.name ?? ""
//                                   }
//                            }
                                vms.selectPreferedServices.forEach { SelectServices in
                                    services.forEach { PetProfile in
                                        let indexs = services.firstIndex(of:PetProfile)
                                        if PetProfile._id == SelectServices.service_id{
                                            services[indexs ?? 0].isShow = true
                                        }else{
                                            services[indexs ?? 0].isShow = false
                                        }
                                    }
                                }
                            }, label: {
                                Image(service.isShow ? "outline_check_box_black_18pt_2x" : "outline_check_box_outline_blank_black_18pt_1x")
                                    .resizable()
                                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                    .clipped()
                                    .foregroundColor(Color("#00C600"))
                                
                            })
                            Text(service.service ?? "")
                                .font(.custom("SFProText-Semibold", size: dWidth * 12/375))
                                .foregroundColor(.white)
                            
                            Spacer()
                            
                        }
                        
                    }.listRowBackground(backgroundColor)
                }
                .onAppear(perform: {
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                    UITableView.appearance().separatorColor = .clear
                    UITableView.appearance().backgroundView = nil
                    UITableViewCell.appearance().backgroundView = nil
                    UITableViewCell.appearance().contentView.backgroundColor = UIColor.clear
                    UITableView.appearance().backgroundView?.backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundView?.backgroundColor = UIColor.clear
                    UITableView.appearance().showsVerticalScrollIndicator = false
                })
                .padding(.top, -40)
                
                .padding(.leading, -40)
                
                .padding(.trailing, 0)

            }
            .padding(.top, dWidth * 60/375)
            .padding(.leading, dWidth * 32/375)
        }
    }
 
}
struct PreferredServiceView_Previews: PreviewProvider {
    static var previews: some View {
        PreferredServiceView(vms: AddPetProfileVM(), textFiled: .constant(""), serviceId: .constant(""), vm: AddPetProfileVM(), services: .constant([Service(_id: 0, service: "", createdAt: "", updatedAt: "", pivot: Pivot(service_id: nil, trainer_id: nil, price: nil))]))
    }
}
