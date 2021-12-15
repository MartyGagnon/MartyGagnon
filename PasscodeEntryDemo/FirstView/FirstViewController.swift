//
//  FirstViewController.swift
//  PasscodeEntryDemo
//
//  Created by Martin Gagnon on 12/13/21.
//
import UIKit
import SwiftUI

enum AlertTypes: String {
    case lastNameRequired, zeroBalance, genericError
}

class FirstViewController: UIViewController, GlobalUpdating, FirstViewDelegate, PasscodeEntryViewControllerDelegate {
    
    var myView: FirstView! { return view as? FirstView }
    @Global var myAppSettings: MyAppSettings
    
    var passcodeViewController: PasscodeEntryViewController?
    
    func update() {
        self.myView.titleLabel.text = myAppSettings.language
    }

    override func loadView() {
        view = FirstView(frame: UIScreen.main.bounds)
        //Register for the notification somewhere in the app
        NotificationCenter.default.addObserver(self, selector: "showPasscodeIfNeeded",
                                               name: UIApplication.willEnterForegroundNotification,
                                               object: nil)
    }
    
    @objc public func showPasscodeIfNeeded() {
        
        if (myAppSettings.showPasswordView == "YES"  && myAppSettings.language == "German") {
            passcodeViewController = PasscodeEntryViewController()
            passcodeViewController?.passcodeEntryViewControllerDelegate = self
            passcodeViewController?.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
            self.present(passcodeViewController!, animated: true, completion: nil)
        }
     }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myView.firstViewDelegate = self
        //**** Here is where I tell combine that I want to be notified of updates *****
        registerForUpdate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.myView.titleLabel.text = myAppSettings.language
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
    
    func toggleLanguage() {
        if (myAppSettings.language == "English") {
            myAppSettings.language = "German"
        }
        else {
            myAppSettings.language = "English"
        }
    }
       
    func goBack() {
        self.dismiss(animated: true, completion: nil)
    }

    func showLastNameAlert() {
        myAppSettings.currentAlertType = AlertTypes.lastNameRequired.rawValue
        createAlert(alertType: AlertTypes.lastNameRequired)
    }
    
    func showZeroBalanceAlert() {
        myAppSettings.currentAlertType = AlertTypes.zeroBalance.rawValue
        createAlert(alertType: AlertTypes.zeroBalance)
    }
    


    func createAlert(alertType: AlertTypes) {
        if (alertType == AlertTypes.lastNameRequired) {
            let dialogMessage = UIAlertController(title: "Last Name Check", message: "You are required to enter a last name", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in })
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: false, completion: nil)
        }
        else if (alertType == AlertTypes.zeroBalance) {
            let dialogMessage = UIAlertController(title: "Balance Warning", message: "Balance is 0", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in})
            let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in }
            dialogMessage.addAction(ok)
            dialogMessage.addAction(cancel)
            self.present(dialogMessage, animated: false, completion: nil)
        }
        else {
            let dialogMessage = UIAlertController(title: "Generic", message: "", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in})
            dialogMessage.addAction(ok)
            self.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    //MARK: PasscodeEntryViewControllerDelegate protocol implementations
    func passcodeViewDismissed() {
        if (myAppSettings.currentAlertType != "") {
            createAlert(alertType: AlertTypes(rawValue: myAppSettings.currentAlertType) ?? AlertTypes.genericError)
        }

    }

}

