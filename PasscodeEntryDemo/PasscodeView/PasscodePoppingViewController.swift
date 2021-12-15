//
//  PasscodePoppingViewController.swift
//  PasscodeEntryDemo
//
//  Created by Martin Gagnon on 12/15/21.
//

import UIKit
import SwiftUI

class PasscodePoppingViewController: UIViewController, GlobalUpdating, PasscodeEntryViewControllerDelegate {
    @Global var myAppSettings: MyAppSettings
    var passcodeViewController: PasscodeEntryViewController?
    
    func update() {
        // override this function in your derived view controller to respond to changes in the sinked values
    }

    override func loadView() {
        NotificationCenter.default.addObserver(self, selector: "showPasscodeIfNeeded",
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
    
    @objc public func showPasscodeIfNeeded() {
        passcodeViewController = PasscodeEntryViewController()
        passcodeViewController?.passcodeEntryViewControllerDelegate = self
        passcodeViewController?.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(passcodeViewController!, animated: true, completion: nil)
     }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        registerForUpdate()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
                let t = type(of: topController)
                    print("'\(topController)' of type '\(t)'")
            }
            
            if topController is UIAlertController {
                self.dismiss(animated: false, completion: nil)
            }
            else {
             //   myAppSettings.currentAlertType = ""

            }
        }
    }
    

    func createAlert(alertType: AlertTypes) {
        // override for your view controllers alerts
    }
    
    //MARK: PasscodeEntryViewControllerDelegate protocol implementations
    func passcodeViewDismissed() {
        if (myAppSettings.currentAlertType != "") {
            createAlert(alertType: AlertTypes(rawValue: myAppSettings.currentAlertType) ?? AlertTypes.genericError)
        }

    }

}

