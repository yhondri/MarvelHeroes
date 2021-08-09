//
//  CharacterTVCell.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit
import SDWebImage

class CharacterTVCell: UITableViewCell {

    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    
    var character: Character! {
        didSet {
            characterNameLabel.text = character.name
            
            if let characterDescription = character.description, !characterDescription.isEmpty {
                characterDescriptionLabel.text = characterDescription
                characterDescriptionLabel.textColor = .primaryText
            } else {
                characterDescriptionLabel.text = LocalizedKey.noDescription.localized
                characterDescriptionLabel.textColor = .lightGray
            }
            characterImageView.sd_setImage(with: character.thumbnail.getURL(),
                                           placeholderImage: nil,
                                           options: [.progressiveLoad])
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentBgView.layer.cornerRadius = 12
        contentBgView.layer.masksToBounds = true
        
        switch traitCollection.userInterfaceStyle {
        case .light, .unspecified:
            setupShadow()
        default: break
        }
    }
    
    private func setupShadow() {
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 12
    }
}
