//
//  SignInViewController.swift
//  Practice
//
//  Created by Cypress on 6/29/21.
//

import RxCocoa
import RxGesture
import RxSwift
import UIKit

final class SignInViewController: UIViewController {
    // MARK: - Properties

    private let defaultsHelper = DefaultsHelper()
    private let viewModel = SignInViewModel()
    private let disposeBag = DisposeBag()

    private lazy var eyeButton: UIButton = {
        let eyeButton = UIButton()
        eyeButton.tintColor = UIColor.textFieldBorderColor
        let eyeImage = UIImage(systemName: "eye")
        eyeButton.setImage(eyeImage, for: .normal)
        return eyeButton
    }()

    // MARK: - Outlets

    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var signInButton: UIButton!
    @IBOutlet var haventAccountLabel: UILabel!
    @IBOutlet var emailErrorLabel: UILabel!
    @IBOutlet var passwordErrorLabel: UILabel!

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        doBindings()
        setupTextFields()
        setupLabels()
        addEyeButton()
        changeBackground()
        hideErrorLabels()
        closeKeyboardWhenTapped()
    }

    // MARK: - Reactive

    private func doBindings() {
        bindOutputs()
        bindInputs()
        bindNavigation()
        bindUI()
    }

    private func bindUI() {
        eyeButton.rx.tap.asDriver()
            .drive(onNext: { [weak self] _ in
                let isSelected = self?.eyeButton.tintColor == .gray
                self?.eyeButton.tintColor = isSelected ? UIColor.textFieldBorderColor : .gray
                self?.passwordTextField.isSecureTextEntry = isSelected
            })
            .disposed(by: disposeBag)

        view.rx.tapGesture().when(.recognized).asDriver(onErrorDriveWith: .never())
            .drive(onNext: { [weak self] _ in
                self?.view.endEditing(true)
            })
            .disposed(by: disposeBag)
    }

    private func bindInputs() {
        emailTextField.rx.text.orEmpty
            .bind(to: viewModel.email)
            .disposed(by: disposeBag)

        passwordTextField.rx.text.orEmpty
            .bind(to: viewModel.password)
            .disposed(by: disposeBag)
    }

    private func bindOutputs() {
        viewModel.emailError.skip(1)
            .subscribe(onNext: { [weak self] error in
                if let error = error {
                    self?.emailErrorLabel.text = error
                    self?.emailErrorLabel.isHidden = false
                } else {
                    self?.emailErrorLabel.isHidden = true
                }
            })
            .disposed(by: disposeBag)

        viewModel.passwordError.skip(1)
            .subscribe(onNext: { [weak self] error in
                if let error = error {
                    self?.passwordErrorLabel.text = error
                    self?.passwordErrorLabel.isHidden = false
                } else {
                    self?.passwordErrorLabel.isHidden = true
                }
            })
            .disposed(by: disposeBag)

        viewModel.isSignInEnabled
            .bind(to: signInButton.rx.isEnabled)
            .disposed(by: disposeBag)
    }

    private func bindNavigation() {
        signInButton.rx.tap
            .do(onNext: { [weak self] in
                self?.defaultsHelper.setLogin(isSeen: true)
            })
            .subscribe(onNext: { [weak self] in
                let mainScreenViewController =
                    UIStoryboard.main.instantiateViewController(withIdentifier: "MainScreenViewController")
                self?.navigationController?.setViewControllers([mainScreenViewController], animated: true)
            })
            .disposed(by: disposeBag)
    }

    private func closeKeyboardWhenTapped() {
        let tapBackground = UITapGestureRecognizer()
        view.addGestureRecognizer(tapBackground)
        tapBackground.rx.event.subscribe(onNext: { [weak self] _ in
            self?.view.endEditing(true)
        })
            .disposed(by: disposeBag)
    }

    // MARK: - Methods

    func changeBackground() {
        let background = UIImage(named: "signin")
        var imageView: UIImageView!
        imageView = UIImageView(frame: view.bounds)
        imageView.contentMode = UIView.ContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = view.center
        view.addSubview(imageView)
        view.sendSubviewToBack(imageView)
    }

    func setupTextFields() {
        emailTextField.layer.cornerRadius = 24.0
        emailTextField.layer.borderWidth = 1.0
        emailTextField.layer.borderColor = UIColor.textFieldBorderColor.cgColor
        let emailPadding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: emailTextField.frame.height))
        emailTextField.leftView = emailPadding
        emailTextField.leftViewMode = .always
        emailTextField.tintColor = UIColor.textColor
        emailTextField.textColor = UIColor.textColor
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: "E-mail",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderColor])
        passwordTextField.layer.cornerRadius = 24.0
        passwordTextField.layer.borderWidth = 1.0
        passwordTextField.layer.borderColor = UIColor.textFieldBorderColor.cgColor
        let passwordPadding = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: passwordTextField.frame.height))
        passwordTextField.leftView = passwordPadding
        passwordTextField.leftViewMode = .always
        passwordTextField.tintColor = UIColor.textColor
        passwordTextField.textColor = UIColor.textColor
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: "Password",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.placeholderColor])
    }

    func setupLabels() {
        haventAccountLabel.textColor = .white
        emailErrorLabel.textColor = UIColor.errorLabelColor
        passwordErrorLabel.textColor = UIColor.errorLabelColor
    }

    func addEyeButton() {
        passwordTextField.rightView = eyeButton
        passwordTextField.rightViewMode = .always
        eyeButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -16, bottom: 0, right: 0)
    }

    func hideErrorLabels() {
        emailErrorLabel.isHidden = true
        passwordErrorLabel.isHidden = true
    }
}
