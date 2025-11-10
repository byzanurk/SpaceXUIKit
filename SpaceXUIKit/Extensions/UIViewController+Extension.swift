//
//  UIViewController+Extension.swift
//  SpaceXUIKit
//
//  Created by Beyza Nur Tekerek on 10.11.2025.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alert(message: String, title: String = "", handler: ((UIAlertAction) -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(okButton)
        self.present(alertController, animated: true, completion: nil)
    }
    
}
