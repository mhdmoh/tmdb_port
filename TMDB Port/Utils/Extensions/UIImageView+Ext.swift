//
//  UIImageView+Ext.swift
//  TMDB Port
//
//  Created by Mohamad Mohamad on 2025. 04. 10..
//

import UIKit
import Kingfisher

extension UIImageView {
    func loadImage(imagePath: String? ){
        self.kf.indicatorType = .activity
        let pngSerializer = FormatIndicatedCacheSerializer.png
        
        if let path = imagePath, !path.isEmpty,
           let url = URL(string: MConstants.posterUrl.rawValue + path) {
            self.kf.setImage(with: url, options: [.cacheSerializer(pngSerializer)])
            self.backgroundColor = .clear
        } else {
            self.image = UIImage(resource: .no)
            self.contentMode = .scaleAspectFit
            self.backgroundColor = .clear
        }
    }
}
