//
//  AvailabilityAddTimePopUp.swift
//  pr469-dogtraining-ios
//
//  Created by Neha Saini on 30/05/22.
//

import Foundation
import SwiftUI

struct AvailabilityViewPopUp: View {
//    var title: String
//    var message: String
//    var buttonText: String
    @Binding var startDate: Date
    @Binding var endDate: Date
  
    @Binding var show: Bool
    @State var isStartTime: Bool = false
    @State var isEndTime: Bool = false
    @Binding var startDateStr:String
    @Binding var endDateStr:String
  
    @Binding var showToast: Bool
    @Binding var message:String
    @Binding var selectTime:[SelectTime]
    @Binding var selectedTimes:String
    @Binding var selectedTime:SelectTime
    @State var isFromEditTime: Bool = false
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    var body: some View {
        ZStack{
            backgroundColor
                .edgesIgnoringSafeArea(.all)
            VStack(alignment: .leading,spacing: dWidth * 16/375) {

                HStack(){
                    Button(
                        action: {
                          
                                show.toggle()
                         
                        },
                        label: {
                            VStack {
                              
                                Text("Cancel")
                                    .font(Font.custom("SFProText-Regular", size: dWidth * 14/375))
                                    .foregroundColor(Color.blue)
                                
                            }
                        }
                    )
                    Spacer()
                    Text("Schedule a new time")
                        .font(Font.custom("SFProText-Bold", size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                    Spacer()
                    Button(
                        action: {
                            if isFromEditTime == true{
                                let index = selectTime.firstIndex(of: selectedTime)
                                selectTime[index ?? 0].start_time = startDateStr
                                selectTime[index ?? 0].end_time = endDateStr
                                selectedTimes = ""
                                selectTime.forEach { selectTime in
                                    if selectedTimes != ""
                                    {
                                        selectedTimes = selectedTimes + ", " + "\(selectTime.start_time ?? "") - \(selectTime.end_time  ?? "")"
                                    }else{
                                        selectedTimes = "\(selectTime.start_time  ?? "") - \(selectTime.end_time  ?? "")"
                                    }
                                }
                                show.toggle()
                            }else{
                                if startDateStr != "" && endDateStr != ""{
                                    selectTime.append(SelectTime(start_time: startDateStr, end_time: endDateStr))
                                    selectTime.forEach { selectTime in
                                        if selectedTimes != ""
                                        {
                                            selectedTimes = selectedTimes + ", " + "\(selectTime.start_time ?? "") - \(selectTime.end_time  ?? "")"
                                        }else{
                                            selectedTimes = "\(selectTime.start_time  ?? "") - \(selectTime.end_time  ?? "")"
                                        }
                                    }
                                    show.toggle()
                                    
                                }else{
                                    showToast.toggle()
                                    if startDateStr != ""{
                                        message = "Please select end time"
                                    }else if startDateStr == "" && startDateStr == ""{
                                        message = "Please select start and end time"
                                    }
                                    else{
                                        message = "Please select start time"
                                    }
                                }
                            }
                           
                            
                        },
                        label: {
                            VStack {
                              
                                Text("Add")
                                    .font(Font.custom("SFProText-Bold", size: dWidth * 14/375))
                                    .foregroundColor(Color.blue)
                                
                            }
                        }
                    )
                }.padding(.top,0 )
               .alert(isPresented: $showToast) {
                Alert(
                    title: Text("Select start and end time"),
                    message: Text(message),
                    dismissButton: .default(Text("Okay"), action: {
                        
                    })
                )
            }
                VStack{
                HStack{
                    Text("Start Time")
                        .font(Font.custom("SFProText-Bold", size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                        .padding([.leading,.trailing],dWidth * 16/375)
                    Spacer()
                    Button(
                        action: {
                            isStartTime.toggle()
                        },
                        label: {
                            VStack {
                              
                                Text(startDateStr != "" ? startDateStr :"Select")
                                    .font(Font.custom("SFProText-Bold", size: dWidth * 14/375))
                                    .foregroundColor(Color.green)
                                
                            }
                        }
                    ).padding([.leading,.trailing],dWidth * 16/375)
                   
                } .frame(height: 60)
                  
                    
                    if isStartTime {
                        Rectangle().fill(Color.white).frame(height: 0.5, alignment: .center).padding([.leading,.trailing], dWidth * 16/375)
                        DatePicker("", selection: $startDate, displayedComponents: [.hourAndMinute])
                            .colorMultiply(Color.white)
                            .colorInvert()
                            .datePickerStyle(.wheel)
                            .background(Color.clear)
                            .onChange(of: startDate) { newValue in
                                startDateStr = getDate(date:newValue)
                                
                            }
                               }
                }
               
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                
                VStack{
                HStack{
                    Text("End Time")
                        .font(Font.custom("SFProText-Bold", size: dWidth * 14/375))
                        .foregroundColor(Color.white)
                        .padding([.leading,.trailing],dWidth * 16/375)
                    Spacer()
                    Button(
                        action: {
                            isEndTime.toggle()
                        },
                        label: {
                            VStack {
                           
                                Text(endDateStr != "" ? endDateStr :"Select")
                                    .font(Font.custom("SFProText-Bold", size: dWidth * 14/375))
                                    .foregroundColor(Color.green)
                                
                            }
                        }
                    ).padding([.leading,.trailing],dWidth * 16/375)
                    
                } .frame(height: 60)
                    if isEndTime {
                        Rectangle().fill(Color.white).frame(height: 0.5, alignment: .center).padding([.leading,.trailing], dWidth * 16/375)
                        DatePicker("", selection: $endDate, displayedComponents: [.hourAndMinute])
                            .colorMultiply(Color.white)
                            .colorInvert()
                            .datePickerStyle(.wheel)
                            .background(Color.clear)
                            .onChange(of: endDate) { newValue in
                                endDateStr = getDate(date:newValue)
                                
                            }
                          }
                }
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                Spacer()
            }.padding([.top,.leading,.trailing],dWidth * 16/375)
                

      }.ignoresSafeArea(.keyboard, edges: .bottom)
            .ignoresSafeArea(.container, edges: [.top, .leading, .trailing])
            .onAppear {
                if isFromEditTime != true{
                    startDateStr = ""
                    endDateStr = ""
                }else{
                    startDateStr = selectedTime.start_time ?? ""
                    endDateStr = selectedTime.end_time ?? ""
                }
            }
            
    }
    
    func getDate(date:Date) -> String{
        let dff = DateFormatter()
        dff.dateFormat = "HH:mm a"
        let nows = dff.string(from: date)
        print("Date: \(nows)")
        return nows
    }
}


