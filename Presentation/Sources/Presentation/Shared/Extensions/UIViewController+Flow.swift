//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit

extension UIViewController {
    func add(child controller: UIViewController) {
        addChild(controller)
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    func remove(child controller: UIViewController) {
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent()
    }
}
