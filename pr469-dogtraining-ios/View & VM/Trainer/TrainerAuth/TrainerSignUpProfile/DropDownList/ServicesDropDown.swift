//
//  ServicesDropDown.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-31.
//

import SwiftUI

struct ServicesDropDown: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])

//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            VStack(spacing: dWidth * 16/375) {
                HStack {
                    Image("outline_check_box_outline_blank_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    Text("Private Sessions")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Image("outline_check_box_outline_blank_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    Text("Virtual Sessions")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Image("outline_check_box_outline_blank_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    Text("Boarding & Training")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Image("outline_check_box_outline_blank_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    Text("Group Clases")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding()
            .padding(.top, dWidth * 10/375)
            .background(
                RoundedRectangle(cornerRadius: dWidth * 10/375)
                    .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                    .foregroundColor(Color.black.opacity(0.26))
            )
        }
    }
}

struct serviceRateDrop : View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dWidth * 10/375)
                .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                .foregroundColor(Color.black.opacity(0.26))
                .frame(width: dWidth * 355/375, height: dWidth * 184/375)
            
            VStack(spacing: dWidth * 16/375) {
              
                Text("title")
                    .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                    .foregroundColor(Color.white)
                    .padding(.leading, dWidth * 16/375)
                ZStack {
                    RoundedRectangle(cornerRadius: dWidth * 10/375)
                        .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                        .foregroundColor(Color.black.opacity(0.26))
                        .frame(width: dWidth * 355/375, height: dWidth * 184/375)
                HStack {
                    Image("outline_check_box_outline_blank_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    Text("Agility")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(.white)
                   
                }
            }
               
            .padding(.top, dWidth * 60/375)
            .padding(.leading, dWidth * 32/375)
        }
    }
}
}


