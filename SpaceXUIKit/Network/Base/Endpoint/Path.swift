//
//  Path.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

enum Path: String {
    case launches
    
    
    var path: String {
        switch self {
        case .launches:
            return "/v4/launches"
        }
    }
}
