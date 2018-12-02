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
    
    var locationManager : CLLocationManager = CLLocationManager()
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