struct DogSportDrop: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @ObservedObject var vms: ProfileInfoVM
    @State var isSportShow : Bool = false
    @Binding var textFiled: String
    @Binding var sportsId: String
    @Binding var isDogSportTitle: Bool
    @Binding var dogSportsTitle: [String]
    let arr = ["ewrffer","reerf","freefr","erfer","reefrfer","er","ewrffer","reerf","freefr","erfer","reefrfer","er"]
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dWidth * 14/375)
                .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                .foregroundColor(Color.black.opacity(0.26))
                .frame(width: dWidth * 355/375, height: dWidth * 224/375)
            
            VStack(alignment: .leading) {
//                Spacer()
//                HStack {
                    List {
                               ForEach(vms.sportTitle, id: \.self) { ser in
                                   HStack {
//                                       {
                                           Button(action: {

                                               
                                               isSportShow.toggle()
                                               let index = vms.sportTitle.firstIndex(of: ser)
                                               if vms.getTrainer?.sportTitles?.contains(where: { item in
                                                   
                                                   ser._id == item._id
                                                   
                                               }) ?? false {
                                                   
                                                   vms.getTrainer?.sportTitles?.forEach { item in
                                                       
                                                       if ser._id == item._id{
                                                           
                                                           let i = vms.getTrainer?.sportTitles?.firstIndex(of: item)
                                                           
                                                           vms.getTrainer?.sportTitles?.remove(at: i!)
                                                           let ig = dogSportsTitle.firstIndex(of: item.title ?? "")
                                                           dogSportsTitle.remove(at: ig!)
                                                           vms.sportTitle[index ?? 0].isShow = false
                                                           
                                                       }
                                                       
                                                   }
                                                   
                                               }else{
                                                   
                                                   vms.getTrainer?.sportTitles?.append(ser)
                                                   dogSportsTitle.append(ser.title ?? "")
                                                   textFiled = ser.title ?? ""
                                                   if sportsId != ""{
                                                       sportsId = sportsId + "," + "\(ser._id ?? 0)"
                                                   }else{
                                                       sportsId = "\(ser._id ?? 0)"
                                                   }
                                                 
                                                   
                                                   vms.sportTitle[index ?? 0].isShow = true
                                                   
                                               }
                                           }, label: {
                                               Image(ser.isShow ? "outline_check_box_black_18pt_2x" : "outline_check_box_outline_blank_black_18pt_1x")
                                                   .resizable()
                                                   .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                                   .clipped()
                                                   .foregroundColor(Color("#00C600"))
                                                   
                                           })
                                           Text(ser.title ?? "")
                                           .font(.custom("SFProText-Semibold", size: dWidth * 12/375))
                                           .foregroundColor(.white)
                                            
                                           Spacer()
                                       
                                   }.onAppear {
                                       if sportsId == "\(ser._id ?? 0)" {
                                           isSportShow = true
                                       }
                                   }
                                  
                               }.listRowBackground(backgroundColor)
                    }.onAppear{
                        UITableView.appearance().separatorStyle = .none
                        UITableView.appearance().backgroundColor = UIColor.clear
                        UITableViewCell.appearance().backgroundColor = UIColor.clear
                        UITableView.appearance().separatorColor = .clear
                        UITableView.appearance().backgroundView = nil
                        UITableViewCell.appearance().backgroundView = nil
                        UITableViewCell.appearance().contentView.backgroundColor = UIColor.clear
                        UITableView.appearance().backgroundView?.backgroundColor = UIColor.clear
                        UITableViewCell.appearance().backgroundView?.backgroundColor = UIColor.clear

                    }
                    .padding(.top, -40)
                
                    .padding(.leading, -25)
                
                    .padding(.trailing, 0)
//                    Image("outline_check_box_outline_blank_black_18pt_1x")
//                        .resizable()
//                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//                        .clipped()
//                        .foregroundColor(Color("#00C600"))
//                    Text("Agility")
//                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                        .foregroundColor(.white)
//                    Spacer()
//                }
//                HStack {
//                    Image("outline_check_box_outline_blank_black_18pt_1x")
//                        .resizable()
//                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//                        .clipped()
//                        .foregroundColor(Color("#00C600"))
//                    Text("Coursing")
//                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                        .foregroundColor(.white)
//                    Spacer()
//                }
//                HStack {
//                    Image("outline_check_box_outline_blank_black_18pt_1x")
//                        .resizable()
//                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//                        .clipped()
//                        .foregroundColor(Color("#00C600"))
//                    Text("Obedience")
//                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                        .foregroundColor(.white)
//                    Spacer()
//                }
//                Spacer()
            }
            .padding(.top, dWidth * 60/375)
            .padding(.leading, dWidth * 32/375)
        }
    }
}

