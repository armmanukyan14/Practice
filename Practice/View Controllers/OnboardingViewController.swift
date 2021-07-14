//
//  OnboardingViewController.swift
//  Practice
//
//  Created by Cypress on 7/12/21.
//

import Foundation
import UIKit

class OnboardingViewController: UIViewController {
    
    //MARK: - Properties
    var currentIndex = 0
    var pageViewController: UIPageViewController!
    private let defaultsHelper = DefaultsHelper()
    lazy var pages = getPageViewController(identifiers: "FirstPageViewController",
                                           "SecondPageViewController",
                                           "ThirdPageViewController",
                                           "LastPageViewController")
    
    // MARK: - Outlets
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    
    // MARK: - Actions
    @IBAction func pageControl(_ sender: UIPageControl) {
        let direction: UIPageViewController.NavigationDirection = pageControl.currentPage > currentIndex ? .forward : .reverse
        guard pageControl.currentPage >= 0, pageControl.currentPage <= pages.count else { return }
        pageViewController.setViewControllers([pages[pageControl.currentPage]], direction: direction, animated: true)
        currentIndex = pageControl.currentPage
        hideSkip()
        
    }
    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        defaultsHelper.setOnboarding(isSeen: true)
        let signInVC = UIStoryboard.main.instantiateViewController(withIdentifier: "SignInViewController")
        navigationController?.setViewControllers([signInVC], animated: true)
    }
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: false)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
    }
    
    // MARK: - Methods
    private func getPageViewController(identifiers: String...) -> [UIViewController] {
        identifiers.compactMap { identifier in
            storyboard?.instantiateViewController(identifier: identifier)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? UIPageViewController {
            self.pageViewController = pageViewController
        }
    }
    
    func hideSkip() {
        if let index = pageControl?.currentPage {
            switch index {
            case 0...2:
                skipButton.isHidden = false
            case 3:
                skipButton.isHidden = true
            default:
                break
            }
            pageControl.currentPage = index
        }
    }
}

    // MARK: - Extensions
extension OnboardingViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController), index > 0 {
            return pages[index-1]
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let index = pages.firstIndex(of: viewController), index < pages.count - 1 {
            return pages[index + 1]
        }
        return nil
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
extension OnboardingViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            self.pageControl.currentPage = currentIndex
        }
        hideSkip()
    }
}

