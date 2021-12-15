//
//  PasscodeEntryViewController.swift
//  PasscodeEntryDemo
//
//  Created by Martin Gagnon on 12/14/21.
//

import Foundation
import UIKit
import SwiftUI

protocol PasscodeEntryViewControllerDelegate: AnyObject {
    func passcodeViewDismissed()
}

class PasscodeEntryViewController: UIViewController, PasscodeEntryViewDelegate  {
    weak var passcodeEntryViewControllerDelegate: PasscodeEntryViewControllerDelegate?

    var myView: PasscodeEntryView! { return view as? PasscodeEntryView }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func loadView() {
        view = PasscodeEntryView(frame: UIScreen.main.bounds)
        myView.passcodeEntryViewDelegate = self
    }
    
    func dismissPasscodeEntryView() {
        self.dismiss(animated: false, completion: { [self] in
            if (passcodeEntryViewControllerDelegate != nil) {
                passcodeEntryViewControllerDelegate?.passcodeViewDismissed()
            }
        })

    }
    
}

