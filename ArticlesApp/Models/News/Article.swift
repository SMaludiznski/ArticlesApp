//
//  Article.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 11/02/2022.
//

import Foundation

struct Article: Decodable {
    let author: String?
    let title: String
    let url: String
    let urlToImage: String
    let publishedAt: String
}
