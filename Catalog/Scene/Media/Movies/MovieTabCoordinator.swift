//
//  MovieTabCoordinator.swift
//  Catalog
//
//  Created by Mayckon Barbosa da Silva on 9/23/18.
//  Copyright © 2018 Mayckon Barbosa da Silva. All rights reserved.
//

import Foundation
import UIKit

class MovieTabCoordinator: RootTabCoordinator {
    
    var storyboard: UIStoryboard = UIStoryboard(.main)
    var rootController: UINavigationController
    var tabBarItem: UITabBarItem =  UITabBarItem(title: "Movies", image: UIImage(named: "movies.png"), selectedImage: nil)
    
    init() {
        let networkService: MovieServiceNetwork = MovieService()
        let viewModel = MovieViewModel(networkService: networkService)
        let movieViewController: MovieViewController = storyboard.inflateVC()
        
        movieViewController.viewModel = viewModel
        
        rootController = UINavigationController(rootViewController: movieViewController)
        rootController.navigationBar.topItem?.title = "Movies"
        rootController.tabBarItem = tabBarItem
    }
}
