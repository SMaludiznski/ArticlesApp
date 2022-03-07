//
//  SceneDelegate.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 17/02/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        let tabVc = TabBarController()
        window = UIWindow(windowScene: scene)
        window?.rootViewController = tabVc
        window?.makeKeyAndVisible()
    }
}

