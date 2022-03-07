//
//  ArticlesCache.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 17/02/2022.
//

import Foundation

final class ArticlesCache {
    static let shared = ArticlesCache()
    private init() {}
    
    var articlesCache: NSCache<NSString, NSArray> = {
        let cache = NSCache<NSString, NSArray>()
        cache.countLimit = 30
        cache.totalCostLimit = 1024 * 1024 * 50
        return cache
    }()
    
    func cacheArticles(_ articles: [Article], with keyWord: String) {
        self.articlesCache.setObject(articles as NSArray, forKey: keyWord as NSString)
    }
    
    func articlesFromCache(with keyWord: String) -> [Article]? {
        return self.articlesCache.object(forKey: keyWord as NSString) as? [Article]
    }
}
