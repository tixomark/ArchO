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
    
    func signInUsing(email: String,
                     password: String,
                     authResult: @escaping (Error?) -> ())  {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            guard error == nil else {
                print(error!.localizedDescription)
                authResult(error)
                return
            }
            authResult(error)
        }
    }
    
    
}
