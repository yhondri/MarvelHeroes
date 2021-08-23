//
//  CharacterDetailViewController.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

class CharacterDetailViewController: UIViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    @IBOutlet weak var characterDescriptionLabel: UILabel!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    
    private lazy var comics: [Comic] = []
    private let comicCellReuseIdentifier = "ComicCVCell"
    private let presenter: CharacterDetailPresentation
    
    init(presenter: CharacterDetailPresentation) {
        self.presenter = presenter
        super.init(nibName: "CharacterDetailViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        let character = presenter.character
        characterImageView.sd_setImage(with: character.thumbnail.getURL(),
                                       placeholderImage: nil,
                                       options: [.progressiveLoad])
        characterNameLabel.text = character.name
        if let characterDescription = character.description, !characterDescription.isEmpty {
            characterDescriptionLabel.text = characterDescription
            characterDescriptionLabel.textColor = .primaryText
        } else {
            characterDescriptionLabel.text = LocalizedKey.noDescription.localized
            characterDescriptionLabel.textColor = .lightGray
        }
        
        if let flowLayout = comicsCollectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
           flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
        comicsCollectionView.register(UINib(nibName: "ComicCVCell", bundle: nil), forCellWithReuseIdentifier: comicCellReuseIdentifier)
        comicsCollectionView.dataSource = self
        comicsCollectionView.delegate = self
        
        self.view.backgroundColor = .backgroundColor
        comicsCollectionView.backgroundColor = .backgroundColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.loadComics()
    }
}

// MARK: - CharacterDetailView
extension CharacterDetailViewController: CharacterDetailView {
    func showComics(_ comics: [Comic]) {
        self.comics = comics
        self.comicsCollectionView.reloadData()
    }
    
    func showErrorLoadingComics() {
        let alertController = UIAlertController(title: LocalizedKey.ups.localized,
                                                message: LocalizedKey.characterDetailViewErrorLoadingCharacters.localized,
                                                preferredStyle: .alert)
        let aceptAction = UIAlertAction(title: LocalizedKey.acept, style: .default, handler: nil)
        alertController.addAction(aceptAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UICollectionViewDataSource
extension CharacterDetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        comics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: comicCellReuseIdentifier, for: indexPath) as? ComicCVCell else {
            fatalError("No se ha podido obtener la celda de tipo ComicCVCell \(#function) - \(#file)")
        }
        cell.comic = comics[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension CharacterDetailViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let comic = comics[indexPath.row]
        presenter.showComicDetail(comic)
    }
}
