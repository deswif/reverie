//
//  AppFlowController.swift
//
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit
import Domain

public class AppFlowController: FlowController<AppFlowController.Context> {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        startAuth()
    }
    
    private func startAuth() {
        let flow = AuthFlowController(
            context: .init(
                authRepository: context.authRepository
            )
        )
        
        add(child: flow)
    }
}

public extension AppFlowController {
    struct Context {
        let authRepository: AuthRepository
        
        public init(
            authRepository: AuthRepository
        ) {
            self.authRepository = authRepository
        }
    }
}
