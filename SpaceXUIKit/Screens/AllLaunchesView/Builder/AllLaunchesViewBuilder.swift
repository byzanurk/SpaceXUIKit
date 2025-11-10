//
//  AllLaunchesViewModel.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation
import UIKit

final class AllLaunchesViewBuilder {
    static func build(coordinator: Coordinator) -> AllLaunchesViewController {
        
        let viewController = AllLaunchesViewController()
        let viewModel = AllLaunchesViewModel()
        let httpClient = HttpClient()
        let interactor = AllLaunchesViewInteractor(httpClient: httpClient)
        let router = AllLaunchesViewRouter(coordinator: coordinator)
        let presenter = AllLaunchesViewPresenter(interactor: interactor,
                                                 view: viewController,
                                                 viewModel: viewModel)
        
        viewController.router = router
        viewController.presenter = presenter
        viewController.viewModel = viewModel
        interactor.presenter = presenter
        
        return viewController
    }
}
