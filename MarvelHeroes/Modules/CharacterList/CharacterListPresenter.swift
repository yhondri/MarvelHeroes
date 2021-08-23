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
    
    func onInsertApiKeys(publicKey: String, privateKey: String) {
        interactor?.onInsertApiKeys(publicKey: publicKey, privateKey: privateKey)
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
    
    func onHideApiKeysDialog() {
        view?.hideApiKeysDialog()
    }
    
    func showLoadingView() {
        view?.showLoadingView()
    }
    
    func hideLoadingView() {
        view?.hideLoadingView()
    }
}
