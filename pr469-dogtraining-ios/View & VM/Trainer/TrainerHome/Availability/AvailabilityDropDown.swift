//
//  AvailabilityDropDown.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-12.
//

import SwiftUI

struct AvailabilityDropDown: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    @Binding var selectTime:[SelectTime]
    @Binding var startDate:Date
    @Binding var endDate:Date
    @Binding var selectedTimes:String
    @Binding var startDateStr:String
    @Binding var endDateStr:String
    @State var isEditTimesViewSelected: Bool = false
    var body: some View {
        
        VStack(spacing: dWidth * 16/375) {
            ScrollView(showsIndicators: false){
            LazyVStack{
                ForEach(0..<selectTime.count, id: \.self) { index in
                    RectangleView(index: index, selectTime: $selectTime, startDate: $startDate, endDate: $endDate, selectedTimes: $selectedTimes, startDateStr: $startDateStr, endDateStr: $endDateStr)
                }
            }
                
            }

        }
        .padding(.top, dWidth * 60/375)
        .padding(dWidth * 16/375)
        .background(
            ZStack {
                RoundedRectangle (cornerRadius: dWidth * 10/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                RoundedRectangle(cornerRadius: dWidth * 10/375)
                    .stroke(Color("#7E7E7E"), lineWidth: dWidth * 0.5/375)
                    .foregroundColor(Color.black.opacity(0.26))
            })
    }
}

struct AvailabilityDropDown_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            AvailabilityDropDown(selectTime: .constant([SelectTime(start_time: "", end_time: "")]),startDate: .constant(Date()),endDate: .constant(Date()), selectedTimes: .constant(""),startDateStr:.constant(""),endDateStr: .constant(""))
        }
    }
}
struct RectangleView: View {
    
    let index: Int
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @Binding var selectTime:[SelectTime]
    @Binding var startDate:Date
    @Binding var endDate:Date
    @Binding var selectedTimes:String
    @Binding var startDateStr:String
    @Binding var endDateStr:String
    @State var isEditTimesViewSelected: Bool = false
    
    var body: some View {


        HStack(spacing: dWidth * 16/375) {
           
            Text("\(selectTime[index].start_time ?? "") - \(selectTime[index].end_time ?? "")")
                .font(.customFont(.SFProTextRegular, Screen.sizeFromWidth(size: 13)))
                .foregroundColor(Color("#C3C3C3"))
                .padding(.vertical, dWidth * 10/375)
                .padding(.horizontal, dWidth * 64/375)
                .background(
                    ZStack {
                        RoundedRectangle (cornerRadius: dWidth * 18/375).fill(Color("#434343").opacity(0.45))
                    })
            HStack {
                Button(action: {
                    withAnimation(.linear(duration: 1)) {
                        isEditTimesViewSelected.toggle()
                    }
                   
                }, label: {
                    Image("outline_edit_black_18pt_1x")
                        .resizable()
                        .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                        .foregroundColor(Color.white)
                        .padding(dWidth * 6/375)
                   
                })  .sheet(isPresented: $isEditTimesViewSelected) {
                    AvailabilityViewPopUp(startDate: $startDate, endDate: $endDate, show: $isEditTimesViewSelected,startDateStr:$startDateStr,endDateStr:$endDateStr, showToast: .constant(false), message: .constant("please select start and end time"), selectTime: $selectTime, selectedTimes: $selectedTimes,selectedTime: $selectTime[index], isFromEditTime:true)
                       
                }
               
                    
            }
            .background(
                ZStack {
                    RoundedRectangle (cornerRadius: dWidth * 18/375).fill(Color("#434343").opacity(0.45))
                })
        }

    }
    
}
