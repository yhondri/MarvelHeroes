//
//  ComicCVCell.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit
import SDWebImage

class ComicCVCell: UICollectionViewCell {
    @IBOutlet weak var comicThumbnailImageView: UIImageView!
    @IBOutlet weak var comicNameLabel: UILabel!
    
    var comic: Comic! {
        didSet {
            comicNameLabel.text = comic.title
            comicThumbnailImageView.sd_setImage(with: comic.thumbnail.getURL(),
                                           placeholderImage: nil,
                                           options: [.progressiveLoad])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        comicThumbnailImageView.layer.cornerRadius = 35
        comicThumbnailImageView.layer.masksToBounds = true
    }

}
