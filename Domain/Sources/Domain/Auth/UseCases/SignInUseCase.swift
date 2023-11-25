//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import Foundation
import Promises

public class SignInUseCase {
    
    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    
    public init(
        authRepository: AuthRepository,
        userRepository: UserRepository
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }
    
    public func call() -> Promise<User?> {
        authRepository
            .signIn()
            .then(self.userRepository.readUser(with:))
    }
}
