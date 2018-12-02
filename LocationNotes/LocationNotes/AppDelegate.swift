//
//  AppDelegate.swift
//  LocationNotes
//
//  Created by Zhong, Zhetao on 11/30/18.
//  Copyright © 2018 Zhong, Zhetao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var module = LocAndWeaModule()
    
    var notes : Notes!
    
    let defaults = UserDefaults(suiteName: kAppGroupBundleID)!
    
    override init() {
        defaults.set(Bundle.main.build, forKey: dAppVersion)
    }
    
    var dataFileName = "NotesFile"
    
    lazy var fileURL: URL = {
        let documentsDir =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDir.appendingPathComponent(dataFileName, isDirectory: false)
    }()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initDefaults()
        loadData()
        
        if let tabBarController = window?.rootViewController as? UITabBarController {
            for viewController in tabBarController.viewControllers! {
                print(viewController.description)
            }
            if let currentController = tabBarController.viewControllers?.first as? CurrentLoc{
                currentController.module = module
            }
            
            if let navController = tabBarController.viewControllers?[1] as? UINavigationController{
                
                if let tableController = navController.viewControllers.first as? MyTableViewController {
                    tableController.module = module
                    tableController.notes = notes
                }
                
            }
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
        let numLaunches = defaults.integer(forKey: dNumLaunches) + 1
        defaults.set(numLaunches, forKey: dNumLaunches)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        dateFormatter.locale = Locale.current
        let currentDate = Date()
        defaults.set(dateFormatter.string(from: currentDate), forKey: dAccessDate)
        saveData()
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func saveData() {
        
        if FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try FileManager.default.removeItem(at: fileURL)
            } catch {
                fatalError(error.localizedDescription)
            }
        }
        
        if let encodedData = try? JSONEncoder().encode(notes) {
            FileManager.default.createFile(atPath: fileURL.path, contents: encodedData, attributes: nil)
        } else {
            fatalError("Couldn't write data!")
        }
    }
    
    func loadData() {
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            notes = Notes()
            return
        }
        
        if let jsondata = FileManager.default.contents(atPath: fileURL.path) {
            let decoder = JSONDecoder()
            do {
                notes = try decoder.decode(Notes.self, from: jsondata)
            } catch {
                fatalError(error.localizedDescription)
            }
        } else {
            fatalError("No data at \(fileURL.path)!")
        }
    }
    
    func initDefaults() {
        if let path = Bundle.main.path(forResource: "Defaults", ofType: "plist"),
            let dictionary = NSDictionary(contentsOfFile: path) {
            defaults.register(defaults: dictionary as! [String : Any])
            defaults.synchronize()
        }
    }


}

