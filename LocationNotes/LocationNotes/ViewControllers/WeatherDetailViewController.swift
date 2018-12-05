//
//  WeatherDetailViewController.swift
//  LocationNotes
//
//  Created by Guest User on 2018/12/4.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

class WeatherDetailViewController: UIViewController {
    
    var module : LocAndWeaModule!

    @IBOutlet weak var max: UILabel!
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var windSpeed: UILabel!
    @IBOutlet weak var windDeg: UILabel!
    
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var minLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var windDegLabel: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBGColor()
        
        minLabel.text = NSLocalizedString("str_min", comment: "")
        maxLabel.text = NSLocalizedString("str_max", comment: "")
        pressureLabel.text = NSLocalizedString("str_pressure", comment: "")
        windSpeedLabel.text = NSLocalizedString("str_windSpeed", comment: "")
        windDegLabel.text = NSLocalizedString("str_windDeg", comment: "")


        
        max.text = module.temp_max
        min.text = module.temp_min
        pressure.text = module.pressure
        windSpeed.text = module.windSpeed
        windDeg.text = module.windDeg

        // Do any additional setup after loading the view.
        
        
    }
    
    func setBGColor(){
        if (module.bgColor == 0) {
            view.backgroundColor = UIColor(hue: 74/360, saturation: 100/100, brightness: 80/100, alpha: 1.0) /* #9ccc00 */
        } else if (module.bgColor == 1) {
            view.backgroundColor = UIColor(hue: 173/360, saturation: 100/100, brightness: 82/100, alpha: 1.0) /* #00d1b8 */
        } else if (module.bgColor == 2) {
            view.backgroundColor = UIColor(hue: 199/360, saturation: 100/100, brightness: 81/100, alpha: 1.0) /* #008dce */
        } else if (module.bgColor == 3) {
            module.bgColor = 0
            view.backgroundColor = UIColor(hue: 74/360, saturation: 100/100, brightness: 80/100, alpha: 1.0) /* #9ccc00 */
        }
    }
    
    @IBAction func onDoneBtn(_ sender: UIButton) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
