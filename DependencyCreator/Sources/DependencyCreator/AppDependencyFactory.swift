//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import Data

public class AppDependencyFactory {
    private init() {}
    
    public static func createProd() -> AppDependencyContainer {
        AppDependencyContainer(
            authRepository: CommonAuthRepository()
        )
    }
    
    public static func createDev() -> AppDependencyContainer {
        AppDependencyContainer(
            authRepository: CommonAuthRepository()
        )
    }
}
