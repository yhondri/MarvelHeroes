//
//  CharacterListViewPresenterMock.swift
//  MarvelHeroesTests
//
//  Created by Yhondri Acosta Novas on 9/8/21.
//

import XCTest
@testable import MarvelHeroes

class CharacterListViewPresenterMock: NSObject {
    private(set) var onDidLoadCharactersCalled = false
    private(set) var onErrorLoadingCharactersCalled = false
    private(set) var onHideApiKeysDialogCalled = false
}

// MARK: - CharacterListInteractorOutput
extension CharacterListViewPresenterMock: CharacterListInteractorOutput {
    func onDidLoadCharacters(_ characters: [Character]) {
        onDidLoadCharactersCalled = true
    }
    
    func onErrorLoadingCharacters() {
        onErrorLoadingCharactersCalled = true
    }
    
    func onHideApiKeysDialog() {
        onHideApiKeysDialogCalled = true
    }
    
}
