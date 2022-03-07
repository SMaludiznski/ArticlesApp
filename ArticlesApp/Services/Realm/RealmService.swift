//
//  RealmService.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 19/02/2022.
//

import Foundation
import RealmSwift
import RxRealm
import RxSwift

final class RealmService: SaveArticleProtocol, ArticlesManagementProtocol {
    private let realm: Realm?
    
    init() {
        do {
            self.realm = try Realm()
        } catch {
            self.realm = nil
        }
    }
    
    func saveArticle(_ article: Article) throws {
        guard let realm = realm else {
            throw RealmErrors.dataBaseError
        }
        
        if isArticleLiked(article) {
            do {
                try realm.write({
                    let articleEntity = ArticleEntity(value: [article.title,
                                                              article.author,
                                                              article.url,
                                                              article.urlToImage,
                                                              article.publishedAt])
                    realm.add(articleEntity)
                })
            } catch {
                throw RealmErrors.errorWithDataSaving
            }
        }
    }
    
    func isArticleLiked(_ article: Article) -> Bool {
        let savedArticles = realm!.objects(ArticleEntity.self).where {
            $0.url == article.url
        }
        
        return savedArticles.isEmpty
    }
    
    func getArticles() throws -> Observable<[Article]> {
        guard let realm = realm else {
            throw RealmErrors.dataBaseError
        }
        
        return Observable.array(from: realm.objects(ArticleEntity.self))
            .compactMap { posts in
                var articles = [Article]()
                
                for post in posts {
                    let article = Article(author: post.author,
                                          title: post.title,
                                          url: post.url,
                                          urlToImage: post.urlToImage,
                                          publishedAt: post.publishDate)
                    articles.append(article)
                }
                return articles
            }
    }
    
    func deleteArticle(_ article: Article) throws {
        guard let realm = realm else {
            throw RealmErrors.dataBaseError
        }
        
        do {
            try realm.write {
                realm.delete(realm.objects(ArticleEntity.self).filter("url=%@", article.url))
            }
        } catch {
            throw RealmErrors.errorWithDataDeleting
        }
    }
}
