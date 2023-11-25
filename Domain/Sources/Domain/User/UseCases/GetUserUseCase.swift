//
//  File.swift
//  
//
//  Created by Max Steshkin on 24.11.2023.
//

import Foundation
import Promises

public class GetUserUseCase {
    
    private let userRepository: UserRepository
    
    public init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    public func call(with id: String) -> Promise<User?> {
        userRepository.readUser(with: id)
    }
}
