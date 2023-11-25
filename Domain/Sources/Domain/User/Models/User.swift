//
//  File.swift
//  
//
//  Created by Max Steshkin on 23.11.2023.
//

import Foundation

public struct User {
    public let id: String
    public let name: String
    public let username: String
    
    public init(id: String, name: String, username: String) {
        self.id = id
        self.name = name
        self.username = username
    }
}
