//
//  AllLaunchesViewRouter.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation
import UIKit

protocol AllLaunchesViewRouterProtocol {
    func navigate(viewController: UIViewController)
    var coordinator: Coordinator { get }
}

final class AllLaunchesViewRouter: AllLaunchesViewRouterProtocol {
    
    var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    func navigate(viewController: UIViewController) {
        coordinator.eventOccurred(with: viewController)
    }
}