struct TrainingExpDropDown: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @ObservedObject var vms: ProfileInfoVM
    @State var isExpShow : Bool = false
    @Binding var textFiledExp: String
    @Binding var isTrainingExperience: Bool
    @Binding var ExpId: String
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dWidth * 14/375)
                .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                .foregroundColor(Color.black.opacity(0.26))
                .frame(width: dWidth * 355/375, height: dWidth * 224/375)
            
            VStack(spacing: dWidth * 16/375) {
                //                Spacer()
                //                HStack {
                List {
                ForEach(0..<vms.experience.count) { index in
                    
                    HStack {

                        Button(action: {

                            isExpShow.toggle()

                            if (vms.experience[index]._id ?? 0) == (Int(ExpId) ?? 0) {

                                textFiledExp = ""

                                ExpId = ""

                                isTrainingExperience.toggle()

                            }else{

                                textFiledExp = "\(vms.experience[index].experience ?? "") year"

                                ExpId = "\(vms.experience[index]._id ?? 0)"

                                isTrainingExperience.toggle()

                            }

                        }, label: {

                            Image((vms.experience[index]._id ?? 0) == (Int(ExpId) ?? 0) ? "outline_check_box_black_18pt_2x" : "outline_check_box_outline_blank_black_18pt_1x")

                                .resizable()

                                .frame(width: dWidth * 24/375, height: dWidth * 24/375)

                                .clipped()

                                .foregroundColor(Color("#00C600"))

                            

                        })

                        Text("\(vms.experience[index].experience ?? "") year")

                            .font(.custom("SFProText-Semibold", size: dWidth * 12/375))

                            .foregroundColor(.white)

                        

                        Spacer()

                        

                    }.onAppear {

                        if "\(vms.experience[index]._id ?? 0)" == ExpId {

                            isExpShow = true

                        }

                    }

                    

                }.listRowBackground(backgroundColor)
                }.onAppear{
                    UITableView.appearance().separatorStyle = .none
                    UITableView.appearance().backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundColor = UIColor.clear
                    UITableView.appearance().separatorColor = .clear
                    UITableView.appearance().backgroundView = nil
                    UITableViewCell.appearance().backgroundView = nil
                    UITableViewCell.appearance().contentView.backgroundColor = UIColor.clear
                    UITableView.appearance().backgroundView?.backgroundColor = UIColor.clear
                    UITableViewCell.appearance().backgroundView?.backgroundColor = UIColor.clear

                }
                .padding(.top, -40)
                
                .padding(.leading, -25)
                
                .padding(.trailing, 0)
                //                    Image("outline_check_box_outline_blank_black_18pt_1x")
                //                        .resizable()
                //                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                //                        .clipped()
                //                        .foregroundColor(Color("#00C600"))
                //                    Text("Agility")
                //                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                //                        .foregroundColor(.white)
                //                    Spacer()
                //                }
                //                HStack {
                //                    Image("outline_check_box_outline_blank_black_18pt_1x")
                //                        .resizable()
                //                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                //                        .clipped()
                //                        .foregroundColor(Color("#00C600"))
                //                    Text("Coursing")
                //                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                //                        .foregroundColor(.white)
                //                    Spacer()
                //                }
                //                HStack {
                //                    Image("outline_check_box_outline_blank_black_18pt_1x")
                //                        .resizable()
                //                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                //                        .clipped()
                //                        .foregroundColor(Color("#00C600"))
                //                    Text("Obedience")
                //                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                //                        .foregroundColor(.white)
                //                    Spacer()
                //                }
                //                Spacer()
            }
            .padding(.top, dWidth * 60/375)
            .padding(.leading, dWidth * 32/375)
        }
    }
}
struct TrainingServiceDropDown: View {

    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var vms: ProfileInfoVM
  
