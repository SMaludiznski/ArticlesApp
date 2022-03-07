//
//  SearchViewModel.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 18/02/2022.
//

import Foundation
import RxSwift
import RxRelay

final class FavoritesViewModel {
    private let disposeBag = DisposeBag()
    let databaseService: ArticlesManagementProtocol
    
    let articles = BehaviorRelay<[Article]>(value: [])
    let databaseError = PublishRelay<String>()
    
    init(databaseService: ArticlesManagementProtocol) {
        self.databaseService = databaseService
        subscribe()
    }
    
    private func subscribe() {
        do {
            try databaseService.getArticles()
                .subscribe(onNext: { response in
                    self.articles.accept(response)
                })
                .disposed(by: disposeBag)
        } catch {
            databaseError.accept(error.localizedDescription)
        }
    }
}
