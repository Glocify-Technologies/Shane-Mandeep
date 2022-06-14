
import SwiftUI

class ImageLoader: ObservableObject {
//    var didChange = PassthroughSubject<Data, Never>()
    @Published var data: Data?
//    var data = Data() {
//        didSet {
//            didChange.send(data)
//        }
//    }
    
    func loadData(from urlString: String?,completion:@escaping(_ data: Data)->())  {
        if let urlString = urlString {
            guard let url = URL(string: urlString) else { return }
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data else { return }
                
                DispatchQueue.global().async {
                    self.data = data
                 completion(data)
                }
            }
            task.resume()
        }
    }
}



 struct OnFirstAppearModifier: ViewModifier {
   let perform:() -> Void
   @State private var firstTime: Bool = true

func body(content: Content) -> some View {
    content
        .onAppear{
            if firstTime{
                firstTime = false
                self.perform()
            }
        }
  }
}


extension View {
   func onFirstAppear( perform: @escaping () -> Void ) -> some View {
     return self.modifier(OnFirstAppearModifier(perform: perform))
   }
}
