//
//  DetailViewController.swift
//  LocationNotes
//
//  Created by Zhong, Zhetao on 12/1/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class DetailViewController: UIViewController {
    
    var noteItem : NoteItem!
    
    var bgColor = 0
    
    var locationManager : CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var temp: UILabel!

    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var note: UILabel!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if (bgColor == 0) {
            view.backgroundColor = UIColor(hue: 74/360, saturation: 100/100, brightness: 80/100, alpha: 1.0) /* #9ccc00 */
        } else if (bgColor == 1) {
            view.backgroundColor = UIColor(hue: 173/360, saturation: 100/100, brightness: 82/100, alpha: 1.0) /* #00d1b8 */
        } else if (bgColor == 2) {
            view.backgroundColor = UIColor(hue: 199/360, saturation: 100/100, brightness: 81/100, alpha: 1.0) /* #008dce */
        } else if (bgColor == 3) {
            bgColor = 0
            view.backgroundColor = UIColor(hue: 74/360, saturation: 100/100, brightness: 80/100, alpha: 1.0) /* #9ccc00 */
        }
        
        
        self.mapView.mapType = MKMapType.standard
        
        // set the zoom
        let latDel = 0.05
        let lonDel = 0.05
        let currentZoom: MKCoordinateSpan = MKCoordinateSpanMake(latDel, lonDel)
        
        
        // set the centre
        let latValue = Double(noteItem!.lat)
        let lonValue = Double(noteItem!.lon)
        let centre : CLLocation = CLLocation(latitude: latValue!, longitude: lonValue!)
        
        let region : MKCoordinateRegion = MKCoordinateRegion(center: centre.coordinate, span: currentZoom)
        mapView.setRegion(region, animated: true)
        
        // put an anno
        let anno = MKPointAnnotation()
        anno.coordinate = centre.coordinate
        
        mapView.addAnnotation(anno)
        
        
        city.text = noteItem.city
        date.text = noteItem.date
        temp.text = "\(noteItem.temp), \(noteItem.humidity)"
        noteTitle.text = NSLocalizedString("str_yourNote", comment: "")
        note.text = noteItem.note
    


        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
