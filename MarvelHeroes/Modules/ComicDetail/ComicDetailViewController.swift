//
//  ComicDetailViewController.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

class ComicDetailViewController: UIViewController {

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicNameLabel: UILabel!
    @IBOutlet weak var comicDescriptionLabel: UILabel!
    
    private let comic: Comic
    
    init(comic: Comic) {
        self.comic = comic
        super.init(nibName: "ComicDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicImageView.sd_setImage(with: comic.thumbnail.getURL(),
                                       placeholderImage: nil,
                                       options: [.progressiveLoad])
        comicNameLabel.text = comic.title
        comicDescriptionLabel.text = comic.description
    }
}
