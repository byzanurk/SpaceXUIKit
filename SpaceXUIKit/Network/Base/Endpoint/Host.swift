//
//  Host.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

enum Host {
    case defaultHost
    
    var url: String {
        switch self {
        case .defaultHost:
            return "api.spacexdata.com"
        }
    }
}
