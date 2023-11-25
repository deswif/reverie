//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import RxSwift
import Promises

public protocol AuthRepository {
    
    var currentId: String? { get }
    
    var idObservable: Observable<String?> { get }
    
    func signIn() -> Promise<String>
    
    func signOut() -> Promise<Void>
}
