//
//  UserManager.swift
//  ArchO
//
//  Created by Tixon Markin on 23.08.2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

protocol DBUserDataManagerProtocol {
    func setData(forUser user: DBUser)
    func getData(forUser uid: String)
}

protocol DBUserContactDataManagerProtocol {
    func setContactData(_ data: DBUserContactData, forUser uid: String)
    func getContactData(forUser uid: String, completion: @escaping  (DBUserContactData) -> ())
    func updateContactData(_ data: DBUserContactData, forUser uid: String)
}

protocol DBUserManagerProtocol: DBUserDataManagerProtocol, DBUserContactDataManagerProtocol {
}

class DBUserManager: DBUserManagerProtocol, ServiceProtocol {
    var description: String = "DBUserManager"
    private var db: Firestore { Firestore.firestore() }
    private lazy var usersRef = db.collection("users")
    private lazy var usersContactRef = db.collection("users_contact_data")
    
    private func userDocument(uid: String) -> DocumentReference {
        usersRef.document(uid)
    }
    private func userContactDocument(uid: String) -> DocumentReference {
        usersContactRef.document(uid)
    }
    
    private var userEncoder: Firestore.Encoder {
        let encoder = Firestore.Encoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }
    
    private var userDecoder: Firestore.Decoder {
        let decoder = Firestore.Decoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
}

// MARK: - DBUserDataManagerProtocol methods
extension DBUserManager {
    func setData(forUser user: DBUser) {
        do {
            try userDocument(uid: user.id).setData(from: user, merge: true, encoder: userEncoder) { error in
                print(error?.localizedDescription ?? "")
            }
            if let data = user.contactData {
                setContactData(data, forUser: user.id)
            }
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func updateData(forUser user: DBUser) {
        
    }
    func getData(forUser uid: String) {
//        userDocument(uid: uid).getDocument { snapshot, errorr in
//            guard let snapshot = snapshot else { return }
//            do {
//                try self.userDecoder.decode(DBUser.self, from: snapshot)
//                
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
    }
}

// MARK: - DBUserContactDataManagerProtocol methods
extension DBUserManager {
    func setContactData(_ data: DBUserContactData, 
                        forUser uid: String) {
        do {
            try userContactDocument(uid: uid).setData(from: data, merge: true, encoder: userEncoder) { error in
                print(error?.localizedDescription ?? "")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getContactData(forUser uid: String, 
                        completion: @escaping  (DBUserContactData) -> ()) {
        userContactDocument(uid: uid).getDocument { snapshot, error in
            do {
                let userContactData = try snapshot?.data(as: DBUserContactData.self, decoder: self.userDecoder)
                completion(userContactData!)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func updateContactData(_ data: DBUserContactData, 
                           forUser uid: String) {
        do {
            let fields = try userEncoder.encode(data)
            userContactDocument(uid: uid).updateData(fields)
        } catch {
            print(error.localizedDescription)
        }
    }
}
