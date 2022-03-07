//
//  ArticlesManagementService.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 18/02/2022.
//

import Foundation
import RxSwift

protocol ArticlesManagementProtocol {
    func deleteArticle(_ article: Article) throws
    func getArticles() throws -> Observable<[Article]>
}
