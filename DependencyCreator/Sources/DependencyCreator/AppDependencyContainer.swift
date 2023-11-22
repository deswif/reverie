import Domain

public class AppDependencyContainer {
    public let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
}
