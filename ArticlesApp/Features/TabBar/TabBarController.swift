//
//  TabBarController.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import UIKit

final class TabBarController: UITabBarController {
    private let homeTab = HomeCoordinator(navigationController: UINavigationController())
    private let searchTab = FavoritesCoordinator(navigationController: UINavigationController())
    private let settingsTab = SettingsCoordinator(navigationController: UINavigationController())
    
    override func loadView() {
        super.loadView()
        setupTabBar()
    }
    
    private func setupTabBar() {
        self.tabBar.backgroundColor = .tabBarBackground
        self.tabBar.tintColor = .accentColor
        self.tabBar.unselectedItemTintColor = .accentColor?.withAlphaComponent(0.6)
        
        setupTabBarScreens()
    }
    
    private func setupTabBarScreens() {
        homeTab.start()
        searchTab.start()
        settingsTab.start()
        
        self.viewControllers = [homeTab.navigationController,
                                searchTab.navigationController,
                                settingsTab.navigationController]
    }
}
