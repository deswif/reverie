//
//  File.swift
//  
//
//  Created by Max Steshkin on 24.11.2023.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseFirestoreSwift
import Promises
import Domain

public class FirebaseUserRemoteDataSource: UserRemoteDataSource {
    public init() {
        FirebaseApp.configureIfNot()
        
        db = Firestore.firestore()
        usersCollection = db.collection("users")
    }
    
    private let db: Firestore
    private let usersCollection: CollectionReference
    
    public func read(with id: String) -> Promise<UserRemoteResponse?> {
        Promise<UserRemoteResponse?> { [self] fulfill, reject in
            usersCollection.document(id).getDocument { doc, error in
                if let error {
                    reject(error)
                    return
                }
                
                guard let doc else {
                    fulfill(nil)
                    return
                }
                
                guard doc.exists else {
                    fulfill(nil)
                    return
                }
                
                do {
                    let response = try UserRemoteResponse.from(doc: doc)
                    fulfill(response)
                } catch (let error) {
                    reject(error)
                }
            }
        }
    }
    
    public func create(with blank: UserRemoteCreateBlank) -> Promise<UserRemoteResponse> {
        Promise<UserRemoteResponse> { [self] fulfill, reject in
            usersCollection.document(blank.id).setData([
                "name": blank.name,
                "username": blank.username
            ]) { error in
                if let error {
                    reject(error)
                    return
                }
                
                let user = UserRemoteResponse(id: blank.id, name: blank.name, username: blank.username)
                fulfill(user)
            }
        }
    }
}

fileprivate extension UserRemoteResponse {
    static func from(doc: DocumentSnapshot) throws -> UserRemoteResponse {
        guard let data = doc.data() else { throw UserMapDocumentError() }
        
        guard
            let name = data["name"] as? String,
            let username = data["username"] as? String
        else { throw UserMapDocumentError() }
        
        return UserRemoteResponse(
            id: doc.documentID,
            name: name,
            username: username
        )
    }
}

fileprivate struct UserMapDocumentError: Error {}
