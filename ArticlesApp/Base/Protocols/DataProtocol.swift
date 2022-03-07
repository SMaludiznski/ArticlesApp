//
//  DataStore.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 08/02/2022.
//

import Foundation

protocol DataProtocol {
    func saveData(_ value: Any, name: String)
    func getDataWith(name: String) -> Any?
}
