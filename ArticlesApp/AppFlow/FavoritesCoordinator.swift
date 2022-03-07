//
//  SearchCoordinator.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import Foundation
import UIKit

protocol FavoritesFlow: Coordinator {
    func startSearchFlow(with article: Article)
}

final class FavoritesCoordinator: FavoritesFlow {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let searchViewController = FavoritesViewController()
        searchViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "suit.heart"), tag: 1)
        searchViewController.coordinator = self
        navigationController.pushViewController(searchViewController, animated: false)
    }
    
    func startSearchFlow(with article: Article) {
        let vc = ArticleDetailViewController()
        vc.configureView(with: article)
        vc.hidesBottomBarWhenPushed = true
        self.navigationController.pushViewController(vc, animated: true)
    }
}
