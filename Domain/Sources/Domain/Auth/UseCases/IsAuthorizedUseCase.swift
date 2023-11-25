//
//  File.swift
//  
//
//  Created by Max Steshkin on 24.11.2023.
//

import Foundation

public class IsAuthorizedUseCase {
    
    private let authRepository: AuthRepository
    
    public init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    public func call() -> Bool {
        authRepository.currentId != nil
    }
}
