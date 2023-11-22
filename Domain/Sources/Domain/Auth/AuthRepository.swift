//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import Foundation

public protocol AuthRepository {
    func signIn(completion: @escaping (Result<String, Error>) -> Void)
}
