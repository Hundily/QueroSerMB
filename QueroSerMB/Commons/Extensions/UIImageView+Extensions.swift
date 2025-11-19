//
//  UIImageView+Extensions.swift
//  QueroSerMB
//
//  Created by Hundily Cerqueira on 18/11/25.
//

import UIKit

fileprivate let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    func loadAndCache(from url: URL, defaultImage: UIImage? = nil) {
        self.image = defaultImage
        
        let urlString = url.absoluteString as NSString
        
        if let cachedImage = imageCache.object(forKey: urlString) {
            self.image = cachedImage
            print("Imagem carregada do cache de memória: \(url.lastPathComponent)")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self, let data = data, let image = UIImage(data: data) else {
                return
            }
            
            imageCache.setObject(image, forKey: urlString)
            
            DispatchQueue.main.async {
                if self.window != nil {
                    self.image = image
                }
                print("Imagem baixada e salva no cache: \(url.lastPathComponent)")
            }
        }.resume()
    }
}
