//
//  FBAuth.swift
//  ArchO
//
//  Created by Tixon Markin on 30.06.2023.
//

import Foundation
import Firebase

protocol FBAuthProtocol {
    var user: Firebase.User? {get}
    var isUserAuthed: Bool {get}
    var curentUserID: String? {get}
    var authState: UserAuthState {get}
    
    func signInUsing(email: String, password: String, authResult: @escaping (Error?) -> ())
    func signUpUsing(email: String, password: String, authResult: @escaping (Result<User, Error>) -> ())
    func signOut() -> Bool
    func addAuthListener(for listenerOwner: AnyObject, completion: @escaping (Auth, User) -> ())
    func removeAuthListener(from listenerOwner: AnyObject)
}

enum UserAuthState {
    case noUser, userSignedIn
}

class FBAuth: FBAuthProtocol, ServiceProtocol {
    var description: String = "FBAuth"
    var user: User? {
        Auth.auth().currentUser
    }
    var isUserAuthed: Bool {
        user != nil
    }
    var curentUserID: String? {
        return user?.uid
    }
    var authState: UserAuthState {
        isUserAuthed ? .userSignedIn : .noUser
    }
    
    private var authListeners: [String: AuthStateDidChangeListenerHandle] = [:]
    
    func signInUsing(email: String,
                     password: String,
                     authResult: @escaping (Error?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            guard error == nil else {
                print(error!.localizedDescription)
                return
            }
            authResult(error)
        }
    }
    
    func signUpUsing(email: String,
                     password: String,
                     authResult: @escaping (Result<User, Error>) -> ())  {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            guard error == nil, let createdUser = result?.user else {
                print(error!.localizedDescription)
                authResult(.failure(error!))
                return
            }
            authResult(.success(createdUser))
        }
    }
    
    func sendEmailVerification(_ completion: @escaping (Error?) -> ()){
        Auth.auth().currentUser?.sendEmailVerification(completion: { (error) in
            completion(error)
        })
    }
    
    func signOut() -> Bool {
        do{
            try Auth.auth().signOut()
            return true
        } catch {
            return false
        }
    }
}

// MARK: - auth state listener logic
extension FBAuth {
    func addAuthListener(for listenerOwner: AnyObject, completion: @escaping (Auth, User) -> ()) {
        let listener = Auth.auth().addStateDidChangeListener { auth, user in
            guard let user = user else { return }
            completion(auth, user)
        }
        authListeners[listenerOwner.description] = listener
    }
    
    func removeAuthListener(from listenerOwner: AnyObject) {
        authListeners.removeValue(forKey: listenerOwner.description)
    }
}

