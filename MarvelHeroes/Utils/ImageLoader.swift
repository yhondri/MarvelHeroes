//
//  ImageLoader.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 23/8/21.
//

import UIKit
import SDWebImage

struct ImageLoader {
    static func loadImage(_ url: URL?, in imageView: UIImageView) {
        imageView.sd_setImage(with: url,
                              placeholderImage: nil,
                              options: [.progressiveLoad])
    }
}
