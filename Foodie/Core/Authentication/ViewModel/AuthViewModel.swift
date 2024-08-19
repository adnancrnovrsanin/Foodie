//
//  AuthViewModel.swift
//  Foodie
//
//  Created by Muhedin Alic on 06.08.24.
//

import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseAuth

class AuthViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    @Published var isAuthenticating = false
    @Published var error: Error?
    @Published var user: User?
        
    init() {
        userSession = Auth.auth().currentUser
        fetchUser()
    }
    
    func signIn(withEmail email: String, password: String) {
        self.isAuthenticating = true
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error: \(error.localizedDescription)")
                self.isAuthenticating = false
                self.error = error
                return
            }
            
            self.isAuthenticating = false
            self.userSession = result?.user
            self.fetchUser()
        }
    }
    
    func createUser(withName name: String, email: String, uid: String) -> User? {
//        print("Collecting location")
//        
//    
//        
//        // Check if userLocation is available
//        guard let userLocation = LocationManager.shared.userLocation else {
//            // Handle the case where user location is not available
//            print("User location not available")
//            self.isAuthenticating = false
//            return nil
//        }
//
//        print("User location latitude:", userLocation.coordinate.latitude)
        
        let user = User(
            id: uid,
            fullname: name,
            email: email,
            coordinates: GeoPoint(latitude: 4.081052,
                                  longitude: 9.776989),
            isActive: false
        )
        
        print("User fullname:", user.fullname)
        return user
    }

    func changeUserPhoneNumber(phoneNumber: String) {
        guard var currentUser = self.user else { return }
        
        currentUser.phoneNumber = phoneNumber
        
        self.uploadUserData(withUid: currentUser.id, user: currentUser)
    }
    
    func registerUser(withEmail email: String, fullname: String, password: String) {
        self.isAuthenticating = true
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error: \(error.localizedDescription)")
                self.isAuthenticating = false
                self.error = error
                return
            }
            
            guard let firebaseUser = result?.user else { return }
            guard let user = self.createUser(withName: fullname, email: email, uid: firebaseUser.uid) else { return }
                    
            self.userSession = firebaseUser
            self.isAuthenticating = false
            self.user = user
            
            print(user)
            
            self.uploadUserData(withUid: firebaseUser.uid, user: user)
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.user = nil
        } catch let error {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    private func uploadUserData(withUid uid: String, user: User) {
        guard let encodedUser = try? Firestore.Encoder().encode(user) else { return }
        
        COLLECTION_USERS.document(uid).setData(encodedUser) { _ in
            self.fetchUser()
        }
    }
    
    func fetchUser() {
        guard let uid = userSession?.uid else { return }
        
        UserService.fetchUser(withUid: uid) { user in
            print("DEBUG: User is \(user)")
            self.user = user
        }
    }
    
    func fetchUserWithId(id: String) -> User? {
        var userLocal: User? = nil
        
        COLLECTION_USERS.getDocuments { snapshot, error in
            if let error = error {
                print("DEBUG: Failed to fetch user's orders \(error.localizedDescription)")
                return
            }
            
            guard let snapshot = snapshot, !snapshot.isEmpty else { return }
            
            userLocal = snapshot.documents.compactMap { try? $0.data(as: User.self) }.first { $0.id == id }
        }
        
        return userLocal
    }
}
