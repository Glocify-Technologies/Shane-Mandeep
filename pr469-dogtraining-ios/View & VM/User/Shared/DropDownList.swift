//
//  DropDownList.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2021-12-23.
//

import SwiftUI

struct PetDropDownList: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    
    var title: String
    var name: String
    var option: String
    var image: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 32/375)
            
            HStack {
                Text(name)
                    .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                    .foregroundColor(Color.white)
                    .lineLimit(1)
                //                Spacer()
                //                Text(option)
                //                    .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                //                    .foregroundColor(Color("#00C600"))
                Image(image)
                    .resizable()
                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                    .foregroundColor(Color("#00C600"))
                
            }
            .padding(.horizontal, dWidth * 32/375)
            .frame(width: dWidth * 185/375, height: dWidth * 48/375)
            .background(
                ZStack {
                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                }.padding(.horizontal, dWidth * 16/375)
            )
        } //:VStack
    }
}

struct DropDownList: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    
    var title: String
    var name: String
    var option: String
    var image: String
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: dWidth * 14/375) {
            Text(title)
                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 16/375)
            
            HStack {
                Text(name)
                    .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                    .foregroundColor(Color.white)
                Spacer()
                Text(option)
                    .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                    .foregroundColor(Color("#00C600"))
                Image(image)
                    .resizable()
                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                    .foregroundColor(Color("#00C600"))
                
            }
            .padding(.vertical, dWidth * 12/375)
            .frame(width: dWidth * 280/375, height: dWidth * 48/375)
            .padding(.horizontal, dWidth * 32/375)
            .background(
                ZStack {
                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                })
        } //:VStack
    }
}


struct DogSportsTitleProfileDropDownList: View {

    private let dHeight = UIScreen.main.bounds.height

    private let dWidth = UIScreen.main.bounds.width

    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])

    @Binding var dogSportsTitle: [String]

    var title: String

    var name: String

    var nameTwo: String

    var image: String

    @ObservedObject var vms:ProfileInfoVM
    @Binding var isDogSportTitle :Bool
    let rows: [GridItem] = [

        GridItem(.fixed(32), spacing: 20, alignment: .top)

    ]

    

    var body: some View
    {
        VStack(alignment: .leading, spacing: dWidth * 14/375) {
            Text(title)
                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 16/375)
            
            HStack {
                
                ScrollView(.horizontal, showsIndicators: false) {

                    LazyHGrid(rows: rows) {

                        if let allServices = dogSportsTitle {

                            ForEach((allServices), id: \.self) { sportTitles in

                                HStack(spacing: 20) {

                                    Text(sportTitles ?? "")

                                        .font(.custom("SFProText-Regular", size: dWidth * 14/375))

                                        .lineLimit(1)

                                        .foregroundColor(Color.white)

                                    Button {

                                        if let index = allServices.firstIndex(of: sportTitles) {

                                            dogSportsTitle.remove(at: index)
                                            vms.sportTitle.forEach { item in
                                                if item.title == sportTitles{
                                                    let i = vms.sportTitle.firstIndex(of: item)
                                                    vms.sportTitle[i ?? 0].isShow = false
                                                }
                                            }

                                        }

                                    } label: {

                                        Image("baseline_close_black_12pt_1x")

                                            .resizable()

                                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)

                                            .foregroundColor(Color("#E84118"))

                                    }



                                }

                                .padding(.vertical, dWidth * 2/375)

                                .padding(.leading, dWidth * 12/375)

                                .background(

                                    ZStack {

                                        RoundedRectangle (cornerRadius: dWidth * 14/375).fill(Color("#434343").opacity(0.45))

                                    }

                                )

                            }

                        }
                    }

                }

                .frame(maxHeight:40)

                Spacer()

                Image(image)

                    .resizable()

                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)

                    .foregroundColor(Color("#00C600"))

                    .onTapGesture(count: 1) {
                        isDogSportTitle.toggle()
                    }

            }
            .padding(.vertical, dWidth * 12/375)
            .frame(width: dWidth * 280/375, height: dWidth * 48/375)
            .padding(.horizontal, dWidth * 32/375)
            .background(
                ZStack {
                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                })
        } //:VStack
    }
