//
//  CurrentLoc.swift
//  LocationNotes
//
//  Created by Zhong, Zhetao on 11/30/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentLoc: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var latitudeDescLabel: UILabel!
    @IBOutlet var longitudeDescLabel: UILabel!
    @IBOutlet var cityDescLabsel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    var locationManager: CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latitudeDescLabel.text = NSLocalizedString("str_latitude", comment: "")
        longitudeDescLabel.text = NSLocalizedString("str_longitude", comment: "")
        cityDescLabsel.text = NSLocalizedString("str_city", comment: "")
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 10
        
        locationManager.delegate = self
        tryStart()
    }
    
    // MARK: - Core Location
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error getting location: " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for location in locations {
            let coordinate = location.coordinate
            longitudeLabel.text = coordinate.longitude.description
            latitudeLabel.text = coordinate.latitude.description
        }
        
        let current = locations.last
        locToCity(loc: current!)
        
    }
    
    // MARK: - Re-authorize Alert
    
    func missingPermissionsAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let okAction = UIAlertAction(title: NSLocalizedString("str_ok", comment: ""), style: .cancel)
        let settingsAction = UIAlertAction(title: NSLocalizedString("str_settings", comment: ""), style: .default) { _ in
            UIApplication.shared.open(URL(string: UIApplicationOpenSettingsURLString)!)
        }
        
        alert.addAction(okAction)
        alert.addAction(settingsAction)
        present(alert, animated: true)
    }
    
    func tryStart() {
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            missingPermissionsAlert(title: NSLocalizedString("str_CLNoService", comment: ""),
                                    message: NSLocalizedString("str_CLDeniedPerm", comment: ""))
        case .restricted:
            missingPermissionsAlert(title: NSLocalizedString("str_CLNoService", comment: ""),
                                    message: NSLocalizedString("str_CLBlocked", comment: ""))
        default:
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
    
    func tryStop() {
        locationManager.stopUpdatingLocation()
        longitudeLabel.text = "-"
        latitudeLabel.text = "-"
    }
    
    func locToCity(loc: CLLocation){
        let geoCoder :CLGeocoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(loc, completionHandler: {(placemark, error) -> Void in
            if(error == nil){
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                let city: String = (mark.addressDictionary! as NSDictionary).value(forKey: "City") as! String
                self.cityLabel.text = city
            }
            
        }
        
    )}
    
}
