//
//  AppDelegate.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/01.
//

import UIKit
import GoogleSignIn

let sumTime = "sum"
let countTime = "count"
let initialKey = "initialKey"
let themePurchaseKey = "themePurchaseKey"
let topicKey = "topicKey"
let topicTimeKey = "topicTimeKey"

var topicList: [String] = ["PreTopic"]
var topicTimeList: [Int] = [1]

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        return GIDSignIn.sharedInstance.handle(url)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        if !UserDefaults.standard.bool(forKey: initialKey) {
            UserDefaults.standard.set(Array(repeating: false, count: 8), forKey: themePurchaseKey)
            UserDefaults.standard.set(["터치해서 공부 시작"], forKey: topicKey)
            UserDefaults.standard.set([0], forKey: topicTimeKey)
            UserDefaults.standard.set(true, forKey: initialKey)
        }
        
        topicList = UserDefaults.standard.stringArray(forKey: topicKey)!
        topicTimeList = (UserDefaults.standard.array(forKey: topicTimeKey) as? [Int])!
        
        
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