//    {
//
//        VStack(alignment: .leading, spacing: dWidth * 14/375) {
//
//            Text(title)
//
//                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
//
//                .foregroundColor(Color.white)
//
//                .padding(.leading, dWidth * 16/375)
//
//            
//
//          
//
//            HStack(spacing: 16) {
//
//                ScrollView(.horizontal, showsIndicators: false) {
//
//                    LazyHGrid(rows: rows) {
//
//                        if let allServices = dogSportsTitle {
//
//                            ForEach((allServices), id: \.self) { sportTitles in
//
//                                HStack(spacing: 20) {
//
//                                    Text(sportTitles ?? "")
//
//                                        .font(.custom("SFProText-Regular", size: dWidth * 14/375))
//
//                                        .lineLimit(1)
//
//                                        .foregroundColor(Color.white)
//
//                                    Button {
//
//                                        if let index = allServices.firstIndex(of: sportTitles) {
//
//                                            dogSportsTitle.remove(at: index)
//                                            vms.sportTitle.forEach { item in
//                                                if item.title == sportTitles{
//                                                    let i = vms.sportTitle.firstIndex(of: item)
//                                                    vms.sportTitle[i ?? 0].isShow = false
//                                                }
//                                            }
//
//                                        }
//
//                                    } label: {
//
//                                        Image("baseline_close_black_12pt_1x")
//
//                                            .resizable()
//
//                                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//
//                                            .foregroundColor(Color("#E84118"))
//
//                                    }
//
//
//
//                                }
//
//                                .padding(.vertical, dWidth * 2/375)
//
//                                .padding(.leading, dWidth * 12/375)
//
//                                .background(
//
//                                    ZStack {
//
//                                        RoundedRectangle (cornerRadius: dWidth * 14/375).fill(Color("#434343").opacity(0.45))
//
//                                    }
//
//                                )
//
//                            }
//
//                        }
//                    }
//
//                }
//
//                .frame(maxHeight:40)
//
//                Spacer()
//
//                Image(image)
//
//                    .resizable()
//
//                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)
//
//                    .foregroundColor(Color("#00C600"))
//
//                    .onTapGesture(count: 1) {
//                        isDogSportTitle.toggle()
//                    }
//
//            }
//
//            .padding(.vertical, dWidth * 10/375)
//
//            .padding(.horizontal, dWidth * 16/375)
//
//            .background(
//
//                ZStack {
//
//                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
//
//                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
//
//                }
//
//            )
//
//            
//
//        } //:VStack
//
//    }

}


struct AvailabilityDropDownList: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    
    var name: String
    var image: String
    
    var body: some View {
        HStack {
            Text(name)
                .font(.custom("SFProText-Bold", size: dWidth * 13/375))
                .foregroundColor(Color("#C5C4C4"))
            Spacer()
            Image(image)
                .resizable()
                .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                .foregroundColor(Color("#00C600"))
        }
        .padding(.vertical, dWidth * 16/375)
        .padding(.horizontal, dWidth * 16/375)
        .background(
                RoundedRectangle (cornerRadius: dWidth * 0/375).fill(Color("#666666").opacity(0.18))
                    .clipShape(Rounded(radius: Int(dWidth) * 10/375, edges: [.topLeft,.topRight]))
        )
    }
}

