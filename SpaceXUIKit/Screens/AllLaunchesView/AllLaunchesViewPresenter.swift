//
//  AllLaunchesViewPresenter.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

protocol AllLaunchesViewPresenterProtocol {
    var allLaunches: [Launch]? { get set }
    func loading()
    func finished()
    func handleError(error: String)
    func handleLaunches(launches: [Launch])
    func fetchLaunches()
    func goToDetail(launch: Launch)
}

final class AllLaunchesViewPresenter: AllLaunchesViewPresenterProtocol {

        
    var allLaunches: [Launch]?

    let interactor: AllLaunchesViewInteractorProtocol
    let router: AllLaunchesViewRouterProtocol
    let view: AllLaunchesViewProtocol
    
    init(interactor: AllLaunchesViewInteractorProtocol,
         view: AllLaunchesViewProtocol,
         router: AllLaunchesViewRouterProtocol) {
        
        self.interactor = interactor
        self.view = view
        self.router = router
    }
}

extension AllLaunchesViewPresenter {
        
    func fetchLaunches() {
        interactor.fetchLaunches()
    }
    
    func loading() {
        view.loading()
    }
    
    func finished() {
        view.finished()
    }
    
    func handleError(error: String) {
        view.errorOutput(error)
    }
    
    func handleLaunches(launches: [Launch]) {
        self.allLaunches = launches
        view.launchesOutput()
    }
    
    func goToDetail(launch: Launch) {
        let vc = LaunchDetailViewBuilder.build(coordinator: router.coordinator, launch: launch)
        self.router.navigate(viewController: vc)
    }
}
