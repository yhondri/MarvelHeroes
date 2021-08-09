//
//  CharacterDetailPresenter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 8/8/21.
//

import UIKit

class CharacterDetailPresenter: CharacterDetailPresentation {
    var interactor: CharacterDetailInteractorInput?
    var router: CharacterDetailWireframe?
    weak var view: CharacterDetailView?
    var character: Character {
        interactor!.character
    }
    
    func viewDidLoad(navController: UINavigationController) {
        router?.viewDidLoad(navController: navController)
    }
    
    func loadComics() {
        interactor?.loadComics()
    }
}

// MARK: - CharacterDetailInteractorOuput
extension CharacterDetailPresenter: CharacterDetailInteractorOutput {
    func didLoadComics(_ comics: [Comic]) {
        view?.showComics(comics)
    }
    
    func showErrorLoadingComics() {
        view?.showErrorLoadingComics()
    }
}
