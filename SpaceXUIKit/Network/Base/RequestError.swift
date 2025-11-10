//
//  RequestError.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

public enum RequestError: Error, Equatable {
    case decode
    case invalidURL
    case noResponse
    case unauthorized(code: Int)
    case unexpectedStatusCode
    case unknow(description: String, code: Int?)
    
    public var customMessage: String {
        switch self {
        case .decode:
            return "Decoding error"
        case .invalidURL:
            return "Invalid URL"
        case .noResponse:
            return "Request does not have a response"
        case .unauthorized:
            return "Session expired"
        default:
            return "Unknown error"
        }
    }
    
    public var errorCode: Int? {
        switch self {
        case .decode:
            return nil
        case .invalidURL:
            return nil
        case .noResponse:
            return nil
        case .unauthorized(code: let code):
            return code
        case .unexpectedStatusCode:
            return nil
        case .unknow(description: let description, code: let code):
            return code
        }
    }
}
