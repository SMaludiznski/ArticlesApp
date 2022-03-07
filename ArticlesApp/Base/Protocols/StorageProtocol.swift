//
//  SettingsStorage.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 09/02/2022.
//

import Foundation
import RxSwift
import RxRelay

protocol StorageProtocol {
    var userName: BehaviorRelay<String> { get }
    var tags: BehaviorRelay<[String]> { get }
    var storeService: DataProtocol { get }
}
