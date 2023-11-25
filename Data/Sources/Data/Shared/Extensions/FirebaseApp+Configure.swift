//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import FirebaseCore

extension FirebaseApp {
    static func configureIfNot() {
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
    }
}
