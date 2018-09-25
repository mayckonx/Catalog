//
//  Storyboard+ext.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import UIKit
import Foundation

enum Storyboard: String {
    case main = "Main"
}

extension UIStoryboard {
    
    convenience init(_ name: Storyboard) {
        self.init(name: name.rawValue, bundle: nil)
    }
    
    func inflateVC<T: UIViewController>() -> T {
        if let name = NSStringFromClass(T.self).components(separatedBy: ".").last,
            let vc = instantiateViewController(withIdentifier: name) as? T {
            return vc
        }
        fatalError("Could not find " + String(describing: T.self) + ". Perhaps you need to add the class name to the StoryboardID for that UIViewController in IB?")
    }
}

