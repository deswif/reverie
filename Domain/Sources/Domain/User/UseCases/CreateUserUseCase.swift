//
//  File.swift
//  
//
//  Created by Max Steshkin on 24.11.2023.
//

import Promises
import Foundation

public class CreateUserUseCase {
    
    private let authRepository: AuthRepository
    private let userRepository: UserRepository
    
    public init(authRepository: AuthRepository, userRepository: UserRepository) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }
    
    public func call(name: String, username: String) -> Promise<User> {
        guard let id = authRepository.currentId else {
            let promise = Promise<User>()
            promise.reject(NSError(domain: "current user is nil", code: 0))
            return promise
        }
        
        return userRepository.create(id: id, name: name, username: username)
    }
    
}
