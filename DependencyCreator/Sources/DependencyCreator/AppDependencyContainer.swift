import Domain

public class AppDependencyContainer {
    public let authRepository: AuthRepository
    public let userRepository: UserRepository
    
    init(
        authRepository: AuthRepository,
        userRepository: UserRepository
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
    }
}
