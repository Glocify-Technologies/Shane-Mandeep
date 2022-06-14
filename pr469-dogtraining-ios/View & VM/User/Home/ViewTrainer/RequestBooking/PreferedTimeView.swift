//
//  PreferedTimeView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-20.
//

import SwiftUI

struct PreferedTimeView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @State var timelist: [String] = []
    @Binding var times : [Time]?
    @ObservedObject var vm = AddPetProfileVM()
    @Binding var textFiled: String
    @Binding var timeId: String
    var body: some View {
        ZStack {
            if timelist.isEmpty{
            RoundedRectangle(cornerRadius: dWidth * 10/375)
                .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                .foregroundColor(Color.black.opacity(0.26))
                .frame(width: dWidth * 355/375, height: dWidth * 224/375)
            }else{
                RoundedRectangle(cornerRadius: dWidth * 10/375)
                    .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                    .foregroundColor(Color.black.opacity(0.26))
                    .frame(width: dWidth * 355/375, height: dWidth * 304/375)
            }
            if times?.count != 0{
            VStack(spacing: dWidth * 16/375) {
            List {
                ForEach(times!, id: \.self) { time in
                    HStack {
                        let index = times?.firstIndex(of: time)
                        //                                       {
                        Button(action: {
                           
                           
                          
//                            vm.isTimeShow.toggle()
                            if (times?[index ?? 0].id ?? 0) == (Int(timeId) ?? 0) {

                                textFiled = ""

                                timeId = ""

                                vm.isTimeShow.toggle()

                            }else{

                                textFiled = "\(time.start_time ?? "") - \(time.end_time ?? "")"

                                timeId = "\(time.id ?? 0)"

                                vm.isTimeShow.toggle()

                            }


                        }, label: {
                            Image((times?[index ?? 0].id ?? 0) == (Int(timeId) ?? 0) ? "outline_check_box_black_18pt_2x" : "outline_check_box_outline_blank_black_18pt_1x")
                                .resizable()
                                .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                .clipped()
                                .foregroundColor(Color("#00C600"))
                            
                        })
                        Text("\(time.start_time ?? "") - \(time.end_time ?? "")")
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
            } .padding(.top, dWidth * 60/375)
            .padding(.leading, dWidth * 32/375)
//            if timelist.isEmpty{
//                HStack( spacing: dWidth * 16/375) {
//                    Text("No Times Available")
//                        .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                        .foregroundColor(Color.white)
//                        .padding(.leading, dWidth * 16/375)
//                    Spacer()
//                    }
//                .padding(.top, dWidth * 60/375)
//            }else
//            {
//                VStack(spacing: dWidth * 16/375) {
//                    Spacer()
//                    HStack {
//                        Image("outline_check_box_outline_blank_black_18pt_1x")
//                            .resizable()
//                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//                            .clipped()
//                            .foregroundColor(Color("#00C600"))
//                        Text("9:00 AM - 10:00 AM")
//                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                            .foregroundColor(.white)
//                        Spacer()
//                    }
//                    HStack {
//                        Image("outline_check_box_outline_blank_black_18pt_1x")
//                            .resizable()
//                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//                            .clipped()
//                            .foregroundColor(Color("#00C600"))
//                        Text("9:00 AM - 10:00 AM")
//                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                            .foregroundColor(.white)
//                        Spacer()
//                    }
//                    HStack {
//                        Image("outline_check_box_outline_blank_black_18pt_1x")
//                            .resizable()
//                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//                            .clipped()
//                            .foregroundColor(Color("#00C600"))
//                        Text("9:00 AM - 10:00 AM")
//                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                            .foregroundColor(.white)
//                        Spacer()
//                    }
//                    HStack {
//                        Image("outline_check_box_outline_blank_black_18pt_1x")
//                            .resizable()
//                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//                            .clipped()
//                            .foregroundColor(Color("#00C600"))
//                        Text("9:00 AM - 10:00 AM")
//                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                            .foregroundColor(.white)
//                        Spacer()
//                    }
//                    HStack {
//                        Image("outline_check_box_outline_blank_black_18pt_1x")
//                            .resizable()
//                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//                            .clipped()
//                            .foregroundColor(Color("#00C600"))
//                        Text("9:00 AM - 10:00 AM")
//                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                            .foregroundColor(.white)
//                        Spacer()
//                    }
//                    HStack {
//                        Image("outline_check_box_outline_blank_black_18pt_1x")
//                            .resizable()
//                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//                            .clipped()
//                            .foregroundColor(Color("#00C600"))
//                        Text("9:00 AM - 10:00 AM")
//                            .font(.custom("SFProText-Semibold", size: dWidth * 14/375))
//                            .foregroundColor(.white)
//                        Spacer()
//                    }
//                    Spacer()
//                }
//                .padding(.top, dWidth * 60/375)
//                .padding(.leading, dWidth * 32/375)
//            }
            
        }
        }
    }
}

struct PreferedTimeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            PreferedTimeView(times: .constant(nil), textFiled: .constant(""), timeId: .constant(""))
        }
    }
}
