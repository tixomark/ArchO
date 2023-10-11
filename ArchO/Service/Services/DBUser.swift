//
//  DBUser.swift
//  ArchO
//
//  Created by Tixon Markin on 01.09.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct DBUser: Codable {
    var id: String
    var isEmailVerified: Bool
    var isAnonymous: Bool
    var photoUrl: URL?
    var creationDate: Timestamp
    var contactData: DBUserContactData?

    enum CodingKeys: String, CodingKey {
        case id, isEmailVerified, isAnonymous, photoUrl, creationDate
    }
    
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.id = try container.decode(String.self, forKey: .id)
//        self.isEmailVerified = try container.decode(Bool.self, forKey: .isEmailVerified)
//        self.isAnonymous = try container.decode(Bool.self, forKey: .isAnonymous)
//        self.photoUrl = try container.decodeIfPresent(URL.self, forKey: .photoUrl)
//        self.creationDate = try container.decode(Timestamp.self, forKey: .creationDate)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(self.id, forKey: .id)
//        try container.encode(self.isEmailVerified, forKey: .isEmailVerified)
//        try container.encode(self.isAnonymous, forKey: .isAnonymous)
//        try container.encodeIfPresent(self.photoUrl, forKey: .photoUrl)
//        try container.encode(self.creationDate, forKey: .creationDate)
//    }
    
}

extension DBUser {
    init(FBUser usr: FirebaseAuth.User) {
        contactData = DBUserContactData(name: usr.displayName, email: usr.email)
        id = usr.uid
        isEmailVerified = usr.isEmailVerified
        isAnonymous = usr.isAnonymous
        photoUrl = usr.photoURL
        creationDate = Timestamp()
    }
}

struct DBUserContactData: Codable, Equatable {
    var name: DBUserContactField? //= DBUserContactField()
    var lastName: DBUserContactField? //= DBUserContactField()
    var phoneNumber: DBUserContactField? //= DBUserContactField()
    var email: DBUserContactField? //= DBUserContactField()
    var country: DBUserContactField? //= DBUserContactField()
    var city: DBUserContactField? //= DBUserContactField()
    
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
    
//    init() {
//        self.value = nil
//        self.isSelected = nil
//    }
    
    init(value: String? = "", isSelected: Bool? = false) {
        self.value = value
        self.isSelected = isSelected
    }
}

