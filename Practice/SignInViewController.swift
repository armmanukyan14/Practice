//
//  SignInViewController.swift
//  Practice
//
//  Created by Cypress on 6/29/21.
//

import UIKit

class SignInViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        changeTextFields()
    }
    
    func changeTextFields() {
        email.layer.cornerRadius = 25.0
        email.layer.borderWidth = 1.0
        email.layer.borderColor = UIColor.brown.cgColor
        password.layer.cornerRadius = 25.0
        password.layer.borderWidth = 1.0
        password.layer.borderColor = UIColor.brown.cgColor
//        email.borderStyle = UITextField.BorderStyle.roundedRect
//        password.borderStyle = UITextField.BorderStyle.roundedRect
        
    }
    
}

//nameOfTextField.layer.cornerRadius = 15.0
//nameOfTextField.layer.borderWidth = 2.0
//nameOfTextField.layer.borderColor = UIColor.red.cgColor
