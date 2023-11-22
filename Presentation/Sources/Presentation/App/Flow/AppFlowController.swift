//
//  AppFlowController.swift
//
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit

public class AppFlowController: FlowController<AppFlowController.Dependencies> {
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        startAuth()
    }
    
    private func startAuth() {
        let flow = AuthFlowController(
            dependencies: .init()
        )
        
        add(child: flow)
    }
}

public extension AppFlowController {
    struct Dependencies {
        public init() {
            
        }
    }
}
