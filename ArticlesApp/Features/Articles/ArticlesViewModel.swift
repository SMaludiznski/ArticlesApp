//
//  ArticlesViewModel.swift
//  NewsApp
//
//  Created by Sebastian Maludziński on 11/02/2022.
//

import Foundation
import RxSwift
import RxRelay

final class ArticlesViewModel {
    private let disposeBag = DisposeBag()
    let articles = BehaviorRelay<[Article]>(value: [])
    let viewState = PublishRelay<DownloadingStates>()
    var keyword = Constants.defaultArticleKeyWord
    
    func fetchArticles() {
        self.viewState.accept(.loading)
        guard let cachedArticles = ArticlesCache.shared.articlesFromCache(with: keyword) else {
            downloadArticles()
            return
        }
        
        articles.accept(cachedArticles)
        self.viewState.accept(.success)
    }
    
    private func downloadArticles() {
//        let observable: Observable<NewsApiResponse> = NetworkEngine.downloadData(endpoint: NewsEndpoint.fetchNews(keyWord: keyword))
        let observable: Observable<NewsApiResponse> = NetworkEngine.downloadData(endpoint: NewsEndpoint.fetchFakeNews)
        
        observable
            .subscribe(onNext: { response in
                if !response.articles.isEmpty {
                    self.articles.accept(response.articles)
                    self.viewState.accept(.success)
                    ArticlesCache.shared.cacheArticles(response.articles, with: self.keyword)
                } else {
                    self.viewState.accept(.failure(error: NewsErrors.emptyResult))
                }
            }, onError: { error in
                self.viewState.accept(.failure(error: error))
            })
            .disposed(by: disposeBag)
    }
}
