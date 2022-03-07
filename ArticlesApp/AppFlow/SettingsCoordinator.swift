//
//  SearchCoordinator.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import Foundation
import UIKit

final class SettingsCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let settingsViewController = SettingsViewController()
        settingsViewController.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 2)
        settingsViewController.coordinator = self
        navigationController.pushViewController(settingsViewController, animated: false)
    }
}
