//
//  LaunchDetailViewBuilder.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 11.11.2025.
//

import Foundation
import UIKit

final class LaunchDetailViewBuilder {
    static func build(coordinator: Coordinator, launch: Launch) -> LaunchDetailViewController {
        
        let viewController = LaunchDetailViewController()
        let httpClient = HttpClient()
        let interactor = LaunchDetailViewInteractor(httpClient: httpClient)
        let router = LaunchDetailViewRouter(coordinator: coordinator)
        let presenter = LaunchDetailViewPresenter(interactor: interactor,
                                                  router: router,
                                                  view: viewController,
                                                  launch: launch)
        
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }
}
