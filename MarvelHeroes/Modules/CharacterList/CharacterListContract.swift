//
//  CharacterListContract.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation

protocol CharacterListPresentation: AnyObject {
    var favoriteIds: Set<Int64> { get }
    var characters: [Character] { get }
    var moduleType: ModuleType { get }
    func showCredentialsView()
    func loadData()
    func onShowCharacterDetail(_ character: Character)
}

enum ModuleType {
    case characterList
    case favoriteList
}

protocol CharacterListInteractorInput: AnyObject {
    var output: CharacterListInteractorOutput? { get }
    var didSuccessFirstLoading: Bool { get set }
    var favoriteIds: Set<Int64> { get }
    var characters: [Character] { get }
    var moduleType: ModuleType { get }
    func loadData()
    func onSelectFavorite(character: Character, indexPath: IndexPath)
}

protocol CharacterListInteractorOutput: AnyObject {
    func onDidLoadCharacters(_ characters: [Character], newRowsIndexPaths: [IndexPath])
    func reloadTableView()
    func onErrorLoadingCharacters()
    func showLoadingView()
    func hideLoadingView()
    func reloadCellAt(_ indexPath: IndexPath)
    func removeCellAt(_ indexPath: IndexPath)
    func showNoDataLabel(message: String)
    func hideNoDataLabel()
}

protocol CharacterListViewP: AnyObject {
    func onDidLoadCharacters(_ characters: [Character], newRowsIndexPaths: [IndexPath])
    func reloadTableView()
    func showErrorLoadingData()
    func showLoadingView()
    func hideLoadingView()
    func reloadCellAt(_ indexPath: IndexPath)
    func removeCellAt(_ indexPath: IndexPath)
    func showNoDataLabel(message: String)
    func hideNoDataLabel()
}

protocol CharacterListWireframe: AnyObject {
    func showCredentialsView()
    func onShowCharacterDetail(character: Character)
}



