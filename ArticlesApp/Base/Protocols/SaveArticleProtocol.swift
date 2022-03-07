//
//  SaveArticleService.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 18/02/2022.
//

import Foundation

protocol SaveArticleProtocol {
    func saveArticle(_ article: Article) throws
    func isArticleLiked(_ article: Article) -> Bool
    func deleteArticle(_ article: Article) throws
}
