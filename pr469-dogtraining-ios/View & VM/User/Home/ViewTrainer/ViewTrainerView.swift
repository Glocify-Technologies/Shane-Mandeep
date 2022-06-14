//
//  ViewTrainerView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-01-11.
//

import SwiftUI
import SDWebImageSwiftUI

struct ViewTrainerView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#232325"), Color("#191919")])
    @State var isCompleteLinkActive: Bool = false
    @State var index = 0
    @State var trainerData: Trainer?
    var images = ["dog-viszla-close", "dog-viszla-close", "dog-viszla-close", "dog-viszla-close"]
    
    var body: some View {
        ZStack {
            backgroundColor
                .edgesIgnoringSafeArea(.all)

            VStack {
                NavBarWithBackButtonTransparent(title: "ViewTrainer") {
                    presentationMode.wrappedValue.dismiss()
                }
                
                ScrollView {
                    //:Top Trainer Details
                    ViewTrainerUserCard(image: (trainerData?.users?.avatarUrl ?? ""), name: trainerData?.users?.name ?? "", address: trainerData?.location ?? "", phoneNum: trainerData?.users?.phone ?? "")
                        .padding(.bottom, dWidth * 20/375)
                   
                    PagingView(index: $index.animation(), maxIndex: ((trainerData?.photos?.count != 0 ? trainerData?.photos?.count ?? 0 : 1)-1)) {
                        if let photots = trainerData?.photos{
                            ForEach(photots, id: \.self) { imageName in
                                WebImage(url: URL(string: imageName.fileUrl ?? ""))
                                    .pausable(false)
                                    .purgeable(true)
                                    .resizable()
                                    .placeholder(Image(uiImage: UIImage(systemName: "photo.fill")!))
                                    .indicator(.activity) // Activity Indicator
                                    .scaledToFill()
                                    .cornerRadius(dWidth * 10/375)
                                    .clipped()
                                    .foregroundColor(Color("#00C600"))
                            }
                                    
                        }
                    }
                    .frame(width: dWidth * 343/375, height: dHeight * 343/875, alignment: .center)
                    .cornerRadius(dWidth * 10/375)
                    
                    //:Social Media
                    HStack(spacing: dWidth * 40/375) {
                        Image("outline_whatsapp_black_18pt_1x")
                            .resizable()
                            .frame(width: dWidth * 18/375, height: dHeight * 18/875, alignment: .center)
                            .foregroundColor(Color("#00C600"))
                        Image("outline_whatsapp_black_18pt_1x")
                            .resizable()
                            .frame(width: dWidth * 18/375, height: dHeight * 18/875, alignment: .center)
                            .foregroundColor(Color("#00C600"))
                        Image("outline_whatsapp_black_18pt_1x")
                            .resizable()
                            .frame(width: dWidth * 18/375, height: dHeight * 18/875, alignment: .center)
                            .foregroundColor(Color("#00C600"))
                    } //:HStack
                    .padding(.top, dWidth * 10/375)
                    
                    VStack(alignment: .leading, spacing: dWidth * 10/375) {
                        Text("About Me")
                            .font(Font.custom("SFProText-Regular", size: dWidth * 14/375))
                            .foregroundColor(Color("#848484"))
                        
                        Text("Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.")
                            .font(Font.custom("SFProText-Regular", size: dWidth * 14/375))
                            .foregroundColor(Color.white)
                        Text("Business Detail")
                            .font(Font.custom("SFProText-Regular", size: dWidth * 14/375))
                            .foregroundColor(Color.white)
                            .padding(.top, dWidth * 10/375)
                    }.padding(dWidth * 15/375)
                    
                    //:Business detail box
                    BusinessDetails(trainerData: trainerData)
                    
                    NavigationLink (
                        destination: RequestBookingView(trainerData:trainerData).navigationBarHidden(true),
                        isActive: $isCompleteLinkActive,
                        label: {
                            ButtonCommon(buttonName: "Request Booking", someAction: {
                                isCompleteLinkActive.toggle()
                            })})
                        .padding(.top, dWidth * 30/375)
                        .padding(.bottom, dWidth * 32/375)
                    Spacer()
                }
            } //:VStack
            //            .padding(.horizontal, dWidth * 16/375)
        } //:ZStack
    }
}

struct ViewTrainerView_Previews: PreviewProvider {
    static var previews: some View {
        ViewTrainerView()
    }
}
struct ImageViewPage: View {
    var urlString: String
    @ObservedObject var imageLoader = ImageLoader()
    @State var images = UIImage(systemName: "person.fill")!
    private let dWidth = UIScreen.main.bounds.width
    var body: some View {
        ZStack() {
            
            ZStack {

                Image(uiImage: images)
                    .resizable()
                    .scaledToFill()
//                    .frame(width: dWidth * 102/375, height: dWidth * 102/375)
                    .clipped()
                    .foregroundColor(Color("#00C600"))
                    .onReceive(imageLoader.$data) { data in
                        guard let data = data else { return }
                        self.images = UIImage(data: data) ?? UIImage()
                    } .cornerRadius(dWidth * 10/375)
            }
        }.onAppear {
           
            self.imageLoader.loadData(from: urlString) { data in
                self.images = UIImage(data: data) ?? UIImage(systemName: "person.fill")!
            }
            
        }
    }
}
