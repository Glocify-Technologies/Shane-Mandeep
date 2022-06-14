//
//  PetProfileSelectView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-24.
//

import SwiftUI

struct PetProfileSelectView: View {
    
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
//    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @ObservedObject var vm = AddPetProfileVM()
  
    @Binding var textFiled: String
    @Binding var petProfileId: String
    @Binding var petProfile: [PetProfile]
    var arr = NSMutableArray()
    @State var selectPetProfile:[SelectPetProfile] = []
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: dWidth * 10/375)
                .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                .foregroundColor(Color.black.opacity(0.26))
                .frame(width: dWidth * 355/375, height: dWidth * 224/375)
            
            VStack(spacing: dWidth * 16/375) {
                List {
                    ForEach(petProfile) { profile in
                        HStack {
                            //                                       {
                            Button(action: {
                                let index = petProfile.firstIndex(of:profile)
                                selectPetProfile.removeAll()
                                 if (!(vm.selectPetProfile.contains(where: { ($0._id ) == profile._id }))) {
                                let selctSer = SelectPetProfile(_id: profile._id, profileName: profile.profileName, petName: profile.petName, userId: profile.userId, breed: profile.breed, age: profile.age, gender: profile.gender, _description: profile._description)
                                     selectPetProfile.append(selctSer)
                                vm.selectPetProfile = selectPetProfile
                                arr.add(selctSer)
                                print(arr)
                                 }
                             
                              
                                vm.ispetProfileShow.toggle()
                                if vm.ispetProfileShow{
                                textFiled = profile.petName ?? ""
                                    petProfileId = "\(profile._id ?? 0)"
                                   
                            }else{
                                textFiled = ""
                                if vm.selectPetProfile.count != 0{
                                    vm.selectPetProfile.forEach { item in
                                        if profile._id == item._id{
                                            let i = vm.selectPetProfile.firstIndex(of: item)
                                            vm.selectPetProfile.remove(at: i!)
                                           
//                                            selectService.remove(at: i!)
                                        }
                                    }

                                }
                              
                            }
                                vm.selectPetProfile.forEach { SelectPetProfile in
                                    petProfile.forEach { PetProfile in
                                        let indexs = petProfile.firstIndex(of:PetProfile)
                                        if PetProfile._id == SelectPetProfile._id{
                                            petProfile[indexs ?? 0].isShow = true
                                        }else{
                                            petProfile[indexs ?? 0].isShow = false
                                        }
                                    }
                                }
                              
                            }, label: {
                                Image(profile.isShow ? "outline_check_box_black_18pt_2x" : "outline_check_box_outline_blank_black_18pt_1x")
                                    .resizable()
                                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                    .clipped()
                                    .foregroundColor(Color("#00C600"))
                                
                            })
                            Text(profile.petName ?? "")
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
    func checkIfSelected(item:PetProfile)->Bool{
        vm.selectPetProfile.contains { i in
            if item._id == i._id{
                return true
            }else{
                return false
            }
        }
//        return vms.selectServices.contains(SelectService(service_id: item._id)
    }
}

struct PetProfileSelectView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            PetProfileSelectView(textFiled: .constant(""), petProfileId: .constant(""), petProfile: .constant([PetProfile(_id: 0, profileName: "", petName: "", userId: "", breed: "", age: "", gender: "", _description: "", createdAt: "", updatedAt: "", treatment: [Treatment(_id: 0, petProfileId: "", treatment: "", createdAt: "", updatedAt: "")])]))
        }
    }
}

