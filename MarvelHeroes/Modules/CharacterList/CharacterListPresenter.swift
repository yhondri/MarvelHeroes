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
    
    var moduleType: ModuleType {
        guard let moduleType = interactor?.moduleType else {
            return .characterList
        }
        return moduleType
    }
    
    var favoriteIds: Set<Int64> {
        guard let favoriteIds = interactor?.favoriteIds else {
            return Set()
        }
        return favoriteIds
    }
    
    var characters: [Character] {
        guard let characters = interactor?.characters else {
            debugPrint("Interactor cannot be nil to getFavorites \(#function) - \(#file)")
            return []
        }
        return characters
    }
    
    
    func loadData() {
        interactor?.loadData()
    }
    
    func showCredentialsView() {
        router?.showCredentialsView()
    }
    
    func onShowCharacterDetail(_ character: Character) {
        router?.onShowCharacterDetail(character: character)
    }
}

// MARK: - CharacterListInteractorOutput
extension CharacterListPresenter: CharacterListInteractorOutput {
    func onDidLoadCharacters(_ characters: [Character], newRowsIndexPaths: [IndexPath]) {
        view?.onDidLoadCharacters(characters, newRowsIndexPaths: newRowsIndexPaths)
    }
    
    func reloadTableView() {
        view?.reloadTableView()
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
    
    func reloadCellAt(_ indexPath: IndexPath) {
        view?.reloadCellAt(indexPath)
    }
    
    func removeCellAt(_ indexPath: IndexPath) {
        view?.removeCellAt(indexPath)
    }
    
    func showNoDataLabel(message: String) {
        view?.showNoDataLabel(message: message)
    }
    
    func hideNoDataLabel() {
        view?.hideNoDataLabel()
    }
}

// MARK: - CharacterTVCellDelegate
extension CharacterListPresenter: CharacterTVCellDelegate {
    func onSelectFavorite(character: Character, indexPath: IndexPath) {
        interactor?.onSelectFavorite(character: character, indexPath: indexPath)
    }
}
