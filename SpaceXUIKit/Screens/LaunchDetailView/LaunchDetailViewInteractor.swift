//
//  LaunchDetailViewInteractor.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 11.11.2025.
//

import Foundation

protocol LaunchDetailViewInteractorProtocol {
    var presenter: LaunchDetailViewPresenterProtocol? { get set }
}

final class LaunchDetailViewInteractor: LaunchDetailViewInteractorProtocol {
    
    var presenter: LaunchDetailViewPresenterProtocol?
    private var service: LaunchServiceable
    
    init(httpClient: HttpClientProtocol) {
        self.service = LaunchService(service: httpClient)
    }
    
}
