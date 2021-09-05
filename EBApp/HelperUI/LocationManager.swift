
//Afzal Hossain
import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    @Published var locationStatus: CLAuthorizationStatus? {
        willSet {
            objectWillChange.send()
        }
    }

    @Published var lastLocation: CLLocation? {
        willSet {
            objectWillChange.send()
        }
    }

    var statusString: String {
        guard let status = locationStatus else {
            return "unknown"
        }

        switch status {
        case .notDetermined: return "notDetermined"
        case .authorizedWhenInUse: return "authorizedWhenInUse"
        case .authorizedAlways: return "authorizedAlways"
        case .restricted: return "restricted"
        case .denied: return "denied"
        default: return "unknown"
        }

    }

    let objectWillChange = PassthroughSubject<Void, Never>()

    private let locationManager = CLLocationManager()
}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.locationStatus = status
        print(#function, statusString)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        self.lastLocation = location
//        manager.stopUpdatingLocation()
        print(#function, location)
    }

    func getCurrentLocation() {
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestWhenInUseAuthorization()
        }

    }

}



//
//import Foundation
//import CoreLocation
//import Combine
//
//class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
//
//    private let locationManager = CLLocationManager()
//    @Published var locationStatus: CLAuthorizationStatus?
//    @Published var lastLocation: CLLocation?
//
//    override init() {
//        super.init()
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.startUpdatingLocation()
//    }
//
//
//
//    var statusString: String {
//        guard let status = locationStatus else {
//            return "unknown"
//        }
//
//        switch status {
//        case .notDetermined: return "notDetermined"
//        case .authorizedWhenInUse: return "authorizedWhenInUse"
//        case .authorizedAlways: return "authorizedAlways"
//        case .restricted: return "restricted"
//        case .denied: return "denied"
//        default: return "unknown"
//        }
//    }
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        locationStatus = status
//        print(#function, statusString)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        lastLocation = location
//        print(#function, location)
//    }
//}