struct AvailabilityTimesDropDownList: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    
    var name: String
    var image: String
    @Binding var startDate: Date
    @Binding var endDate: Date
  
    @Binding var show: Bool
    @State var isTimesViewSelected: Bool = false
    @State var isStartTime: Bool = false
    @State var isEndTime: Bool = false
    @Binding var startDateStr:String
    @Binding var endDateStr:String
  
    @Binding var showToast: Bool
    @Binding var message:String
    @Binding var selectTime:[SelectTime]
    @Binding var selectedTimes:String
    var body: some View {
        HStack {
            Text(name)
                .font(.custom("SFProText-Bold", size: dWidth * 13/375))
                .foregroundColor(Color("#C5C4C4"))
            Spacer()
            Button(action: {
                withAnimation(.linear(duration: 1)) {
                    isTimesViewSelected.toggle()
                }
               
            }, label: {
                Image(image)
                    .resizable()
                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                    .foregroundColor(Color("#00C600"))
               
            })  .sheet(isPresented: $isTimesViewSelected) {
                AvailabilityViewPopUp(startDate: $startDate, endDate: $endDate, show: $isTimesViewSelected,startDateStr:$startDateStr,endDateStr:$endDateStr, showToast: .constant(false), message: .constant("please select start and end time"), selectTime: $selectTime, selectedTimes: $selectedTimes, selectedTime:.constant(SelectTime(start_time: "", end_time: "")))
                    .onChange(of: startDateStr) { newValue in
                    
                    selectedTimes = ""
                   
                }
            }

         
               
        }
        .padding(.vertical, dWidth * 16/375)
        .padding(.horizontal, dWidth * 16/375)
        .background(
                RoundedRectangle (cornerRadius: dWidth * 0/375).fill(Color("#666666").opacity(0.18))
                    .clipShape(Rounded(radius: Int(dWidth) * 10/375, edges: [.topLeft,.topRight]))
        )
    }
}

struct PetEditDropDownList: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    
    var title: String
    var name: String
    var option: String
    var image: String
    
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 32/375)
            
            HStack {
                Text(name)
                    .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                    .foregroundColor(Color.white)
                    .lineLimit(1)
                Spacer()
                Image(image)
                    .resizable()
                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                    .foregroundColor(Color("#00C600"))
                
            }
            .padding(.horizontal, dWidth * 32/375)
            .frame(width: dWidth * 185/375, height: dWidth * 48/375)
            .background(
                ZStack {
                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                }.padding(.horizontal, dWidth * 16/375))
        } //:VStack
    }
}

struct TrainerEditDropDownList: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @Binding var isServiceSelected: Bool
    var title: String
    var name: String
    var nameTwo: String
    var image: String
    @ObservedObject var vms:ProfileInfoVM
    let rows: [GridItem] = [

        GridItem(.fixed(32), spacing: 20, alignment: .top)

    ]
//    @StateObject var vms = ProfileInfoVM()
    var body: some View {
        VStack(alignment: .leading, spacing: dWidth * 14/375) {
            Text(title)
                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                .foregroundColor(Color.white)
                .padding(.leading, dWidth * 16/375)
            
          
            HStack(spacing: 16) {
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHGrid(rows: rows) {
                        
                        if let allServices = vms.selectServices {
                            
                            ForEach((allServices), id: \.self) { services in
                                
                                HStack(spacing: 20) {
                                    
                                    Text(services.name ?? "")
                                    
                                        .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                                    
                                        .lineLimit(1)
                                    
                                        .foregroundColor(Color.white)
                                    
                                    Button {
                                        
                                        if let index = allServices.firstIndex(of: services) {
                                            
                                            vms.selectServices.remove(at: index)
                                            vms.services.forEach { item in
                                                if item._id == services.service_id{
                                                    let i = vms.services.firstIndex(of: item)
                                                    vms.services[i ?? 0].isShow = false
                                                }
                                            }
                                            
                                        }
                                        
                                    } label: {
                                        
                                        Image("baseline_close_black_12pt_1x")
                                        
                                            .resizable()
                                        
                                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                        
                                            .foregroundColor(Color("#E84118"))
                                        
                                    }
                                    
                                    
                                    
                                }
                                
                                .padding(.vertical, dWidth * 2/375)
                                
                                .padding(.leading, dWidth * 12/375)
                                
                                .background(
                                    
                                    ZStack {
                                        
                                        RoundedRectangle (cornerRadius: dWidth * 14/375).fill(Color("#434343").opacity(0.45))
                                        
                                    }
                                    
                                )
                                
                            }
                            
                        }
                    }
                    
                }
                
                .frame(maxHeight:40)
                
            
                Spacer()
                
                Image(image)
                
                
                
                    .resizable()
                
                
                
                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                
                
                
                    .foregroundColor(Color("#00C600"))
                
                    .onTapGesture(count: 1) {
                        isServiceSelected.toggle()
                    }
            }
            .padding(.vertical, dWidth * 10/375)
            .padding(.horizontal, dWidth * 16/375)
            .background(
                ZStack {
                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))
                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)
                }
            )
            
        } //:VStack
    }
}

