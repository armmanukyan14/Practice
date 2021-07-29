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
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        makeNavBar()
    }
    
    // MARK: - Methods
    func makeNavBar() {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 80))
        view.addSubview(navBar)
        navBar.barTintColor = .gray
        let navItem = UINavigationItem(title: "")
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3"), style: .plain, target: self, action: #selector(barButtonItemTapped))
        navItem.leftBarButtonItem = barButtonItem
        navBar.setItems([navItem], animated: false)
    }
    
    @objc
    func barButtonItemTapped() {
        guard let menuViewController = storyboard?.instantiateViewController(withIdentifier: "MenuViewController") else { return }
        menuViewController.modalPresentationStyle = .overCurrentContext
        menuViewController.transitioningDelegate = self
        present(menuViewController, animated: true)
    }
}
    // MARK: - Extensions
extension NavigationBarViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = true
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.isPresenting = false
        return transition
    }
}
