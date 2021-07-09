//
//  MainViewController.swift
//  Practice
//
//  Created by Cypress on 7/2/21.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var skipButton: UIButton!
    @IBOutlet var pageControl: UIPageControl!
    
    var pageViewController: UIPageViewController!
    
    
    private func getPageViewController(identifiers: String...) -> [UIViewController] {
        identifiers.compactMap { identifier in
            storyboard?.instantiateViewController(identifier: identifier)
        }
    }
    
    lazy var pages = getPageViewController(identifiers: "FirstPageViewController",
                                                        "SecondPageViewController",
                                                        "ThirdPageViewController",
                                                        "LastPageViewController")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pageViewController.setViewControllers([pages[0]], direction: .forward, animated: false)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        pageControl.numberOfPages = pages.count
        pageControl.currentPage = 0
//        hideSkip()
//        for index in pages {
//            if index == pages[3] {
//                skipButton.isHidden = true
//            } else {
//                skipButton.isHidden = false
//            }
//        }
        

    }

    
    @IBAction func skipButtonTapped(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: "SignInViewController") else { return }
        self.navigationController?.pushViewController(vc, animated: true)
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
    
    
//    func goToSpecificPage(index: Int, ofViewControllers pages: [UIViewController]) {
//        pageViewController.setViewControllers([pages[index]], direction: .forward, animated: true, completion: nil)
//        }
}
extension MainViewController: UIPageViewControllerDataSource {
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
extension MainViewController: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            self.pageControl.currentPage = currentIndex
        }
        hideSkip()
    }
    
}

