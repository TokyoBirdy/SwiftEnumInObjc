//
//  CHTransitionManager.swift
//  CustomSegueTransition
//
//  Created by Cecilia Humlelu on 05/02/15.
//  Copyright (c) 2015 Cecilia Humlelu. All rights reserved.
//

import UIKit

class CHTransitionManager: NSObject,UIViewControllerAnimatedTransitioning,UIViewControllerTransitioningDelegate {
    enum TransitionAnimation{
        case TransitionAnimationPush
        case TransitionAnimationRotate
    }
    
    private var presenting = true
    var transitionAnimation:TransitionAnimation = .TransitionAnimationPush
    
    init(aTransitionAnimation:TransitionAnimation) {
        self.transitionAnimation = aTransitionAnimation
    }
    
    //work around for enum that can not be used in objective
    var transitionAnimationState:CHTransitionAnimationState = CHTransitionAnimationState.Push
    init(aState:CHTransitionAnimationState){
        self.transitionAnimationState = aState
        
        switch self.transitionAnimationState.value {
        case CHTransitionAnimationState.Push.value:
            self.transitionAnimation = .TransitionAnimationPush
        case CHTransitionAnimationState.Rotate.value:
            self.transitionAnimation = .TransitionAnimationRotate
        default:
            self.transitionAnimation = .TransitionAnimationPush
        }
    }
    
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let container = transitionContext.containerView()
        let fromVC = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)!
        let toVC = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        container.addSubview(toVC.view)
        container.addSubview(fromVC.view)
        
        let duration = self.transitionDuration(transitionContext)
        
        switch transitionAnimation{
        case .TransitionAnimationPush:
            let offScreenRight = CGAffineTransformMakeTranslation(container.frame.width, 0)
            let offScreenLeft = CGAffineTransformMakeTranslation(-container.frame.width, 0)
            toVC.view.transform = self.presenting ? offScreenRight:offScreenLeft
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: nil, animations: {
                fromVC.view.transform = self.presenting ? offScreenLeft : offScreenRight
                toVC.view.transform = CGAffineTransformIdentity
                }, completion: { finished in
                    transitionContext.completeTransition(true)
            })
            
        case .TransitionAnimationRotate:
            let π: CGFloat = 3.1415926359
            let offScreenRotateIn = CGAffineTransformMakeRotation(-π/2)
            let offScreenRotateOut = CGAffineTransformMakeRotation(π/2)
            toVC.view.transform = self.presenting ? offScreenRotateIn:offScreenRotateOut
            toVC.view.layer.anchorPoint = CGPointZero
            toVC.view.layer.position = CGPointZero
            
            fromVC.view.layer.anchorPoint = CGPointZero
            fromVC.view.layer.position = CGPointZero
            
            UIView.animateWithDuration(duration, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.8, options: nil, animations: {
                fromVC.view.transform = self.presenting ? offScreenRotateOut : offScreenRotateIn
                toVC.view.transform = CGAffineTransformIdentity
                }, completion: { finished in
                    transitionContext.completeTransition(true)
            })
        }
        
    }
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        return 0.75
    }
    
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    
}
