//
//  File.swift
//  
//
//  Created by Max Steshkin on 23.11.2023.
//

import UIKit
import Domain

class HomeFlowController: FlowController<HomeFlowController.Context> {
    private let button: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("log out", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 21)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .darkGray 
        
        setUpViews()
    }
    
    func setUpViews() {
        view.addSubview(button)
        
        configureSignInButton()
    }
    
    func configureSignInButton() {
        let action = UIAction { [weak self] _ in
            self?.context.authRepository.signOut().then { _ in
                print("log out success")
            }
        }
        
        button.addAction(action, for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-90)
            make.width.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

extension HomeFlowController {
    struct Context {
        let authRepository: AuthRepository
    }
}
