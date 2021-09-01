//
//  CharacterTVCell.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

protocol CharacterTVCellDelegate: AnyObject {
    func onSelectFavorite(character: Character, indexPath: IndexPath)
}

class CharacterTVCell: UITableViewCell {

    @IBOutlet weak var contentBgView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    static let cellIdentifier = "CharacterTVCell"
    
    var delegate: CharacterTVCellDelegate?
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
          
            ImageLoader.loadImage(character.thumbnail.getURL(), in: characterImageView)
        }
    }
    
    var isFavorite: Bool = false {
        didSet {
            let favoriteImage = isFavorite ? UIImage(systemName: "star.fill") : UIImage(systemName: "star")
            favoriteButton.setImage(favoriteImage, for: .normal)
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
    
    @IBAction func onFavorite(_ sender: Any) {
        guard let tableView = self.superview as? UITableView,
              let indexPath = tableView.indexPath(for: self) else {
            debugPrint("Indexpath not found")
            return
        }
        
        delegate?.onSelectFavorite(character: character, indexPath: indexPath)
    }
    
    static func nib() -> UINib {
        UINib(nibName: CharacterTVCell.className, bundle: nil)
    }
}
