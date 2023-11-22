//
//  ViewController.swift
//  Reverie
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 15.0, *) {
            view.backgroundColor = .systemMint
        }
    }


}

