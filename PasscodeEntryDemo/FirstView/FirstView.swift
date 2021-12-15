//
//  FirstView.swift
//  PasscodeEntryDemo
//
//  Created by Martin Gagnon on 12/13/21.
//


import UIKit

protocol FirstViewDelegate: AnyObject {
    func showPasscodeIfNeeded()

    func toggleLanguage()
    func showLastNameAlert()
    func showZeroBalanceAlert()
    func goBack()

}

class FirstView: UIView {
    weak var firstViewDelegate: FirstViewDelegate?

    public var titleLabel : UILabel!
    var changeButton : UIButton!
    var showLastNameAlert : UIButton!
    var showZeroBalanceAlert : UIButton!
    var backButton : UIButton!

    

    override init (frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = UIColor.red
        createSubviews()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {
        

        titleLabel = UILabel()
        titleLabel.text = "First View"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontForContentSizeCategory = true
        self.addSubview(titleLabel)
        
        changeButton = UIButton()
        changeButton.backgroundColor = UIColor.lightGray
        changeButton.setTitle("Change", for: .normal)
        changeButton.translatesAutoresizingMaskIntoConstraints = false
        changeButton.addTarget(self, action: #selector(changeLanguage), for: .touchUpInside)
        self.addSubview(changeButton)

        showLastNameAlert = UIButton()
        showLastNameAlert.backgroundColor = UIColor.lightGray
        showLastNameAlert.setTitle("Show Last Name Alert", for: .normal)
        showLastNameAlert.translatesAutoresizingMaskIntoConstraints = false
        showLastNameAlert.addTarget(self, action: #selector(lastNameAlertPushed), for: .touchUpInside)
        self.addSubview(showLastNameAlert)

        showZeroBalanceAlert = UIButton()
        showZeroBalanceAlert.backgroundColor = UIColor.lightGray
        showZeroBalanceAlert.setTitle("Show 0 Balance Alert", for: .normal)
        showZeroBalanceAlert.translatesAutoresizingMaskIntoConstraints = false
        showZeroBalanceAlert.addTarget(self, action: #selector(zeroBalanceAlertPushed), for: .touchUpInside)
        self.addSubview(showZeroBalanceAlert)

        backButton = UIButton()
        backButton.backgroundColor = UIColor.lightGray
        backButton.setTitle("<= Go Back", for: .normal)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.addTarget(self, action: #selector(backButtonPushed), for: .touchUpInside)
        self.addSubview(backButton)

     }
    
    func createConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        changeButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        changeButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        changeButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        changeButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        showLastNameAlert.topAnchor.constraint(equalTo: changeButton.bottomAnchor, constant: 10).isActive = true
        showLastNameAlert.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        showLastNameAlert.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        showLastNameAlert.heightAnchor.constraint(equalToConstant: 30).isActive = true

        showZeroBalanceAlert.topAnchor.constraint(equalTo: showLastNameAlert.bottomAnchor, constant: 10).isActive = true
        showZeroBalanceAlert.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        showZeroBalanceAlert.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        showZeroBalanceAlert.heightAnchor.constraint(equalToConstant: 30).isActive = true

        backButton.topAnchor.constraint(equalTo: showZeroBalanceAlert.bottomAnchor, constant: 10).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        backButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        backButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

     }
    
    @objc func changeLanguage() {
        // Present View "Modally"
        if (self.firstViewDelegate != nil) {
            self.firstViewDelegate?.toggleLanguage()
        }
    }

    @objc func lastNameAlertPushed() {
        // Present View "Modally"
        if (self.firstViewDelegate != nil) {
            self.firstViewDelegate?.showLastNameAlert()
        }
    }
    
    @objc func zeroBalanceAlertPushed() {
        // Present View "Modally"
        if (self.firstViewDelegate != nil) {
            self.firstViewDelegate?.showZeroBalanceAlert()
        }
    }

    @objc func backButtonPushed() {
        // Present View "Modally"
        if (self.firstViewDelegate != nil) {
            self.firstViewDelegate?.goBack()
        }
    }


    
}
