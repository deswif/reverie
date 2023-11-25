//
//  File.swift
//
//
//  Created by Max Steshkin on 24.11.2023.
//

import Foundation
import Domain

class UserMapper {
    static func from(response: UserRemoteResponse) -> User {
        User(
            id: response.id,
            name: response.name,
            username: response.username
        )
    }
}
