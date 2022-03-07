//
//  ImageCache.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 17/02/2022.
//

import Foundation
import UIKit

final class ImageCache {
    static let shared = ImageCache()
    private init() {}
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 50
        cache.totalCostLimit = 1024 * 1024 * 100
        return cache
    }()
    
    func cacheImage(_ image: UIImage, with keyWord: String) {
        self.imageCache.setObject(image, forKey: keyWord as NSString)
    }
    
    func imageFromCache(from url: String) -> UIImage? {
        return self.imageCache.object(forKey: url as NSString)
    }
}
