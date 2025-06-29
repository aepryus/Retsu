//
//  AppDelegate.swift
//  Retsu
//
//  Created by Joe Charlier on 11/6/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

// UIApplicationDelegate ===========================================================================
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        Retsu.start()
        return true
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        Retsu.originViewController.loadSpecimen()
    }
}
