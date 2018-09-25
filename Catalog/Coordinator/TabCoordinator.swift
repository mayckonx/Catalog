//
//  TabCoordinator.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import UIKit
import Foundation

/**
 A TabBarCoordinator is a type of Coordinator that manages a UITabBarController.
 */
protocol TabCoordinator {
    associatedtype RootType: UIViewController
    var rootController: RootType { get }
    var tabBarItem: UITabBarItem { get }
}

extension TabCoordinator {
    var deGenericize: AnyTabCoordinator {
        return AnyTabCoordinator(self)
    }
}

typealias RootTabCoordinator = TabCoordinator

class AnyTabCoordinator {
    var rootController: UIViewController
    var tabBarItem: UITabBarItem
    
    init<T: TabCoordinator>(_ tabCoordinator: T) {
        rootController = tabCoordinator.rootController
        tabBarItem = tabCoordinator.tabBarItem
    }
}
