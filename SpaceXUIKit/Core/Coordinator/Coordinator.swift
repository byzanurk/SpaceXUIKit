//
//  Coordinator.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation
import UIKit

final class Coordinator: CoordinatorProtocol {
    
    var navigationController: UINavigationController?
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    
    func start() {
        let vc = AllLaunchesViewBuilder.build(coordinator: self)
        navigationController?.setViewControllers([vc], animated: true)
    }

    func eventOccurred(with viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
}
