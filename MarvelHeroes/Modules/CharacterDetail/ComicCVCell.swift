//
//  ComicCVCell.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

class ComicCVCell: UICollectionViewCell {
    @IBOutlet weak var comicThumbnailImageView: UIImageView!
    @IBOutlet weak var comicNameLabel: UILabel!
    
    var comic: Comic! {
        didSet {
            comicNameLabel.text = comic.title
            ImageLoader.loadImage(comic.thumbnail.getURL(), in: comicThumbnailImageView)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        comicThumbnailImageView.layer.cornerRadius = 35
        comicThumbnailImageView.layer.masksToBounds = true
    }

}
