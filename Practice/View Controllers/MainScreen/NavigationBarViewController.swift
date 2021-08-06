//
//  NavigationBarViewController.swift
//  Practice
//
//  Created by Cypress on 7/27/21.
//

import Foundation
import UIKit

class NavigationBarViewController: UIViewController {
    // MARK: - Properties

    private let transition = SlideInTransition()

    private lazy var menuController: MenuViewController = {
        guard let menuViewController = storyboard?
                .instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController
        else { fatalError() }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        menuViewController.delegate = self
        return menuViewController
    }()

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }

    // MARK: - Methods

    func setupNavigationBar() {
        let menuBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"),
                                                style: .plain,
                                                target: self,
                                                action: #selector(barButtonItemTapped))

        menuBarButtonItem.tintColor = .darkGray

        navigationItem.leftBarButtonItem = menuBarButtonItem
    }

    @objc
    func barButtonItemTapped() {
        present(menuController, animated: true)
    }
}

// MARK: - Extensions

extension NavigationBarViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController,
                             presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}

extension NavigationBarViewController: MenuDelegate {
    func didSelect(_ item: MenuItem) {
        guard let selectedViewController = storyboard?.instantiateViewController(identifier: item.vcIdentifier)
        else { return }
        navigationController?.setViewControllers([selectedViewController], animated: false)
    }
}

private extension MenuItem {
    var vcIdentifier: String {
        switch self {
        case .users:
            return "UsersViewController"
        case .contacts:
            return "ContactsViewController"
        case .pictures:
            return "PicturesViewController"
        }
    }
}
