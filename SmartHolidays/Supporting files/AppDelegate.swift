//
//  AppDelegate.swift
//  SmartHolidays
//
//  Created by 1 on 9/3/19.
//  Copyright © 2019 1. All rights reserved.
//

import UIKit
import Firebase
import SnapKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.backgroundColor = .white
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
 
        FirebaseApp.configure()
        
        if Auth.auth().currentUser != nil {
            print("Logged in")
          window?.rootViewController = MainNavigationController(rootViewController: HolidaysViewController())
        } else {
            print("Not logged in")
            window?.rootViewController = UINavigationController(rootViewController: WelcomeViewController())
        }
        
        return true
    }

}

