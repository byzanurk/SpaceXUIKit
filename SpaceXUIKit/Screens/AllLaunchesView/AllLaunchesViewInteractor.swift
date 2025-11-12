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
    func searchLaunches(query: String)
    func sortLaunches(by option: Int)
}

final class AllLaunchesViewInteractor {
    
    var presenter: AllLaunchesViewPresenterProtocol?
    private var service: LaunchServiceable
    private var cachedLaunches: [Launch] = []
    
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
                self.cachedLaunches = launches
                self.presenter?.handleLaunches(launches: launches)
            case .failure(let error):
                self.presenter?.handleError(error: error.customMessage)
            }
        }
    }
    
    func searchLaunches(query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            presenter?.handleLaunches(launches: cachedLaunches)
            return
        }
        
        let lowercased = trimmed.lowercased()
        let filtered = cachedLaunches.filter { launch in
            let nameMatch = (launch.name ?? "").lowercased().contains(lowercased)
            return nameMatch
        }
        presenter?.handleLaunches(launches: filtered)
    }
        
    func sortLaunches(by option: Int) {
        switch sortOption(forRow: option) {
        case .nameAsc:
            cachedLaunches.sort { $0.name ?? "" < $1.name ?? "" }
            presenter?.handleLaunches(launches: cachedLaunches)
        case .nameDsc:
            cachedLaunches.sort { $0.name ?? "" > $1.name ?? "" }
            presenter?.handleLaunches(launches: cachedLaunches)
        case .dateAsc:
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            cachedLaunches.sort(by: {
                guard
                    let firstDate = dateFormatter.date(from: $0.dateUTC),
                    let secondDate = dateFormatter.date(from: $1.dateUTC)
                else { return false }
                return firstDate < secondDate
            })
            presenter?.handleLaunches(launches: cachedLaunches)
        case .dateDsc:
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US_POSIX")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            
            cachedLaunches.sort(by: {
                guard
                    let firstDate = dateFormatter.date(from: $0.dateUTC),
                    let secondDate = dateFormatter.date(from: $1.dateUTC)
                else { return false }
                return firstDate > secondDate
            })
            presenter?.handleLaunches(launches: cachedLaunches)
        }
    }
    
    func sortOption(forRow row: Int) -> SortOption {
        switch row {
        case 0: return .dateAsc
        case 1: return .dateDsc
        case 2: return .nameAsc
        case 3: return .nameDsc
        default: return .dateAsc
        }
    }
}

