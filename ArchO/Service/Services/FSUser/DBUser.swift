//
//  DBUser.swift
//  ArchO
//
//  Created by Tixon Markin on 01.09.2023.
//

import Foundation
import Firebase
import FirebaseAuth

struct DBUser: Codable {
    var id: String
    var isEmailVerified: Bool
    var isAnonymous: Bool
    var photoUrl: URL?
    var creationDate: Timestamp
    var contactData: DBUserContactData?
    var userCards: [String]?

    enum CodingKeys: String, CodingKey {
        case id, isEmailVerified, isAnonymous, photoUrl, creationDate, userCards
    }
}

extension DBUser {
    init(FBUser usr: Firebase.User) {
        contactData = DBUserContactData(name: usr.displayName, email: usr.email)
        id = usr.uid
        isEmailVerified = usr.isEmailVerified
        isAnonymous = usr.isAnonymous
        photoUrl = usr.photoURL
        creationDate = Timestamp()
    }
}

struct DBUserContactData: Codable, Equatable {
    var name: DBUserContactField?
    var lastName: DBUserContactField?
    var phoneNumber: DBUserContactField?
    var email: DBUserContactField?
    var country: DBUserContactField?
    var city: DBUserContactField?
    
}

extension DBUserContactData {
    init(name: String?, email: String?) {
        self.name = DBUserContactField(value: name, isSelected: true)
        self.lastName = DBUserContactField()
        self.phoneNumber = DBUserContactField()
        self.email = DBUserContactField(value: email, isSelected: true)
        self.country = DBUserContactField()
        self.city = DBUserContactField()
    }
}

struct DBUserContactField: Codable, Equatable {
    var value: String?
    var isSelected: Bool?

    init(value: String? = "", isSelected: Bool? = false) {
        self.value = value
        self.isSelected = isSelected
    }
}

