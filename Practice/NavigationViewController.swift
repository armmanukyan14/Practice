//
//  NavigationViewController.swift
//  Practice
//
//  Created by Cypress on 7/8/21.
//

import UIKit

class NavigationViewController: UINavigationController {
    
    private let onboardingIsSeen = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewDidAppear(animated)
        showInitialScreen()
    }
    
    private func showInitialScreen() {
        if onboardingIsSeen {
            showSignIn()
        } else {
            showOnboardingScreen()
        }
    }
    
    private func showOnboardingScreen() {
        let mainViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "MainViewController")
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = mainViewController
            UIView.transition(with: window,
                              duration: 0,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    private func showSignIn() {
        let signInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SignInViewController")
        if let sceneDelegate = view.window?.windowScene?.delegate as? SceneDelegate, let window = sceneDelegate.window {
            window.rootViewController = signInViewController
            UIView.transition(with: window,
                              duration: 0,
                              options: .transitionCrossDissolve,
                              animations: nil,
                              completion: nil)
        }
    }
    
    
    
}
