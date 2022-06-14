import SwiftUI
import Combine
import MapKit
import CoreLocation
class MapSearch : NSObject, ObservableObject {
    @Published var locationResults : [MKLocalSearchCompletion] = []
    @Published var searchTerm = ""
    
    private var cancellables : Set<AnyCancellable> = []
    
    private var searchCompleter = MKLocalSearchCompleter()
    private var currentPromise : ((Result<[MKLocalSearchCompletion], Error>) -> Void)?
    
    override init() {
        super.init()
        searchCompleter.delegate = self
        searchCompleter.region = MKCoordinateRegion()
        searchCompleter.resultTypes = MKLocalSearchCompleter.ResultType([.address])
        
        $searchTerm
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .removeDuplicates()
            .flatMap({ (currentSearchTerm) in
                self.searchTermToResults(searchTerm: currentSearchTerm)
            })
            .sink(receiveCompletion: { (completion) in
                //handle error
            }, receiveValue: { (results) in
                self.locationResults = results
            })
            .store(in: &cancellables)
    }
    
    func searchTermToResults(searchTerm: String) -> Future<[MKLocalSearchCompletion], Error> {
        Future { promise in
            self.searchCompleter.queryFragment = searchTerm
            self.currentPromise = promise
        }
    }
}

extension MapSearch : MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
            currentPromise?(.success(completer.results))
        }
    
    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        //currentPromise?(.failure(error))
    }
}
struct ReversedGeoLocation {
    let streetNumber: String    // eg. 1
    let streetName: String      // eg. Infinite Loop
    let city: String            // eg. Cupertino
    let state: String           // eg. CA
    let zipCode: String         // eg. 95014
    let country: String         // eg. United States
    let isoCountryCode: String  // eg. US
    let lat: Double         // eg. United States
    let long: Double  // eg. US

    var formattedAddress: String {
        return """
        \(streetNumber) \(streetName),
        \(city), \(state) \(zipCode)
        \(country) \(lat) \(long)
        """
    }

    // Handle optionals as needed
    init(with placemark: CLPlacemark) {
        self.streetName     = placemark.thoroughfare ?? ""
        self.streetNumber   = placemark.subThoroughfare ?? ""
        self.city           = placemark.locality ?? ""
        self.state          = placemark.administrativeArea ?? ""
        self.zipCode        = placemark.postalCode ?? ""
        self.country        = placemark.country ?? ""
        self.isoCountryCode = placemark.isoCountryCode ?? ""
        self.lat        = placemark.location?.coordinate.latitude ?? 0.0
        self.long = placemark.location?.coordinate.longitude ?? 0.0
        
    }
}
struct MapKit_Interface: View {
    @Binding var getlocations: Location
    @Binding var locations: CLLocation
    private let dWidth = UIScreen.main.bounds.width
//    @Binding var selectedLocation : CLLocation?
    var onDismiss: ((_ model: Location) -> Void)?
     func reverseGeo(location: MKLocalSearchCompletion){
       
        let searchRequest = MKLocalSearch.Request(completion: location)
        let search = MKLocalSearch(request: searchRequest)
        var coordinateK : CLLocationCoordinate2D?
        search.start { (response, error) in
            if error == nil, let coordinate = response?.mapItems.first?.placemark.coordinate {
                coordinateK = coordinate
            }
            
            if let c = coordinateK {
                let location = CLLocation(latitude: c.latitude, longitude: c.longitude)
                locations = CLLocation(latitude: c.latitude, longitude: c.longitude)
                CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
                    
                    guard let placemark = placemarks?.first else {
                        let errorString = error?.localizedDescription ?? "Unexpected Error"
                        print("Unable to reverse geocode the given location. Error: \(errorString)")
                        return
                    }
                    
                    let reversedGeoLocation = ReversedGeoLocation(with: placemark)
                    
                    address = "\(reversedGeoLocation.streetNumber) \(reversedGeoLocation.streetName)"
                    city = "\(reversedGeoLocation.city)"
                    state = "\(reversedGeoLocation.state)"
                    zip = "\(reversedGeoLocation.zipCode)"
                    mapSearch.searchTerm = address
                    //               isFocused = false
                    
                    let lat = reversedGeoLocation.lat
                    let long = reversedGeoLocation.long
                    let loc = CLLocation(latitude: lat, longitude: long)
//                    selectedLocation =  loc
//                    getlocations = Location(lat: lat, long: long, address: address)
                    //Location(lat: reversedGeoLocation.lat, long: reversedGeoLocation.long, address:address)
                }
            }
        }
//        print("locations:",locations)
//        return locations
        
    }
        @StateObject private var mapSearch = MapSearch()
        @State private var address = ""
        @State private var addrNum = ""
        @State private var city = ""
        @State private var state = ""
        @State private var zip = ""
        @State private var zipExt = ""
        @Environment(\.presentationMode) private var presentationMode: Binding<PresentationMode>
        var body: some View {
            ZStack{
                backgroundColor
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
            NavBarWithBackButton(title: "Location") {
                presentationMode.wrappedValue.dismiss()
            }

                List {
                        TextField("Search", text: $mapSearch.searchTerm)
                        ForEach(mapSearch.locationResults, id: \.self) { location in
                            Button {
                                  print(reverseGeo(location: location))
                                   print(city)// Function code goes here
//                                let getlocation =  reverseGeo(location: location)
//                                print(getlocation)
                                
                                getlocations = Location(lat:locations.coordinate.latitude, long:locations.coordinate.longitude, address: location.title)
                                onDismiss?(getlocations)
                                self.presentationMode.wrappedValue.dismiss()
                            } label: {
                                VStack(alignment: .leading) {
                                    Text(location.title)
                                        .foregroundColor(Color.white)
                                    Text(location.subtitle)
                                        .font(.system(.caption))
                                        .foregroundColor(Color.white)
                                }
                        } // End Label
                        }.listRowBackground(Color.white.opacity(0.1))// End ForEach
                    
                       
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

                } // End List
                }
//                .padding(.horizontal, dWidth * 16/375)
        } // End var Body
        }
    } // End Struct
struct Location {
    var lat : Double?
    var long : Double?
    var address : String?
}
