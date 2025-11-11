//
//  LaunchDetailViewPresenter.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 11.11.2025.
//

import Foundation

protocol LaunchDetailViewPresenterProtocol {
    var launch: Launch { get set }
    func loading()
    func finished()
    func viewDidLoad()
}

final class LaunchDetailViewPresenter: LaunchDetailViewPresenterProtocol {
    
    var launch: Launch
    let interactor: LaunchDetailViewInteractorProtocol
    let router: LaunchDetailViewRouterProtocol
    let view: LaunchDetailViewProtocol
    
    init(interactor: LaunchDetailViewInteractorProtocol,
         router: LaunchDetailViewRouterProtocol,
         view: LaunchDetailViewProtocol,
         launch: Launch) {
        
        self.interactor = interactor
        self.router = router
        self.view = view
        self.launch = launch
    }
}

extension LaunchDetailViewPresenter {

    func viewDidLoad() {
        view.configureDetailView(launch: launch)
    }
    
    func loading() {
        view.loading()
    }
    
    func finished() {
        view.finished()
    }
}
