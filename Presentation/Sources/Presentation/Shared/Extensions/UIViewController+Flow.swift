//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit

extension UIViewController {
    func add(child controller: UIViewController, animated: Bool = true) {
        
        if !animated {
            addChild(controller)
            view.addSubview(controller.view)
            controller.didMove(toParent: self)
            return
        }
        
        addChild(controller)
        view.addSubview(controller.view)
        controller.willMove(toParent: self)
        
        controller.view.alpha = 0
        
        UIView.animate(withDuration: 0.25) {
            controller.view.alpha = 1
        }
    }
    
    func remove(child controller: UIViewController, animated: Bool = true) {
        if !animated {
            controller.willMove(toParent: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParent()
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            controller.view.alpha = 0
        } completion: { _ in
            controller.didMove(toParent: nil)
            controller.view.removeFromSuperview()
            controller.removeFromParent()
        }
    }
}
