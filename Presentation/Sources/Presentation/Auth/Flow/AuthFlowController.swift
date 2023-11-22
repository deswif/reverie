//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit

class AuthFlowController: FlowController<AuthFlowController.Dependencies> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEmbeddedNavigation()
        
        start()
    }
    
    private func start() {
        let controller = makeSignInController()
        
        embeddedNavigation?.setViewControllers([controller], animated: false)
    }
    
    private func makeSignInController() -> SignInViewController {
        let controller = SignInViewController()
        
        return controller
    }
}

extension AuthFlowController {
    struct Dependencies {
        
    }
}
