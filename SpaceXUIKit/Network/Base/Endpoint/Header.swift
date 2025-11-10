//
//  Header.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

enum Header {
    case defaultHeader
    
    var header: [String: String]? {
        switch self {
        case .defaultHeader:
            return nil
        }
    }
}
