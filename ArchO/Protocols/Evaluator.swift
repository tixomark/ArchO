//
//  Evaluator.swift
//  ArchO
//
//  Created by Tixon Markin on 26.07.2023.
//

import Foundation

struct Evaluator {
    static let emailRegEx = try! NSRegularExpression(pattern: ##"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,10}"##, options: .caseInsensitive)
    static let passwordRegEx = try! NSRegularExpression(pattern: ##"[a-zA-Z0-9!"#$%&'()*+,-./:;<=>?@\[\]^_`{|}~]{8,32}"##, options: .caseInsensitive)
    
    func isValidEmail(_ email: String) -> Bool {
        let range = NSRange(location: 0, length: email.count)
        return Evaluator.emailRegEx.firstMatch(in: email, options: [], range: range) != nil
    }
    
    func isValidPassword(_ password: String) -> Bool {
        let range = NSRange(location: 0, length: password.count)
        return Evaluator.passwordRegEx.firstMatch(in: password, options: [], range: range) != nil
    }
}
