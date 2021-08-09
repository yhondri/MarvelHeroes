//
//  CharacterListViewPresenterMock.swift
//  MarvelHeroesTests
//
//  Created by Yhondri Acosta Novas on 9/8/21.
//

import XCTest
@testable import MarvelHeroes

class CharacterListViewPresenterMock: NSObject {
    private(set) var onDidLoadCharactersChecked = false
    private(set) var onErrorLoadingCharactersChecked = false
    private(set) var onHideApiKeysDialogChecked = false
}

// MARK: - CharacterListInteractorOutput
extension CharacterListViewPresenterMock: CharacterListInteractorOutput {
    func onDidLoadCharacters(_ characters: [Character]) {
        onDidLoadCharactersChecked = true
    }
    
    func onErrorLoadingCharacters() {
        onErrorLoadingCharactersChecked = true
    }
    
    func onHideApiKeysDialog() {
        onHideApiKeysDialogChecked = true
    }
    
}
