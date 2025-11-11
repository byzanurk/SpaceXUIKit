//
//  AllLaunchesViewController.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import UIKit

protocol AllLaunchesViewProtocol {
    func loading()
    func finished()
    func errorOutput(_ output: String)
    func updateUI()
    func launchesOutput()
}

final class AllLaunchesViewController: UIViewController {
    
    var presenter: AllLaunchesViewPresenterProtocol?

    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Launches"
        setupCollectionView()
        fetchService()
    }
    
    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "LaunchCollectionViewCell", bundle: nil),
                                forCellWithReuseIdentifier: "LaunchCollectionViewCell")
    }

    private func fetchService() {
         presenter?.fetchLaunches()
    }
    
    private func prepareUI() {
        collectionView.reloadData()
    }
}

extension AllLaunchesViewController: AllLaunchesViewProtocol {
    
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
    
    func errorOutput(_ output: String) {
        alert(message: output, handler: nil)
    }
    
    func launchesOutput() {
        DispatchQueue.main.async { [weak self] in
            self?.prepareUI()
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.prepareUI()
        }
    }
}

extension AllLaunchesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.allLaunches?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LaunchCollectionViewCell", for: indexPath) as! LaunchCollectionViewCell
        let launch = presenter?.allLaunches?[indexPath.item]
        cell.configure(model: launch)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedLaunch = presenter?.allLaunches?[indexPath.item] {
            presenter?.goToDetail(launch: selectedLaunch)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 16
        let spacing: CGFloat = 10
        let totalPadding = padding * 2 + spacing
        let width = (collectionView.frame.width - totalPadding) / 2
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
}
