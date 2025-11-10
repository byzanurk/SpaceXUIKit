//
//  AllLaunchesViewModel.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation

protocol AllLaunchesViewModelProtocol {
    var launches: [Launch] { get set }
    var delegate: AllLaunchesViewModelOutput? { get set }
}

protocol AllLaunchesViewModelOutput: AnyObject {
    func didUpdateLaunches()
    func showError(message: String)
}

final class AllLaunchesViewModel {
    var launches: [Launch] = []
    weak var delegate: AllLaunchesViewModelOutput?
}

extension AllLaunchesViewModel: AllLaunchesViewModelProtocol {
    //
}
