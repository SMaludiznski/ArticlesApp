//
//  NewsApiResponse.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 13/02/2022.
//

import Foundation

struct NewsApiResponse: Decodable {
    let articles: [Article]
}
