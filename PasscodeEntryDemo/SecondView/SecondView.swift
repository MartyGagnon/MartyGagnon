//
//  SecondView.swift
//  PasscodeEntryDemo
//
//  Created by Martin Gagnon on 12/13/21.
//

import UIKit


protocol SecondViewDelegate: AnyObject {
    func dismissSecondView()
}

class SecondView: UIView  {
    weak var secondViewDelegate: SecondViewDelegate?

    public var titleLabel : UILabel!
    var myButton : UIButton!

    

    override init (frame : CGRect) {
        super.init(frame : frame)
        self.backgroundColor = UIColor.green
        createSubviews()
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createSubviews() {
        

        titleLabel = UILabel()
        titleLabel.text = "Second UIKit View"
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 0
        titleLabel.adjustsFontForContentSizeCategory = true
        self.addSubview(titleLabel)
        
        myButton = UIButton()
        myButton.setTitle("<= Go Back", for: .normal)
        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.addTarget(self, action: #selector(clickIt), for: .touchUpInside)
        self.addSubview(myButton)

     }
    
    func createConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 100).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true

        myButton.translatesAutoresizingMaskIntoConstraints = false
        myButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 100).isActive = true
        myButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        myButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        myButton.heightAnchor.constraint(equalToConstant: 60).isActive = true

     }
    

    @objc func clickIt() {
        // Present View "Modally"
        if (self.secondViewDelegate != nil) {
            self.secondViewDelegate?.dismissSecondView()
        }
    }

    
}
