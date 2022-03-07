//
//  UIImage+Extension.swift
//  ArticlesApp
//
//  Created by Sebastian Maludziński on 17/02/2022.
//

import Foundation
import UIKit

extension UIImageView {
    @discardableResult
    func loadImageFromURL(urlString: String) -> URLSessionDataTask? {
        self.image = nil
        
        if let cachedImage = ImageCache.shared.imageFromCache(from: urlString) {
            self.image = cachedImage
            return nil
        }
        
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async {
                if let data = data, let downloadedImage = UIImage(data: data) {
                    ImageCache.shared.cacheImage(downloadedImage, with: urlString)
                    self.image = downloadedImage
                }
            }
        }
        
        task.resume()
        return task
    }
}
