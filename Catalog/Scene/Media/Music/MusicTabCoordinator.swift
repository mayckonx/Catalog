//
//  MusicTabCoordinator.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import UIKit

class MusicTabCoordinator: RootTabCoordinator {
    
    var storyboard: UIStoryboard = UIStoryboard(.main)
    var rootController: UINavigationController
    var tabBarItem: UITabBarItem =  UITabBarItem(title: "Music", image: UIImage(named: "musics.png"), selectedImage: nil)
    
    init() {
        let networkService: MusicServiceNetwork = MusicService()
        let viewModel = MusicViewModel(networkService: networkService)
        let musicViewController: MusicViewController = storyboard.inflateVC()
        
        musicViewController.viewModel = viewModel
        
        rootController = UINavigationController(rootViewController: musicViewController)
        rootController.navigationBar.topItem?.title = "Music"
        rootController.tabBarItem = tabBarItem
    }
}
