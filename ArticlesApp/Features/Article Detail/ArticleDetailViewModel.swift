//
//  ArticleDetailViewModel.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 19/02/2022.
//

import Foundation
import RxSwift
import RxCocoa

final class ArticleDetailViewModel {
    let databaseService: SaveArticleProtocol
    
    let isArticleLiked = BehaviorRelay<Bool>(value: false)
    let databaseError = PublishRelay<String>()
    
    init(databaseService: SaveArticleProtocol) {
        self.databaseService = databaseService
    }
    
    func checkArticleLikeStatus(_ article: Article) {
        isArticleLiked.accept(!databaseService.isArticleLiked(article))
    }
    
    func addArticleToFavorites(_ article: Article) {
        do {
            try databaseService.saveArticle(article)
            isArticleLiked.accept(true)
        } catch {
            databaseError.accept(error.localizedDescription)
        }
    }
    
    func removeArticleFromFavorites(_ article: Article) {
        do {
            try databaseService.deleteArticle(article)
            isArticleLiked.accept(false)
        } catch {
            databaseError.accept(error.localizedDescription)
        }
    }
}
