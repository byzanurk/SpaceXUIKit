//
//  LaunchDetailViewController.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 11.11.2025.
//

import UIKit
import Kingfisher

protocol LaunchDetailViewProtocol {
    func loading()
    func finished()
    func configureDetailView(launch: Launch)
}

final class LaunchDetailViewController: UIViewController {
    
    var presenter: LaunchDetailViewPresenterProtocol?

    @IBOutlet private weak var rocketImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var urlLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupURLTapGesture()        
        fetchService()
    }
    
    private func setupUI() {
        titleLabel.numberOfLines = 2
        descriptionLabel.numberOfLines = 0
    }
    
    private func setupURLTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(urlLabelTapped))
        urlLabel.isUserInteractionEnabled = true
        urlLabel.addGestureRecognizer(tapGesture)
    }
    
    @objc private func urlLabelTapped() {
        guard let urlString = urlLabel.text,
              let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url)
    }
    
    private func fetchService() {
        presenter?.viewDidLoad()
    }
    
    func configureDetailView(launch: Launch) {
        titleLabel.text = launch.name
        descriptionLabel.text = launch.details
        urlLabel.text = launch.links.article ?? "No URL Available"
        
        if let path = launch.links.patch?.small {
            rocketImageView.kf.setImage(with: URL(string: path)!)
        }
    }
}

extension LaunchDetailViewController: LaunchDetailViewProtocol {
    func loading() {
        DispatchQueue.main.async { [weak self] in
            self?.view.showLoading()
        }
    }
    
    func finished() {
        DispatchQueue.main.async { [weak self] in
            self?.view.hideLoading()
        }
    }
    
    
}
