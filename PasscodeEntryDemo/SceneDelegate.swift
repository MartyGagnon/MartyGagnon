//
//  SceneDelegate.swift
//  PasscodeEntryDemo
//
//  Created by Martin Gagnon on 12/10/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    @Global var myAppSettings: MyAppSettings


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = MainViewController()
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("sceneDidBecomeActive")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                let t = type(of: topController)
                    print("'\(topController)' of type '\(t)'")
            }
            
            if topController is UIAlertController {
                topController.dismiss(animated: false, completion: nil)
            }
            else {
                myAppSettings.currentAlertType = ""

            }
        }
        UserDefaults.standard.set(myAppSettings.currentAlertType, forKey: "currentAlertyType")
        UserDefaults.standard.set("YES", forKey: "showPasscode")
        UserDefaults.standard.set(myAppSettings.language, forKey: "myLanguage")

    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        if let myLanguage = UserDefaults.standard.string(forKey: "myLanguage") {
            myAppSettings.language = myLanguage
        }
        if let myAlertType = UserDefaults.standard.string(forKey: "currentAlertType") {
            myAppSettings.currentAlertType = myAlertType
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        myAppSettings.showPasswordView = "YES"
    }


}

