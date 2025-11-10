//
//  LaunchCollectionViewCell.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import UIKit
import Kingfisher

class LaunchCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var rocketImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .white
        self.contentView.layer.cornerRadius = 8
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 6
        self.layer.shadowOpacity = 0.1
        self.layer.masksToBounds = false
        
        self.contentView.layer.borderWidth = 0.5
        self.contentView.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        
        titleLabel.numberOfLines = 2
    }
    
    func configure(model: Launch?) {
        titleLabel.text = model?.name
        
        if let path = model?.links.patch?.small {
            rocketImageView.kf.setImage(with: URL(string: path)!)
        }
    }
}
