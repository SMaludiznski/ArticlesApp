//
//  Endpoint.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 12/02/2022.
//

import Foundation

protocol Endpoint {
    var scheme: String { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: [URLQueryItem] { get }
    var method: String { get }
}
