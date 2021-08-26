//
//  CharacterListContract.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation

protocol CharacterListPresentation: AnyObject {
    var favoriteIds: Set<Int64> { get }
    func onLoadData()
    func onShowCharacterDetail(_ character: Character)
}

protocol CharacterListInteractorInput: AnyObject {
    var output: CharacterListInteractorOutput? { get }
    var didSuccessFirstLoading: Bool { get set }
    var favoriteIds: Set<Int64> { get }

    func onLoadData()
    func onSelectFavorite(character: Character)
}

protocol CharacterListInteractorOutput: AnyObject {
    func onDidLoadCharacters(_ characters: [Character])
    func onErrorLoadingCharacters()
    func showLoadingView()
    func hideLoadingView()
}

protocol CharacterListViewP: AnyObject {
    func onDidLoadCharacters(_ newCharacters: [Character])
    func showErrorLoadingData()
    func showLoadingView()
    func hideLoadingView()
    func reloadCellAt(_ indexPath: IndexPath)
}

protocol CharacterListWireframe: AnyObject {
    func onShowCharacterDetail(character: Character)
}



