//
//  ViewController.swift
//  SimpleCollectionView
//
//  Created by Martin Gagnon on 11/6/19.
//  Copyright © 2019 Martin Gagnon. All rights reserved.
//

import UIKit
import SwiftUI


class MainViewController: UIViewController ,  MainViewDelegate {
    
    var myView: MainView! { return view as? MainView }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myView.mainViewDelegate = self
    }

    override func loadView() {
        view = MainView(frame: UIScreen.main.bounds)
    }
    
    //MARK: MainViewDelegate protocol implementations
    func showFirstView() {
        let firstViewController = FirstViewController()
        firstViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(firstViewController, animated: true, completion: nil)
    }
    
    func showSecondView() {
        let secondViewController = SecondViewController()
        secondViewController.modalPresentationStyle = .fullScreen //or .overFullScreen for transparency
        self.present(secondViewController, animated: true, completion: nil)
    }

}

