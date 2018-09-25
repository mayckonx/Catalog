//
//  AppCoordinator.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import UIKit

final class AppCoordinator {
    /**
     Root UITabBarController
     */
    var tabBarController: UITabBarController
    /**
     Array of TabCoordinators managed by the TabBarCoordinator
     */
    var tabs: [AnyTabCoordinator]
    /**
     Main window
     */
    var window: UIWindow?
    
    // added
    let musicCoordinator: MusicTabCoordinator
    let moviesCoordinator: MovieTabCoordinator
    
    init(window: UIWindow?)
    {
        self.tabBarController = UITabBarController()
        self.window = window
        
        window?.rootViewController = tabBarController
        
        musicCoordinator = MusicTabCoordinator()
        moviesCoordinator = MovieTabCoordinator()
        
        self.tabs = [
            musicCoordinator.deGenericize,
            moviesCoordinator.deGenericize
        ]
    }
    
    func start() {
        tabBarController.viewControllers = tabs.map{ $0.rootController }
        window?.makeKeyAndVisible()
    }
}
