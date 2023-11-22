//
//  FlowViewController.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit

public class FlowController<Dependencies>: UIViewController {
    
    var depencencies: Dependencies
    var embeddedNavigation: UINavigationController?

    public init(dependencies: Dependencies) {
        self.depencencies = dependencies
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setEmbeddedNavigation() {
        embeddedNavigation = UINavigationController()
        add(child: embeddedNavigation!)
    }
    
}
