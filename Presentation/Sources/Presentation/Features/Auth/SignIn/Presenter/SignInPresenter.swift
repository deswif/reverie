//
//  File.swift
//
//
//  Created by Max Steshkin on 22.11.2023.
//

import Domain
import Foundation

protocol SignInViewDelegate: NSObjectProtocol {
    
    func didAuthenticated(with user: User?)
}

class SignInPresenter {
    private let signInUseCase: SignInUseCase
    
    weak private var signInViewDelegate: SignInViewDelegate?
    
    init(signInUseCase: SignInUseCase) {
        self.signInUseCase = signInUseCase
    }
    
    func setViewDelegate(_ delegate: SignInViewDelegate) {
        self.signInViewDelegate = delegate
    }
    
    func signInPressed() {
        signInUseCase.call()
            .then(on: DispatchQueue.main) { [weak self] user in
                self?.signInViewDelegate?.didAuthenticated(with: user)
            }
            .catch { error in
                print(error)
            }
    }
}

