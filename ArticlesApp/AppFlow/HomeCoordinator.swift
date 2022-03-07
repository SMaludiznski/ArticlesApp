//
//  HomeCoordinator.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import Foundation
import UIKit

protocol HomeFlow: Coordinator {
    func startHomeFlow(with: Article)
}

final class HomeCoordinator: HomeFlow {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 0)
        homeViewController.coordinator = self
        self.navigationController.pushViewController(homeViewController, animated: false)
    }
    
    func startHomeFlow(with article: Article) {
        let vc = ArticleDetailViewController()
        vc.configureView(with: article)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(vc, animated: true)
    }
}
