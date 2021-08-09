//
//  CharacterListContract.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation

protocol CharacterListPresentation: AnyObject {
    func onInsertApiKeys(publicKey: String, privateKey: String)
    func onLoadData()
    func onShowCharacterDetail(_ character: Character)
}

protocol CharacterListInteractorInput: AnyObject {
    func onInsertApiKeys(publicKey: String, privateKey: String)
    func onLoadData()
}

protocol CharacterListInteractorOutput: AnyObject {
    func onDidLoadCharacters(_ characters: [Character])
    func onErrorLoadingCharacters()
    func onHideApiKeysDialog()
}

protocol CharacterListViewP: AnyObject {
    func onDidLoadCharacters(_ newCharacters: [Character])
    func showErrorLoadingData()
    func changeLoadingViewVisibility(isHidden: Bool)
    func hideApiKeysDialog()
}

protocol CharacterListWireframe: AnyObject {
    func onShowCharacterDetail(character: Character)
}



