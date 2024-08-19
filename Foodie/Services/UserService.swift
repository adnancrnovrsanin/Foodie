//
//  UserService.swift
//  Foodie
//
//  Created by Muhedin Alic on 06.08.24.
//

import Firebase

struct UserService {
    static func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        COLLECTION_USERS.document(uid).getDocument { snapshot, _ in
            guard let snapshot = snapshot else { return }
            guard let user = try? snapshot.data(as: User.self) else {
                print("DEBUG: Failed to decode user")
                return
            }
            
            completion(user)
        }
    }
    
    static func fetchUserNullable(withUid uid: String) -> User? {
        var dbUser: User? = nil
        COLLECTION_USERS.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to get the user")
                return
            }
            
            guard let snapshot = snapshot, !snapshot.isEmpty else { return }
            
            let user = snapshot.documents.compactMap { try? $0.data(as: User.self) }.first { user in
                return user.id == uid
            }
            
            if user != nil {
                dbUser = user
            }
        }
        
        return dbUser
    }
}
