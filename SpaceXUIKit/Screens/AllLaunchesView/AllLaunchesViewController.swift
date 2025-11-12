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
    private var selectedSortIndex: Int = 0

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var sortButton: UIButton!
    
    private let sortOptions = ["Date ↑", "Date ↓", "Name ↑", "Name ↓"]
    private var pickerView: UIPickerView?
    private var pickerContainerView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Launches"
        sortButton.setImage(UIImage(systemName: "line.3.horizontal.decrease"), for: .normal)
        searchBar.delegate = self
        setupCollectionView()
        fetchService()
        sortButton.addTarget(self, action: #selector(showSortPicker), for: .touchUpInside)
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
    
    @objc func showSortPicker() {
        if pickerContainerView != nil {
            return
        }
        
        let containerHeight: CGFloat = 250
        let screenWidth = view.frame.width
        let screenHeight = view.frame.height
        
        let containerView = UIView(frame: CGRect(x: 0, y: screenHeight, width: screenWidth, height: containerHeight))
        containerView.backgroundColor = .systemBackground
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.3
        containerView.layer.shadowOffset = CGSize(width: 0, height: -2)
        containerView.layer.shadowRadius = 4
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        
        let picker = UIPickerView(frame: CGRect(x: 0, y: 44, width: screenWidth, height: containerHeight - 44))
        picker.delegate = self
        picker.dataSource = self
        picker.selectRow(selectedSortIndex, inComponent: 0, animated: false)
        
        containerView.addSubview(toolbar)
        containerView.addSubview(picker)
        view.addSubview(containerView)
        
        UIView.animate(withDuration: 0.3) {
            containerView.frame.origin.y = screenHeight - containerHeight
        }
        
        pickerView = picker
        pickerContainerView = containerView
    }
    
    @objc private func dismissSortPicker() {
        guard let containerView = pickerContainerView else { return }
        UIView.animate(withDuration: 0.3, animations: {
            containerView.frame.origin.y = self.view.frame.height
        }) { _ in
            containerView.removeFromSuperview()
            self.pickerContainerView = nil
            self.pickerView = nil
        }
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

extension AllLaunchesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        presenter?.searchLaunches(query: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}

extension AllLaunchesViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sortOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sortOptions[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedSortIndex = row
        presenter?.sortLaunches(by: row)
        self.dismissSortPicker()
    }
}
