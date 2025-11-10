//
//  LaunchServiceable.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

protocol LaunchServiceable {
    func fetchLaunches() async -> Result<[Launch], RequestError>
}

struct LaunchService: LaunchServiceable {
    
    private let service: HttpClientProtocol
    
    init(service: HttpClientProtocol) {
        self.service = service
    }
    
    func fetchLaunches() async -> Result<[Launch], RequestError> {
        return await service.request(endpoint: LaunchEnpoint(),
                                     responseModel: [Launch].self)
    }
}
