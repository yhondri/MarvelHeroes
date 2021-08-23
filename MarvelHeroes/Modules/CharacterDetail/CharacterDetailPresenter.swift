//
//  CharacterDetailPresenter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 8/8/21.
//

import Foundation

class CharacterDetailPresenter: CharacterDetailPresentation {
    var interactor: CharacterDetailInteractorInput?
    var router: CharacterDetailWireframe?
    weak var view: CharacterDetailView?
    var character: Character {
        guard let character = interactor?.character else {
            fatalError("No se ha podido obtener el personaje desde el interactor \(#function)")
        }
        return character
    }
    
    func loadComics() {
        interactor?.loadComics()
    }
    
    func showComicDetail(_ comic: Comic) {
        router?.showComicDetail(comic)
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
