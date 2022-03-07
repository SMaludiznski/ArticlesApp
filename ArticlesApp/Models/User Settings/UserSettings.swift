//
//  UserSettings.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 09/02/2022.
//

import Foundation

struct UserSettings: Codable, Equatable {
    let name: String
    let tags: [String]
}
