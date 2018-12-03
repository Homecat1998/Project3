//
//  AboutViewController.swift
//  LocationNotes
//
//  Created by Zhong, Zhetao on 12/2/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    let defaults = UserDefaults(suiteName: kAppGroupBundleID)!
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appVer: UILabel!
    @IBOutlet weak var appBuild: UILabel!
    @IBOutlet weak var launchDate: UILabel!
    @IBOutlet weak var launchNum: UILabel!
    @IBOutlet weak var copyRight: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
        appName.text = Bundle.main.displayName
        appVer.text = Bundle.main.version
        appBuild.text = Bundle.main.build
        copyRight.text = Bundle.main.copyright

        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        launchNum.text = defaults.integer(forKey: dNumLaunches).description
        launchDate.text = defaults.string(forKey: dAccessDate)
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
