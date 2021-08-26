//
//  FavoriteListPresenter.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//

import Foundation

class FavoriteListPresenter: FavoritePresentation {
    var interactor: FavoriteInteractorInput?
    var router: FavoriteListWireframe?
    var view: FavoriteListViewP?
    var favoriteIds: Set<Int64> {
        guard let favoriteIds = interactor?.favoriteIds else {
            return Set()
        }
        return favoriteIds
    }
    
    var favorites: [Character] {
        guard let characters = interactor?.favorites else {
            debugPrint("Interactor cannot be nil to getFavorites \(#function) - \(#file)")
            return []
        }
        return characters
    }
    
    func showCredentialsView() {
        router?.showCredentialsView()
    }
    
    func onShowCharacterDetail(character: Character) {
        router?.onShowCharacterDetail(character: character)
    }
}

// MARK: - CharacterTVCellDelegate
extension FavoriteListPresenter: CharacterTVCellDelegate {
    func onSelectFavorite(character: Character, indexPath: IndexPath) {
        interactor?.onSelectFavorite(character: character)
        view?.removeCellAt(indexPath)
    }
}
