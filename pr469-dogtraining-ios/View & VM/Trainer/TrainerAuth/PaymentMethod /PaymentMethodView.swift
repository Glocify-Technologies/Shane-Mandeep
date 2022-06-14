//
//  PaymentMethodView.swift
//  pr469-dogtraining-ios
//
//  Created by Test user on 2022-02-02.
//
import Foundation
import SwiftUI
import Stripe
import Alamofire
import XCTest
import WebKit
import SafariServices


struct PaymentMethodView: View {
    private let dHeight = UIScreen.main.bounds.height
    private let dWidth = UIScreen.main.bounds.width
    @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
    let buttonGradient = Gradient(colors: [Color("#191919"), Color("#232325")])
    @ObservedObject var vms: ProfileInfoVM
    @StateObject var vm = AddPetProfileVM()
    @State public var isSubmitLinkActive: Bool = false
    @State var isSkipLinkActive: Bool = false
    @State private var showWebView = false
    let modelData: [Weather] =
    [ Weather(image: "cloud.rain", temp: 21, city: "Amsterdam"),
      Weather(image: "cloud.sun.rain", temp: 18, city: "London"),
      Weather(image: "sun.max", temp: 25, city: "Paris"),
      Weather(image: "cloud.sun", temp: 23, city: "Tokyo")]
    struct Weather: Identifiable,Hashable {
        var id = UUID()
        var image: String
        var temp: Int
        var city: String
    }
    var body: some View {
      
            ZStack {
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack() {
                    NavBarWithBackButton(title: "My Cards") {
                        presentationMode.wrappedValue.dismiss()
                    }
                    List{
                        ForEach(modelData, id: \.self) { ser in
                            HStack{
                                HStack(spacing: dWidth * 16/375) {
                                    Image("People 05")
                                        .resizable()
                                        .frame(width: dWidth * 52/375, height: dWidth * 30/375, alignment: .center)
                                        .cornerRadius(dWidth * 5/375)
                                        .padding(.leading , 15)
                                    
                                    Text("john_doe@email.com")
                                        .foregroundColor(Color.white)
                                        .font(.customFont(.SFProTextBold, Screen.sizeFromWidth(size: 14)))
                                    Spacer()
                                    
                                }
                                .frame(height: dWidth * 52/375)
                                .padding(.leading, 0)
                                .padding(.trailing, 0)
                                .background(
                                    RoundedRectangle(cornerRadius: dWidth * 10/375)
                                        .stroke(Color("#7E7E7E"), lineWidth: 0.5)
                                        .foregroundColor(Color.black.opacity(0.26))
                                    
                                )
                                //                    .padding(dWidth * 16/375)
//                                Spacer()
                                Image("baseline_close_black_12pt_1x")
                                    .resizable()
                                    .frame(width: dWidth * 24/375, height: dWidth * 24/375)
                                    .foregroundColor(Color("#E84118"))
//                                    .padding(.trailing, dWidth * 16/375)
                                    .padding(.leading, 25)
                                
                                
                            }.padding(.leading, -15)
                                .padding(.trailing, -15)
                        }.listRowBackground(backgroundColor)
                        
                        
                    }.onAppear {
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
                   
//                    NavigationLink (
//                        destination: AddPaymentMethodView().navigationBarHidden(true),
//                        isActive: $isSubmitLinkActive,
//                        label: {
                            ButtonCommon(buttonName: "Add Stripe Account", someAction: {
                                isSubmitLinkActive.toggle()
                            }).sheet(isPresented: $isSubmitLinkActive) {
                                if let url = UserDefaults.standard.value(forKey: "stripeUrl"){
                                    
                                    WebView(url: URL(string: "\(url)")!, isSubmitLinkActive: $isSubmitLinkActive, closeFunction: {
                                        isSubmitLinkActive = false
                                    })
                                }
                               
                            }
                                
//                        })
                        .padding(.bottom, 30)
                       
                        
                       
                   
                    NavigationLink (
                        destination: TrainerMainTabView(vms: vms).navigationBarHidden(true),
                        isActive: $isSkipLinkActive,
                        label: {
                            Text("Skip")
                                .font(.custom("SFProText-Regular", size: dWidth * 14/375))
                                .foregroundColor(Color("#00C600"))
                                .multilineTextAlignment(.center)
                        }).padding(.bottom, 60)
                    Spacer()
                }
                //:VStack
            } //:ZStack
        
    }
}


struct WebView: UIViewRepresentable {
   
    
 
    var url: URL
    @Binding var isSubmitLinkActive: Bool
    var closeFunction : (() -> Void)?
    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }
    func makeCoordinator() -> Coordinator {
           return Coordinator()
       }
    
    func updateUIView(_ webView: WKWebView, context: Context) {
        let request = URLRequest(url: url)
        webView.navigationDelegate = context.coordinator
        context.coordinator.closeFunction = closeFunction
        webView.load(request)
    }
    
    class Coordinator : NSObject, WKNavigationDelegate {
            var closeFunction : (() -> Void)?
            
            func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
                        guard let url = navigationAction.request.url else {
                            decisionHandler(.cancel)
                
                            return
                        }
                        if url.absoluteString.contains("/sucess?status=success") {
                            decisionHandler(.cancel)
                            closeFunction?()
                        }else if url.absoluteString.contains("/fail?status=fail")
                        {
                            decisionHandler(.cancel)
                            closeFunction?()
                
                        }else {
                            decisionHandler(.allow)
                        }
                    }
        }

}

