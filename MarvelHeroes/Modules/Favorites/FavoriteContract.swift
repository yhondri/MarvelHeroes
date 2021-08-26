//
//  FavoriteContract.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 24/8/21.
//

import Foundation

protocol FavoritePresentation: AnyObject {
    var favoriteIds: Set<Int64> { get }
    var favorites: [Character] { get }
    func showCredentialsView()
    func onShowCharacterDetail(character: Character)
}

protocol FavoriteInteractorInput: AnyObject {
    var favoriteIds: Set<Int64> { get }
    var favorites: [Character] { get }
    func onSelectFavorite(character: Character)
}

protocol FavoriteListViewP: AnyObject {
    func removeCellAt(_ indexPath: IndexPath)
}

protocol FavoriteListWireframe: AnyObject {
    func onShowCharacterDetail(character: Character)
    func showCredentialsView()
}
