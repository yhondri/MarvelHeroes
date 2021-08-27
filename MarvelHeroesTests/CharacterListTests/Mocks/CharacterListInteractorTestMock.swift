//
//  CharacterListInteractorTestMock.swift
//  MarvelHeroesTests
//
//  Created by Yhondri Acosta Novas on 9/8/21.
//

import XCTest
@testable import MarvelHeroes

class CharacterListInteractorTestMock: CharacterListInteractorInput {
    var favoriteIds: Set<Int64> = Set()
    var characters: [Character] = []
    var moduleType: ModuleType = .favoriteList
        
    private(set) var onInsertApiKeyChecked = false
    private(set) var loadDataCalled = false
    private(set) var onSelectFavoriteCalled = false
    var didSuccessFirstLoading: Bool = false
    weak var output: CharacterListInteractorOutput?
    var onLoadDataSucceeded = true

    func onInsertApiKeys(publicKey: String, privateKey: String) {
        onInsertApiKeyChecked = true
    }
        
    func loadData() {
        loadDataCalled = true
        if moduleType == .favoriteList {
            
        } else if onLoadDataSucceeded {
            output?.onDidLoadCharacters([], newRowsIndexPaths: [])
        } else {
            output?.onErrorLoadingCharacters()
        }
    }
    
    func onSelectFavorite(character: Character, indexPath: IndexPath) {
        onSelectFavoriteCalled = true
    }
}
