//
//  SceneDelegate.swift
//  Practice
//
//  Created by Cypress on 6/29/21.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard (scene as? UIWindowScene) != nil else { return }

        let defaultsHelper = DefaultsHelper()

        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .lightGray

        let navigationController = window?.rootViewController as? UINavigationController
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance

        navigationController?.setNavigationBarHidden(!defaultsHelper.isLoggedIn, animated: false)

        var initialVC: UIViewController
        if defaultsHelper.isLoggedIn {
            initialVC = UIStoryboard.main.instantiateViewController(withIdentifier: "MainScreenViewController")
        } else if defaultsHelper.isOnboardingSeen {
            initialVC = UIStoryboard.main.instantiateViewController(withIdentifier: "SignInViewController")
        } else {
            initialVC = UIStoryboard.main.instantiateViewController(withIdentifier: "OnboardingViewController")
        }

        navigationController?.setViewControllers([initialVC], animated: false)
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}
}
