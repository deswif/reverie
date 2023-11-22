//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit
import Domain

class AuthFlowController: FlowController<AuthFlowController.Context> {
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
        let presenter = SignInPresenter(
            signInUseCase: SignInUseCase(
                authRepository: context.authRepository
            )
        )
        controller.presenter = presenter
        
        return controller
    }
}

extension AuthFlowController {
    struct Context {
        let authRepository: AuthRepository
        
        init(
            authRepository: AuthRepository
        ) {
            self.authRepository = authRepository
        }
    }
}
