//
//  Coordinator.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 07/02/2022.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