struct DogSportsTitleDropDownList: View {

    private let dHeight = UIScreen.main.bounds.height

    private let dWidth = UIScreen.main.bounds.width

    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])

    

    var title: String

    var name: String

    var nameTwo: String

    var image: String

    @ObservedObject var vms:ProfileInfoVM
    @Binding var isDogSportTitle :Bool
    let rows: [GridItem] = [

        GridItem(.fixed(32), spacing: 20, alignment: .top)

    ]

    

    var body: some View {

        VStack(alignment: .leading, spacing: dWidth * 14/375) {

            Text(title)

                .font(.custom("SFProText-Regular", size: dWidth * 14/375))

                .foregroundColor(Color.white)

                .padding(.leading, dWidth * 16/375)

            

          

            HStack(spacing: 16) {

                ScrollView(.horizontal, showsIndicators: false) {

                    LazyHGrid(rows: rows) {

                        if let allServices = vms.getTrainer?.sportTitles {

                            ForEach((allServices), id: \.self) { sportTitles in

                                HStack(spacing: 20) {

                                    Text(sportTitles.title ?? "")

                                        .font(.custom("SFProText-Regular", size: dWidth * 14/375))

                                        .lineLimit(1)

                                        .foregroundColor(Color.white)

                                    Button {

                                        if let index = allServices.firstIndex(of: sportTitles) {

                                            vms.getTrainer?.sportTitles?.remove(at: index)
                                            vms.sportTitle.forEach { item in
                                                if item._id == sportTitles._id{
                                                    let i = vms.sportTitle.firstIndex(of: item)
                                                    vms.sportTitle[i ?? 0].isShow = false
                                                }
                                            }

                                        }

                                    } label: {

                                        Image("baseline_close_black_12pt_1x")

                                            .resizable()

                                            .frame(width: dWidth * 24/375, height: dWidth * 24/375)

                                            .foregroundColor(Color("#E84118"))

                                    }



                                }

                                .padding(.vertical, dWidth * 2/375)

                                .padding(.leading, dWidth * 12/375)

                                .background(

                                    ZStack {

                                        RoundedRectangle (cornerRadius: dWidth * 14/375).fill(Color("#434343").opacity(0.45))

                                    }

                                )

                            }

                        }
                    }

                }

                .frame(maxHeight:40)

                Spacer()

                Image(image)

                    .resizable()

                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)

                    .foregroundColor(Color("#00C600"))

                    .onTapGesture(count: 1) {
                        isDogSportTitle.toggle()
                    }

            }

            .padding(.vertical, dWidth * 10/375)

            .padding(.horizontal, dWidth * 16/375)

            .background(

                ZStack {

                    RoundedRectangle (cornerRadius: dWidth * 9/375).fill(LinearGradient(gradient: buttonGradient, startPoint: .leading, endPoint: .trailing))

                    RoundedRectangle (cornerRadius: dWidth * 9/375).stroke(Color("#7E7E7E"),lineWidth: dWidth * 1/375)

                }

            )

            

        } //:VStack

    }

}

struct TrainerEditDropDownList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
            TrainerEditDropDownList(isServiceSelected: .constant(false), title: "Hello", name: "Agility", nameTwo: "Obedience", image: "outline_expand_more_black_18pt_1x", vms: ProfileInfoVM())
        }
    }
}

struct PetEditDropDownList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
            PetEditDropDownList(title: "Hello", name: "3", option: "Change", image: "outline_expand_more_black_18pt_1x")
        }
    }
}

struct AvailabilityDropDownList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
            AvailabilityDropDownList(name: "Schedule a new time", image: "outline_add_black_18pt_1x")
        }
    }
}

struct PetDropDownList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
            PetDropDownList(title: "Hello", name: "Select location", option: "Change", image: "outline_expand_more_black_18pt_1x")
        }
    }
}

struct DropDownList_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.yellow
            DropDownList(title: "Hello", name: "Select location", option: "Change", image: "outline_expand_more_black_18pt_1x")
        }
    }
}
