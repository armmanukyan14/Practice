//
//  SignInViewController.swift
//  Practice
//
//  Created by Cypress on 6/29/21.
//

import UIKit

class SignInViewController: UIViewController {
    
    let defaultsHelper = DefaultsHelper()
    
    // MARK: - Outlets
    @IBOutlet weak var eyeButton: UIButton!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var haventAccount: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
    // MARK: - Actions
    @IBAction func eyeButtonTapped(_ sender: UIButton) {
        if password.isSecureTextEntry == true {
            password.isSecureTextEntry = false
        } else {
            password.isSecureTextEntry = true
        }
    }

    @IBAction func signInButtonTapped(_ sender: UIButton) {
        defaultsHelper.setLogin(isSeen: true)
        if email.text?.isValidEmail == true, password.text != "" {
            let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "MainScreenViewController")
            navigationController?.setViewControllers([vc], animated: true)
        } else {
            emailErrorLabel.isHidden = false
            emailErrorLabel.text = "invalid email!"
        }       
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        changeTextFields()
        changeBackground()
        haventAccount.textColor = .white
        emailErrorLabel.isHidden = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            view.addGestureRecognizer(tap)
    }
    
    // MARK: - Methods
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func changeBackground() {
        let background = UIImage(named: "signin")
        var imageView : UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode =  UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        self.view.sendSubviewToBack(imageView)
    }
    
    func changeTextFields() {
        email.layer.cornerRadius = 22.0
        email.layer.borderWidth = 1.0
        email.layer.borderColor = UIColor.borderColor.cgColor
        let emailPadding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.email.frame.height))
        email.leftView = emailPadding
        email.leftViewMode = .always
        email.tintColor = UIColor.textColor
        email.textColor = UIColor.textColor
        email.attributedPlaceholder = NSAttributedString(string: "E-mail",
                                                         attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderColor])
        password.layer.cornerRadius = 22.0
        password.layer.borderWidth = 1.0
        password.layer.borderColor = UIColor.borderColor.cgColor
        let passwordPadding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.password.frame.height))
        password.leftView = passwordPadding
        password.leftViewMode = .always
        password.addSubview(eyeButton)
        password.rightView = eyeButton
        eyeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
        password.rightViewMode = .always
        password.tintColor = UIColor.textColor
        password.textColor = UIColor.textColor
        password.attributedPlaceholder = NSAttributedString(string: "Password",
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderColor])
    }
}



