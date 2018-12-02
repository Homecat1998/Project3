//
//  CurrentLoc.swift
//  LocationNotes
//
//  Created by Zhong, Zhetao on 11/30/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit
import CoreLocation
import JavaScriptCore

class CurrentLoc: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet var latitudeDescLabel: UILabel!
    @IBOutlet var longitudeDescLabel: UILabel!
    @IBOutlet var cityDescLabel: UILabel!
    @IBOutlet var latitudeLabel: UILabel!
    @IBOutlet var longitudeLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    @IBOutlet var weatherDescLabel: UILabel!
    @IBOutlet var tempDescLabel: UILabel!
    @IBOutlet var humidityDescLabel: UILabel!
    @IBOutlet var weatherLabel: UILabel!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    
    var module : LocAndWeaModule!
    
    var weatherGet = 0
    
    var locationManager: CLLocationManager!
    var weatherStr = "Waiting"
    var tempStr = "Waiting"
    var humidityStr = "Waiting"
    var colorNum = 0
    
    let appid = "f308a3865c9e761e31a618a1eb84b7cb"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        latitudeDescLabel.text = NSLocalizedString("str_latitude", comment: "")
        longitudeDescLabel.text = NSLocalizedString("str_longitude", comment: "")
        cityDescLabel.text = NSLocalizedString("str_city", comment: "")
        
        weatherDescLabel.text = NSLocalizedString("str_weather", comment: "")
        tempDescLabel.text = NSLocalizedString("str_temp", comment: "")
        humidityDescLabel.text = NSLocalizedString("str_humidity", comment: "")
        
        weatherLabel.text = weatherStr
        tempLabel.text = tempStr
        humidityLabel.text = humidityStr
        
        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        locationManager.distanceFilter = 10
        
        locationManager.delegate = self
        tryStart()
        setBGColor()
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
            
            self.module.lat = coordinate.latitude.description
            self.module.lon = coordinate.longitude.description
        }

        let current = locations.last
        module.location = current
        locToCity()
        
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
    
    func locToCity(){
        let loc = module.location!
        let geoCoder :CLGeocoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(loc, completionHandler: {(placemark, error) -> Void in
            if(error == nil){
                let array = placemark! as NSArray
                let mark = array.firstObject as! CLPlacemark
                let city: String = (mark.addressDictionary! as NSDictionary).value(forKey: "City") as! String
                self.cityLabel.text = city
                self.module.city = city
                
                self.getWeather()
            }
            
        }
        
    )}
    
    
    func getWeather(){
        
        let loc = module.location!

        let urlString = "http://api.openweathermap.org/data/2.5/weather?lat=\(loc.coordinate.latitude)&lon=\(loc.coordinate.longitude)&appid=\(appid)"
        
        guard let url = URL(string: urlString) else {return}
        
        let request = URLRequest(url: url)
        
        let config = URLSessionConfiguration.default
        
        let session = URLSession(configuration: config)
        
        let task = session.dataTask(with: request) {(data, response, error) in
            if error != nil {
                print (error!.localizedDescription)
            }
            

            guard let data = data else {return}
            
            if let dic = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? NSDictionary{
                

                
                if let dic2: [NSDictionary] = dic!["weather"] as? [NSDictionary] {
                    
                    if let dic4 : NSDictionary = dic2[0]{
                        let weather = dic4["main"]
                        print("weather get!")
                        self.weatherGet = 1
                        self.weatherStr = "\(String(describing: weather!))"
                    }

                }
                
                if let dic3: NSDictionary = dic!["main"] as? NSDictionary {
                    
                    let temp = dic3["temp"]
                    let humidity = dic3["humidity"]
                    
                    self.tempStr = "\(String(describing: temp!))K"
                    self.humidityStr = "\(String(describing: humidity!))%"
                    
                    
                }
            }
            
            
        }
        task.resume()
        self.module.humidity = humidityStr
        self.module.temp = tempStr
        self.module.weather = weatherStr
        
        self.weatherLabel.text = weatherStr
        self.tempLabel.text = tempStr
        self.humidityLabel.text = humidityStr
        
        checkGet()
        
    }
    
    func checkGet(){
        usleep(500000)
        while (weatherGet == 0) {
            getWeather()
        }
    }
    
    
    
    
    @IBAction func OnTap(_ sender: UITapGestureRecognizer) {
        colorNum = colorNum + 1
        setBGColor()
    }
    
    func setBGColor(){
        if (colorNum == 0) {
            view.backgroundColor = UIColor(hue: 74/360, saturation: 100/100, brightness: 80/100, alpha: 1.0) /* #9ccc00 */
        } else if (colorNum == 1) {
            view.backgroundColor = UIColor(hue: 173/360, saturation: 100/100, brightness: 82/100, alpha: 1.0) /* #00d1b8 */
        } else if (colorNum == 2) {
            view.backgroundColor = UIColor(hue: 199/360, saturation: 100/100, brightness: 81/100, alpha: 1.0) /* #008dce */
        } else if (colorNum == 3) {
            colorNum = 0
            view.backgroundColor = UIColor(hue: 74/360, saturation: 100/100, brightness: 80/100, alpha: 1.0) /* #9ccc00 */
        }
    }
    
    @IBAction func OnSwipe(_ sender: UISwipeGestureRecognizer) {
        view.backgroundColor = UIColor(hue: 171/360, saturation: 0/100, brightness: 100/100, alpha: 1.0) /* #ffffff */
    }
    
}
