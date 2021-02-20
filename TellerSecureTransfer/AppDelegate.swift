//
//  AppDelegate.swift
//  TellerSecureTransfer
//
//  Created by Vamsi Krishna Tirumala on 20/02/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        TSApplicationController.shared.initWithWindow(_appWindow: self.window!)
        TSApplicationController.shared.lanchApplication()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

