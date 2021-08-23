//
//  ImageLoader.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 23/8/21.
//

import UIKit
import SDWebImage

/// Esta estructura funciona a modo de encapsulador para la librería de carga de imágenes.
struct ImageLoader {
    /// Carga la imagen de la url pasada por parámetro en el imageView pasado por parámetro.
    /// - Parameters:
    ///   - url: URL de la imagen.
    ///   - imageView: ImageView donde se quiere mostrar la imagen.
    static func loadImage(_ url: URL?, in imageView: UIImageView) {
        imageView.sd_setImage(with: url,
                              placeholderImage: nil,
                              options: [.progressiveLoad])
    }
}
