//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import Domain
import Foundation

protocol SignInViewDelegate: NSObjectProtocol {}

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
        signInUseCase.call { result in
            switch result {
            case .success(let id):
                print(id)
            case .failure(let failure):
                print(failure)
            }
        }
    }
}

