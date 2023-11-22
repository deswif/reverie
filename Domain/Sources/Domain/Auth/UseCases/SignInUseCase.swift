//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import Foundation

public class SignInUseCase {
    
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func call(completion: @escaping (Result<String, Error>) -> Void) {
        authRepository.signIn(completion: completion)
    }
    
}
