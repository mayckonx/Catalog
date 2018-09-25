//
//  Alertable.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import UIKit

enum AlertTitle: String {
    case error = "Error"
}

protocol Alertable: class {
    func showAlert(of kind: AlertTitle, message: String)
}

extension Alertable where Self: UIViewController {
    func showAlert(of kind: AlertTitle, message: String) {
        let alert = UIAlertController(title: kind.rawValue, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
