//
//  MainView.swift
//  SwiftChart
//
//  Created by Martin Gagnon on 2/5/19.
//  Copyright © 2019 Martin Gagnon. All rights reserved.
//

import UIKit

protocol MainViewDelegate: AnyObject {
    func showFirstView()
    func showSecondView()
}

class MainView: UIView, UICollectionViewDelegateFlowLayout {
    weak var mainViewDelegate: MainViewDelegate?

    public var titleLabel : UILabel!
    
    var showFirstViewButton : UIButton!
    var showSecondViewButton : UIButton!


    override init (frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = UIColor.yellow
        createSubviews()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {

        titleLabel = UILabel()
        titleLabel.text = "Main View"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontForContentSizeCategory = true
        self.addSubview(titleLabel)
        
        showFirstViewButton = UIButton()
        showFirstViewButton.setTitle("Show First View", for: .normal)
        showFirstViewButton.translatesAutoresizingMaskIntoConstraints = false
        showFirstViewButton.addTarget(self, action: #selector(showFirstView), for: .touchUpInside)
        showFirstViewButton.backgroundColor = UIColor.lightGray
        self.addSubview(showFirstViewButton)
        
        showSecondViewButton = UIButton()
        showSecondViewButton.setTitle("Show Second View", for: .normal)
        showSecondViewButton.translatesAutoresizingMaskIntoConstraints = false
        showSecondViewButton.addTarget(self, action: #selector(showSecondView), for: .touchUpInside)
        showSecondViewButton.backgroundColor = UIColor.lightGray
        self.addSubview(showSecondViewButton)


     }
    
    func createConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        showFirstViewButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        showFirstViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        showFirstViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        showFirstViewButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        showSecondViewButton.topAnchor.constraint(equalTo: showFirstViewButton.bottomAnchor, constant: 10).isActive = true
        showSecondViewButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        showSecondViewButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        showSecondViewButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

     }
    
    
    @objc func showFirstView() {
        // Present View "Modally"
        if (self.mainViewDelegate != nil) {
            self.mainViewDelegate?.showFirstView()
        }
    }
    
    @objc func showSecondView() {
        // Present View "Modally"
        if (self.mainViewDelegate != nil) {
            self.mainViewDelegate?.showSecondView()
        }
    }

    
}
