//
//  AllLaunchesViewPresenter.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

protocol AllLaunchesViewPresenterProtocol {
    func loading()
    func finished()
    func handleError(error: String)
    func handleLaunches(launches: [Launch])
    func fetchLaunches()
}

final class AllLaunchesViewPresenter {
    
    let interactor: AllLaunchesViewInteractorProtocol
    let view: AllLaunchesViewProtocol
    var viewModel: AllLaunchesViewModelProtocol?
    
    init(interactor: AllLaunchesViewInteractorProtocol,
         view: AllLaunchesViewProtocol,
         viewModel: AllLaunchesViewModelProtocol) {
        
        self.interactor = interactor
        self.view = view
        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }
}

extension AllLaunchesViewPresenter: AllLaunchesViewPresenterProtocol {
    
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
        viewModel?.launches = launches
        view.launchesOutput()
    }
}

extension AllLaunchesViewPresenter: AllLaunchesViewModelOutput {
    func didUpdateLaunches() {
        DispatchQueue.main.async {
            self.view.updateUI()
        }
    }
    
    func showError(message: String) {
        debugPrint("Error: \(message)")
    }
}
