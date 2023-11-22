//
//  FlowViewController.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit

public class FlowController<Context>: UIViewController {
    
    var context: Context
    var embeddedNavigation: UINavigationController?

    public init(context: Context) {
        self.context = context
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
