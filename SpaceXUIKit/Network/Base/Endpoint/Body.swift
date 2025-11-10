//
//  Body.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

enum Body {
    case nilBody
    
    var body: [String: Any]? {
        switch self {
        case .nilBody:
            return nil
        }
    }
}
