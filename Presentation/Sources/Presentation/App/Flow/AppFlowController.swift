//
//  AppFlowController.swift
//
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit
import Domain
import RxSwift

public class AppFlowController: FlowController<AppFlowController.Context> {
    
    private var authStateDisposable: Disposable?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        start()
    }
    
    private func start() {
        guard let id = context.authRepository.currentId else {
            return startAuth()
        }
        
        GetUserUseCase(userRepository: context.userRepository).call(with: id)
            .recover { error in
                print(error)
                return nil
            }
            .then { [weak self] user in
                let exist = user != nil
                
                if exist {
                    self?.startMain()
                } else {
                    self?.startAuth()
                }
            }
    }
    
    private func listenAuthState() {
        guard authStateDisposable == nil else { return }
        authStateDisposable = context
            .authRepository
            .idObservable
            .subscribe(onNext: { [unowned self] id in
                if id == nil {
                    if let main = children.first(where: { $0 is HomeFlowController }) {
                        remove(child: main)
                    }
                    
                    startAuth()
                }
            })
    }
    
    private func stopListenAuthState() {
        authStateDisposable?.dispose()
        authStateDisposable = nil
    }
    
    private func startAuth() {
        stopListenAuthState()
        
        let flow = AuthFlowController(
            context: .init(
                authRepository: context.authRepository,
                userRepository: context.userRepository
            )
        )
        flow.delegate = self
        
        add(child: flow)
    }
    
    private func startMain() {
        listenAuthState()
        
        let flow = HomeFlowController(
            context: .init(
                authRepository: context.authRepository
            )
        )
        
        add(child: flow)
    }
    
    deinit {
        authStateDisposable?.dispose()
    }
}

public extension AppFlowController {
    struct Context {
        let authRepository: AuthRepository
        let userRepository: UserRepository
        
        public init(
            authRepository: AuthRepository,
            userRepository: UserRepository
        ) {
            self.authRepository = authRepository
            self.userRepository = userRepository
        }
    }
}

extension AppFlowController: AuthFlowDelegate {
    func authFlowDidFinish(_ flowController: AuthFlowController, with authenticatedUser: User) {
        remove(child: flowController)
        startMain()
    }
}
