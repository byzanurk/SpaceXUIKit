//
//  SpaceXModel.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

struct SpaceXResponseModel: Codable {
    let launches: [Launch]?
}

struct Launch: Codable {
    let links: Links
    let details: String?
    let name: String?
    let dateUTC: String
    
    enum CodingKeys: String, CodingKey {
        case links, details, name
        case dateUTC = "date_utc"
    }
}

struct Links:Codable {
    let patch: Patch?
    let article, wikipedia: String?
}

struct Patch: Codable {
    let small, large: String?
}
