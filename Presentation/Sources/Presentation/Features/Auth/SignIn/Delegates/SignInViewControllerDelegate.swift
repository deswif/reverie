//
//  File.swift
//  
//
//  Created by Max Steshkin on 23.11.2023.
//

import Domain

protocol SignInViewControllerDelegate {
    func didAuthenticated(with user: User?)
}
