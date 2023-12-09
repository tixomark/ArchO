//
//  EnumExtensions.swift
//  ArchO
//
//  Created by Tixon Markin on 07.12.2023.
//

import Foundation
enum EnumEncodingError: Error {
    case canNotFindMatchFor(_ value: String)
}

extension TypologicalAffilation: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        var value: String?
        switch self {
        case .archeologyMonument: value = "archeologyMonument"
        case .historyMonument: value = "historyMonument"
        case .architectureAndArtMonument: value = "architectureAndArtMonument"
        case .monumentalArtMonument: value = "monumentalArtMonument"
        }
        try container.encode(value)
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.singleValueContainer()
        let decodedValue = try container.decode(String.self)
        var value: TypologicalAffilation?
        switch decodedValue {
        case "archeologyMonument": value = .archeologyMonument
        case "historyMonument": value = .historyMonument
        case "architectureAndArtMonument": value = .architectureAndArtMonument
        case "monumentalArtMonument": value = .monumentalArtMonument
        default:
            print("No maches found")
        }
        guard let value else {
            throw EnumEncodingError.canNotFindMatchFor(decodedValue)
        }
        self = value
    }
}

extension ProtectedStatusOKN: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        var value: String?
        switch self {
        case .federalSignificance: value = "federalSignificance"
        case .regionalSignificance: value = "regionalSignificance"
        case .local: value = "local"
        case .noProtectedStatus: value = "noProtectedStatus"
        case .dontKnow: value = "dontKnow"
        }
        try container.encode(value)
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.singleValueContainer()
        let decodedValue = try container.decode(String.self)
        var value: ProtectedStatusOKN?
        switch decodedValue {
        case "federalSignificance": value = .federalSignificance
        case "regionalSignificance": value = .regionalSignificance
        case "local": value = .local
        case "noProtectedStatus": value = .noProtectedStatus
        case "dontKnow": value = .dontKnow
        default:
            print("No maches found")
        }
        guard let value else {
            throw EnumEncodingError.canNotFindMatchFor(decodedValue)
        }
        self = value
    }
}

extension TecnicalCondition: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        var value: String?
        switch self {
        case .good: value = "good"
        case .average: value = "average"
        case .bad: value = "bad"
        case .emergency: value = "emergency"
        case .ruined: value = "ruined"
        }
        try container.encode(value)
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.singleValueContainer()
        let decodedValue = try container.decode(String.self)
        var value: TecnicalCondition?
        switch decodedValue {
        case "good": value = .good
        case "average": value = .average
        case "bad": value = .bad
        case "emergency": value = .emergency
        case "ruined": value = .ruined
        default:
            print("No maches found")
        }
        guard let value else {
            throw EnumEncodingError.canNotFindMatchFor(decodedValue)
        }
        self = value
    }
}

extension StageOfWork: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        var value: String?
        switch self {
        case .notExecuted: value = "notExecuted"
        case .executing: value = "executing"
        case .executed: value = "executed"
        }
        try container.encode(value)
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.singleValueContainer()
        let decodedValue = try container.decode(String.self)
        var value: StageOfWork?
        switch decodedValue {
        case "notExecuted": value = .notExecuted
        case "executing": value = .executing
        case "executed": value = .executed
        default:
            print("No maches found")
        }
        guard let value else {
            throw EnumEncodingError.canNotFindMatchFor(decodedValue)
        }
        self = value
    }
}

extension PhotoFixationKind: Codable {
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        var value: String?
        switch self {
        case .protocolDocumentary:  value = "protocolDocumentary"
        case .artictic:  value = "artictic"
        }
        try container.encode(value)
    }
    
    init(from decoder: Decoder) throws {
        var container = try decoder.singleValueContainer()
        let decodedValue = try container.decode(String.self)
        var value: PhotoFixationKind?
        switch decodedValue {
        case "protocolDocumentary": value = .protocolDocumentary
        case "artictic": value = .artictic
        default:
            print("No maches found")
        }
        guard let value else {
            throw EnumEncodingError.canNotFindMatchFor(decodedValue)
        }
        self = value
    }
}
