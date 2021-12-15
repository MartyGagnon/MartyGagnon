//
//  AppDelegate.swift
//  PasscodeEntryDemo
//
//  Created by Martin Gagnon on 12/10/21.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    override init() {
        if let myLanguage = UserDefaults.standard.string(forKey: "myLanguage") {
            var myAppSettings = MyAppSettings()
            myAppSettings.language = myLanguage
            myAppSettings.showPasswordView = "NO"
            myAppSettings.currentAlertType = ""
            MyEnvironment.shared.register(myAppSettings)
        }
        else {
            MyEnvironment.shared.register(MyAppSettings())
            /*
            if let value = MyEnvironment.shared.values.first {
                let xx = value as? MyAppSettings
                let yy = xx?.language
                print(yy)
            }
             */
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
    
    func applicationWillResignActive(_ application: UIApplication) {}




}

