//
//  ArticleEntity.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 22/02/2022.
//

import Foundation
import RealmSwift

class ArticleEntity: Object {
    @objc dynamic var title = ""
    @objc dynamic var author: String? = ""
    @objc dynamic var url = ""
    @objc dynamic var urlToImage = ""
    @objc dynamic var publishDate = ""
}
