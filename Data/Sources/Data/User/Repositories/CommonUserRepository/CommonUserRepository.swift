//
//  File.swift
//  
//
//  Created by Max Steshkin on 24.11.2023.
//

import Domain
import Foundation
import Promises

public class CommonUserRepository: UserRepository {
    
    private let userQueue = DispatchQueue(label: "me.reverie.music-common_user_repository", qos: .userInitiated, attributes: .concurrent)
    
    private let remoteDataSource: UserRemoteDataSource
    
    public init(remoteDataSource: UserRemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func readUser(with id: String) -> Promise<User?> {
        Promise<User?>(on: userQueue) {
            
            self.remoteDataSource.read(with: id)
                .then { response -> User? in
                    guard let response else { return nil }
                    return UserMapper.from(response: response)
                }
        }
    }
    
    public func create(id: String, name: String, username: String) -> Promise<User> {
        Promise<User>(on: userQueue) {
            
            self.remoteDataSource.create(with: UserRemoteCreateBlank(id: id, name: name, username: username))
                .then(UserMapper.from(response:))
        }
    }
}

