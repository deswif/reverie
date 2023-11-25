//
//  File.swift
//  
//
//  Created by Max Steshkin on 23.11.2023.
//

import Foundation
import Domain

protocol AuthFlowDelegate {
    func authFlowDidFinish(_ flowController: AuthFlowController, with authenticatedUser: User)
}
