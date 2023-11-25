//
//  File.swift
//  
//
//  Created by Max Steshkin on 24.11.2023.
//

import Foundation
import Promises

public protocol UserRepository {
    
    func readUser(with id: String) -> Promise<User?>
    
    func create(id: String, name: String, username: String) -> Promise<User>
    
}
