//
//  File.swift
//  
//
//  Created by Max Steshkin on 24.11.2023.
//

import Promises

public protocol UserRemoteDataSource {
    func read(with id: String) -> Promise<UserRemoteResponse?>
    
    func create(with blank: UserRemoteCreateBlank) -> Promise<UserRemoteResponse>
}
