//
//  CharacterListPresenter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation

class CharacterListPresenter: CharacterListPresentation {
    
    var interactor: CharacterListInteractorInput?
    weak var view: CharacterListViewP?
    var router: CharacterListWireframe?
    var favoriteIds: Set<Int64> {
        guard let favoriteIds = interactor?.favoriteIds else {
            return Set()
        }
        return favoriteIds
    }
    
    func onLoadData() {
        interactor?.onLoadData()
    }
    
    func onShowCharacterDetail(_ character: Character) {
        router?.onShowCharacterDetail(character: character)
    }
}

// MARK: - CharacterListInteractorOutput
extension CharacterListPresenter: CharacterListInteractorOutput {
    func onDidLoadCharacters(_ characters: [Character]) {
        view?.onDidLoadCharacters(characters)
    }
    
    func onErrorLoadingCharacters() {
        view?.showErrorLoadingData()
    }
    
    func showLoadingView() {
        view?.showLoadingView()
    }
    
    func hideLoadingView() {
        view?.hideLoadingView()
    }
}

// MARK: - CharacterTVCellDelegate
extension CharacterListPresenter: CharacterTVCellDelegate {
    func onSelectFavorite(character: Character, indexPath: IndexPath) {
        interactor?.onSelectFavorite(character: character)
        view?.reloadCellAt(indexPath)
    }
}
