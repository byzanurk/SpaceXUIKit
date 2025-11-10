//
//  UIView+Extension.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation
import UIKit

extension UIView {
    func showLoading() {
        if let existing = viewWithTag(369258) {
            existing.removeFromSuperview()
        }

        let backgroundView = UIView(frame: bounds)
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        backgroundView.tag = 369258

        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = CGPoint(x: bounds.midX, y: bounds.midY)
        activityIndicator.color = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()

        backgroundView.addSubview(activityIndicator)
        addSubview(backgroundView)

        isUserInteractionEnabled = false
    }

    func hideLoading() {
        if let background = viewWithTag(369258) {
            background.removeFromSuperview()
        }
        isUserInteractionEnabled = true
    }

}