    @Binding var textFiled: String
    @Binding var serviceId: String
    @StateObject var vm:ProfileInfoVM

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
                    ForEach(vm.services, id: \.self) { service in
                        HStack {
                            //                                       {
                            Button(action: {
                                selectService.removeAll()
                                 if (!(vms.selectServices.contains(where: { ($0.service_id ) == service._id }))) {
                                let selctSer = SelectService(service_id: Int(service._id ?? 0) , price: Int(textFiled) ?? 0, name: service.service)
                                selectService.append(selctSer)
                                     if vms.selectServices.count != 0{
                                         vms.selectServices += selectService
                                     }else{
                                     vms.selectServices = selectService
                                  }
                                arr.add(selctSer)
                                print(arr)
                            }
                                let index = vms.services.firstIndex(of: service)
                                vms.isServicesShow.toggle()
                                if vms.isServicesShow{
                                textFiled = service.service ?? ""
                                serviceId = "\(service._id ?? 0)"
                                vms.services[index ?? 0].isShow = true
                            }else{
                                textFiled = ""
                                if vms.selectServices.count != 0{
                                    vms.selectServices.forEach { item in
                                        if service._id == item.service_id{
                                            let i = vms.selectServices.firstIndex(of: item)
                                            vms.selectServices.remove(at: i!)
                                            vms.services[index ?? 0].isShow = false
//                                            selectService.remove(at: i!)
                                        }
                                    }

                                }
                              
                            }
                                vms.selectServices.forEach { SelectServices in
                                    vms.services.forEach { services in
                                        let indexs = vms.services.firstIndex(of:services)
                                        if services._id == SelectServices.service_id{
                                            vms.services[indexs ?? 0].isShow = true
                                        }
//                                        else{
//                                            vms.services[indexs ?? 0].isShow = false
//                                        }
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
    func checkIfSelected(item:Service)->Bool{
        vms.selectServices.contains { i in
            if item._id == i.service_id{
                return true
            }else{
                return false
            }
        }
//        return vms.selectServices.contains(SelectService(service_id: item._id)
    }
}


struct EditTrainingServiceDropDown: View {

    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var vms: ProfileInfoVM
  
    @Binding var textFiled: String
    @Binding var serviceId: String
    @StateObject var vm:ProfileInfoVM

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
                    ForEach(vm.services, id: \.self) { service in
                        HStack {
                            //                                       {
                            Button(action: {
                                selectService.removeAll()
                                 if (!(vms.selectEditServices.contains(where: { ($0.service_id ) == service._id }))) {
                                let selctSer = SelectService(service_id: Int(service._id ?? 0) , price: Int(textFiled) ?? 0, name: service.service)
                                selectService.append(selctSer)
                                     if vms.selectEditServices.count != 0{
                                         vms.selectEditServices += selectService
                                     }else{
                                     vms.selectEditServices = selectService
                                  }
                                arr.add(selctSer)
                                print(arr)
                            }
                                let index = vm.services.firstIndex(of: service)
                                vms.isServicesShow.toggle()
                                if vms.isServicesShow{
//                                textFiled = service.service ?? ""
                                serviceId = "\(service._id ?? 0)"
                                vm.services[index ?? 0].isShow = true
                            }else{
//                                textFiled = ""
                                if vms.selectEditServices.count != 0{
                                    vms.selectEditServices.forEach { item in
                                        if service._id == item.service_id{
                                            let i = vms.selectEditServices.firstIndex(of: item)
                                            vms.selectEditServices.remove(at: i!)
                                            vm.services[index ?? 0].isShow = false
                                        }
                                    }

                                }
                              
                            }
                                vms.selectEditServices.forEach { SelectServices in
                                    if textFiled != ""{
                                        textFiled = textFiled + ", " + (SelectServices.name ?? "")
                                    }else{
                                        textFiled = ""
                                    }
                                    vm.services.forEach { services in
                                        let indexs = vm.services.firstIndex(of:services)
                                        if services._id == SelectServices.service_id{
                                            vm.services[indexs ?? 0].isShow = true
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
    func checkIfSelected(item:Service)->Bool{
        vms.selectServices.contains { i in
            if item._id == i.service_id{
                return true
            }else{
                return false
            }
        }
//        return vms.selectServices.contains(SelectService(service_id: item._id)
    }
}

struct TrainerEditProfileDropDown: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>

    var body: some View {
        ZStack {
            VStack(spacing: dWidth * 16/375) {
                HStack {
                    Image("outline_check_box_outline_blank_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    Text("Private Sessions")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Image("outline_check_box_outline_blank_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    Text("Virtual Sessions")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Image("outline_check_box_outline_blank_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    Text("Boarding & Training")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(.white)
                    Spacer()
                }
                HStack {
                    Image("outline_check_box_outline_blank_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .clipped()
                        .foregroundColor(Color("#00C600"))
                    Text("Group Clases")
                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
                        .foregroundColor(.white)
                    Spacer()
                }
            }
            .padding(dWidth * 16/375)
            .padding(.top, dWidth * 60/375)
            .background(
                RoundedRectangle(cornerRadius: dWidth * 10/375)
                    .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                    .foregroundColor(Color.black.opacity(0.26))
            )
        }
    }
}

struct TrainerEditProfileDropDown_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            TrainerEditProfileDropDown()
        }
    }
}

//struct DogSportDrop_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.black
//            DogSportDrop(vms: ProfileInfoVM(), textFiled: .constant(""), sportsId: .constant(""))
//        }
//    }
//}

//struct TrainingExpDropDown_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            Color.black
//            TrainingExpDropDown(vms: ProfileInfoVM(), textFiledExp: .constant(""), ExpId: .constant(""))
//        }
//    }
//}

struct ServicesDropDown_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            ServicesDropDown()
        }
    }
}
