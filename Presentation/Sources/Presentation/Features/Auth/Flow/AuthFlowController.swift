//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit
import Domain
import Promises

class AuthFlowController: FlowController<AuthFlowController.Context> {
    
    var delegate: AuthFlowDelegate?
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setEmbeddedNavigation()
        
        start()
    }
    
    private func start() {
        
        let isAuthorized = IsAuthorizedUseCase(authRepository: context.authRepository).call()
        
        if isAuthorized {
            
            CreateUserUseCase(authRepository: context.authRepository, userRepository: context.userRepository)
                .call(name: "Max", username: "swif")
                .then { [weak self] user in
                    guard let self else { return }
                    currentUser = user
                    delegate?.authFlowDidFinish(self, with: user)
                }
                .catch { error in
                    print("create error \(error)")
                }
            
            let controller = makeSignInController()
            
            embeddedNavigation?.setViewControllers([controller], animated: false)
        } else {
            let controller = makeSignInController()
            
            embeddedNavigation?.setViewControllers([controller], animated: false)
        }
    }
    
    private func makeSignInController() -> SignInViewController {
        let controller = SignInViewController()
        let presenter = SignInPresenter(
            signInUseCase: SignInUseCase(
                authRepository: context.authRepository,
                userRepository: context.userRepository
            )
        )
        controller.presenter = presenter
        controller.delegate = self
        
        return controller
    }
}

extension AuthFlowController {
    struct Context {
        let authRepository: AuthRepository
        let userRepository: UserRepository
        
        init(
            authRepository: AuthRepository,
            userRepository: UserRepository
        ) {
            self.authRepository = authRepository
            self.userRepository = userRepository
        }
    }
}

extension AuthFlowController: SignInViewControllerDelegate {
    func didAuthenticated(with user: User?) {
        if let user = user {
            print("welcome back")
            self.currentUser = user
            delegate?.authFlowDidFinish(self, with: user)
        } else {
            print("reg")
            CreateUserUseCase(authRepository: context.authRepository, userRepository: context.userRepository)
                .call(name: "Max", username: "swif")
                .then { [weak self] user in
                    guard let self else { return }
                    currentUser = user
                    delegate?.authFlowDidFinish(self, with: user)
                }
                .catch { error in
                    print("create error \(error)")
                }
        }
    }
}
