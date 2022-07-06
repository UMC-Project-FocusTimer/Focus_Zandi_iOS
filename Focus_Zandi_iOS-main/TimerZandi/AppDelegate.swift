//
//  AppDelegate.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/01.
//

import UIKit

let sumTime = "sum"
let countTime = "count"
var forzandi = [2, 3, 4, 3, 1, 2, 22, 12, 3, 22, 10, 23, 42, 11, 23, 21, 11, 11, 1, 3, 4, 4, 2, 3, 4, 3, 1, 2, 22, 12, 3, 22, 10, 23, 42, 11, 23, 21, 11, 11, 1, 3, 4, 4]


@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        print(UserDefaults.standard.value(forKey: sumTime))
        print(UserDefaults.standard.value(forKey: countTime))
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

