
//Afzal Hossain
import SwiftUI
import GoogleMaps

struct GoogleMapsView: UIViewRepresentable {
    @Binding var isLoad: Bool
    @State var streetLocation: String=""
    @Binding var isFocused: Bool
    @State var requestSearch: Bool=false
    @State var searchAddress: String=""
    @State var lastLatitude: Double //= 51.50997967167544
    @State var lastLongitude: Double //= -0.13369839638471603
    @ObservedObject var locationManager = LocationManager()
    private let zoom: Float = 7.0
    
    @State var selectedMarker: GMSMarker? = GMSMarker()
    var mapView : GMSMapView? = nil
    var timer : Timer? = nil

    //Selecting random marker
    func selectRandomMarker(){
        self.mapView?.selectedMarker = self.mapView?.selectedMarker
        self.mapView?.animate(toLocation: (self.mapView?.selectedMarker!.position)!)
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(
            parent: self,
            marker: $selectedMarker,
            latitude: $lastLatitude,
            longitude: $lastLongitude)
    }
    
    func makeUIView(context: Self.Context) -> GMSMapView {
        let camera = GMSCameraPosition.camera(withLatitude: lastLatitude, longitude: lastLongitude, zoom: zoom)
        
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.delegate = context.coordinator
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
        selectedMarker!.position = CLLocationCoordinate2D(latitude: lastLatitude, longitude: lastLongitude)
        selectedMarker!.title = "Address"
        selectedMarker!.snippet = "User Address"
//        let markerImage = UIImage(systemName: "mappin")!.withRenderingMode(.alwaysTemplate)
//
////        creating a marker view
//        let markerView = UIImageView(image: markerImage)
//        selectedMarker!.iconView = markerView
        selectedMarker!.map = mapView
        
        return mapView
    }
    
    
    func loadView(RetaliCode: String, RetailerName: String) {
        print(RetaliCode)
    }
    
    func updateUIView(_ mapView: GMSMapView, context: Context) {
        
        selectedMarker!.position = CLLocationCoordinate2D(latitude: lastLatitude, longitude: lastLongitude)
        selectedMarker!.snippet = streetLocation
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: lastLatitude, longitude: lastLongitude))
        getAddress(latitude: lastLatitude, longitude: lastLongitude)
        
        if isFocused {
            mapView.animate(toLocation: CLLocationCoordinate2D(latitude: lastLatitude, longitude: lastLongitude))
        }
        
        if requestSearch {
            DispatchQueue.main.async {
                getLatLongFromAddress(address: searchAddress) { (result) in
                    if result {
                        selectedMarker!.position = CLLocationCoordinate2D(latitude: lastLatitude, longitude: lastLongitude)
                        selectedMarker!.snippet = streetLocation
                        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: lastLatitude, longitude: lastLongitude))
                    } else {
                        print("no location found2")
                    }
                }
            }
        }
    }
    
    func getAddress(latitude: Double, longitude: Double){
        
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(latitude), Double(longitude))
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                streetLocation = address.lines![0]
            }
        }
    }
    
    func getLatLongFromAddress(address: String, completion: @escaping((Bool) -> ())) {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address) {
            placemarks, error in
            
            if placemarks != nil {
                let placemark = placemarks?.first
                lastLatitude = (placemark?.location?.coordinate.latitude)!
                lastLongitude = (placemark?.location?.coordinate.longitude)!
                completion(true)
                // Use your location
            } else {
                print("no location found3")
                completion(false)
            }
        }
    }
    
    func searchAddress(latitude: Double, longitude: Double){
        
        let geocoder = GMSGeocoder()
        let coordinate = CLLocationCoordinate2DMake(Double(latitude), Double(longitude))
        
        geocoder.reverseGeocodeCoordinate(coordinate) { response , error in
            if let address = response?.firstResult() {
                streetLocation = address.lines![0]
            }
        }
    }
}

class MapCoordinator: NSObject, CLLocationManagerDelegate, GMSMapViewDelegate {
    // 1.
    let parent: GoogleMapsView       // access to owner view members,
    @Binding var selectedMarker: GMSMarker?
    @Binding var latitude: Double
    @Binding var longitude: Double
    
    init(parent: GoogleMapsView, marker: Binding<GMSMarker?>, latitude: Binding<Double>, longitude: Binding<Double>) {
        self.parent = parent
        _selectedMarker = marker
        _latitude = latitude
        _longitude = longitude
        
        print("init called")
    }
    
    deinit {
        print("deinit: MapCoordinator")
    }
    
//    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
//        print("A marker has been touched")
//        return true
//    }
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        longitude = coordinate.longitude
        latitude = coordinate.latitude
    }
    

    let customMarkerWidth: Int = 50
    let customMarkerHeight: Int = 70

    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        print("didTap")
        parent.loadView(RetaliCode: marker.title ?? "", RetailerName: marker.snippet ?? "")
        return false
    }

    func mapView(_ mapView: GMSMapView, markerInfoContents marker: GMSMarker) -> UIView? {
        guard marker.iconView != nil else { return nil }
        
        print("markerInfoContents")
        return nil
    }

    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker) {
//        guard let customMarkerView = marker.iconView else { return }
//        let tag = customMarkerView.tag
//        restaurantTapped(tag: tag)
        
        print("didTapInfoWindowOf")
    }

    func mapView(_ mapView: GMSMapView, didCloseInfoWindowOf marker: GMSMarker) {
        
        print("didCloseInfoWindowOf")
    }


    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        
        print("didChange")
    }
    
}
