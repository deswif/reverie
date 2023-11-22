//
//  File.swift
//  
//
//  Created by Max Steshkin on 22.11.2023.
//

import Domain
import CryptoKit
import AuthenticationServices
import FirebaseCore
import FirebaseAuth

public class CommonAuthRepository: AuthRepository {
    
    public init() {
        FirebaseApp.configureIfNot()
    }
    
    private var currentNonce: String?
    
    private let delegate = AppleSignInDelegate()
    
    public func signIn(completion: @escaping (Result<String, Error>) -> Void) {
        
        let nonce = randomNonceString()
        currentNonce = nonce
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        request.nonce = sha256(nonce)
        
        delegate.completion = completion
        delegate.currentNonce = currentNonce
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = delegate
        authorizationController.performRequests()
    }
}

fileprivate extension CommonAuthRepository {
    func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        var randomBytes = [UInt8](repeating: 0, count: length)
        let errorCode = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        if errorCode != errSecSuccess {
            fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
        }
        
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        
        let nonce = randomBytes.map { byte in
            // Pick a random character from the set, wrapping around if needed.
            charset[Int(byte) % charset.count]
        }
        
        return String(nonce)
    }
    
    func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

fileprivate class AppleSignInDelegate: NSObject, ASAuthorizationControllerDelegate {
    fileprivate var completion: ((Result<String, Error>) -> Void)?
    fileprivate var currentNonce: String?
    
    fileprivate func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let nonce = currentNonce else {
                print("Invalid state: A login callback was received, but no login request was sent.")
                
                completion?(.failure(ASAuthorizationError(.failed)))
                return
            }
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                
                completion?(.failure(ASAuthorizationError(.failed)))
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
                
                completion?(.failure(ASAuthorizationError(.failed)))
                return
            }
            
            let credential = OAuthProvider.appleCredential(
                withIDToken: idTokenString,
                rawNonce: nonce,
                fullName: appleIDCredential.fullName
            )
            
            Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
                if let error = error {
                    
                    print(error.localizedDescription)
                    self?.completion?(.failure(error))
                    
                    return
                }
                
                if let authResult = authResult {
                    self?.completion?(.success(authResult.user.uid))
                }
            }
        }
    }
    
    fileprivate func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        completion?(.failure(error))
    }
}
