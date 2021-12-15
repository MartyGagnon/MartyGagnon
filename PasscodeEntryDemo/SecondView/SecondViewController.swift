//
//  SecondViewController.swift
//  PasscodeEntryDemo
//
//  Created by Martin Gagnon on 12/13/21.
//

import UIKit
import SwiftUI


class SecondViewController: PasscodePoppingViewController, SecondViewDelegate  {
    
    var myView: SecondView! { return view as? SecondView }

    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func loadView() {
        super.loadView()
        view = SecondView(frame: UIScreen.main.bounds)
        myView.secondViewDelegate = self
    }
    
    func dismissSecondView() {
        self.dismiss(animated: true)
    }
}

