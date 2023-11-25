//
//  SignInViewController.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import UIKit
import SnapKit
import Domain

class SignInViewController: UIViewController {
    
    var delegate: SignInViewControllerDelegate?
    
    var presenter: SignInPresenter? {
        didSet {
            presenter?.setViewDelegate(self)
        }
    }
    
    private let button: UIButton = {
        let view = UIButton(type: .system)
        view.setTitle("Sign In", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 21)
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.contentEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        setUpViews()
    }
    
    func setUpViews() {
        view.addSubview(button)
        
        configureSignInButton()
    }
    
    func configureSignInButton() {
        let action = UIAction { [weak self] _ in
            self?.presenter?.signInPressed()
        }
        
        button.addAction(action, for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-90)
            make.width.lessThanOrEqualToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}

extension SignInViewController: SignInViewDelegate {
    func didAuthenticated(with user: User?) {
        delegate?.didAuthenticated(with: user)
    }
}
