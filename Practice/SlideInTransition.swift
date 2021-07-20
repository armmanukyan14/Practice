//
//  SlideInTransition.swift
//  Practice
//
//  Created by Cypress on 7/20/21.
//

import Foundation
import UIKit

class SlideInTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    var isPresenting = false
    let darkView = UIView()
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: .to),
              let fromVC = transitionContext.viewController(forKey: .from) else { return }
        let containerView = transitionContext.containerView
        let width = toVC.view.bounds.width * 0.8
        let height = toVC.view.bounds.height
        
        if isPresenting {
            darkView.backgroundColor = .black
            darkView.alpha = 0.0
            containerView.addSubview(darkView)
            darkView.frame = containerView.bounds
            containerView.addSubview(toVC.view)
            toVC.view.frame = CGRect(x: -width, y: 0, width: width, height: height)
        }
        
        let transform = {
            self.darkView.alpha = 0.5
            toVC.view.transform = CGAffineTransform(translationX: width, y: 0)
        }
        let identity = {
            self.darkView.alpha = 0.0
            fromVC.view.transform = .identity
        }
        let duration = self.transitionDuration(using: transitionContext)
        let cancel = transitionContext.transitionWasCancelled
        UIView.animate(withDuration: duration, animations: {
            self.isPresenting ? transform() : identity()
        }) { (_) in
            transitionContext.completeTransition(!cancel)
        }
        
    }
    
}



