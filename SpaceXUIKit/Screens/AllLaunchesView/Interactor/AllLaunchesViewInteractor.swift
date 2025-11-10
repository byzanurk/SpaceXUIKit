//
//  AllLaunchesViewInteractor.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

protocol AllLaunchesViewInteractorProtocol {
    var presenter: AllLaunchesViewPresenterProtocol? { get set }
    func fetchLaunches()
}

final class AllLaunchesViewInteractor {
    
    var presenter: AllLaunchesViewPresenterProtocol?
    private var service: LaunchServiceable
    
    init(httpClient: HttpClientProtocol) {
        self.service = LaunchService(service: httpClient)
    }
}

extension AllLaunchesViewInteractor: AllLaunchesViewInteractorProtocol {
    
    func fetchLaunches() {
        self.presenter?.loading()
        
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.fetchLaunches()
            self.presenter?.finished()
            
            switch result {
            case .success(let launches):
                self.presenter?.handleLaunches(launches: launches)
            case .failure(let error):
                self.presenter?.handleError(error: error.customMessage)
            }
        }
    }
    
}
