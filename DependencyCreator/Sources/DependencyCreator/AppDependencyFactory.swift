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
        let userRemoteDataSource: UserRemoteDataSource = FirebaseUserRemoteDataSource()
        
        return AppDependencyContainer(
            authRepository: CommonAuthRepository(),
            userRepository: CommonUserRepository(remoteDataSource: userRemoteDataSource)
        )
    }
    
    public static func createDev() -> AppDependencyContainer {
        let userRemoteDataSource: UserRemoteDataSource = FirebaseUserRemoteDataSource()
        
        return AppDependencyContainer(
            authRepository: CommonAuthRepository(),
            userRepository: CommonUserRepository(remoteDataSource: userRemoteDataSource)
        )
    }
}
