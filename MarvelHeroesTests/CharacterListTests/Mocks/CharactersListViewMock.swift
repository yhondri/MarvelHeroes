//
//  CharactersListViewMock.swift
//  MarvelHeroesTests
//
//  Created by Yhondri Acosta Novas on 9/8/21.
//


import XCTest
@testable import MarvelHeroes

class CharactersListViewMock: CharacterListViewP {
    private(set) var onDidLoadCharactersCalled = false
    private(set) var showErrorLoadingDataCalled = false
    private(set) var changeLoadingViewVisibilityChecked = false
    private(set) var hideApiKeysDialogCalled = false
    
    func onDidLoadCharacters(_ newCharacters: [Character]) {
        onDidLoadCharactersCalled = true
    }
    
    func showErrorLoadingData() {
        showErrorLoadingDataCalled = true
    }
    
    func changeLoadingViewVisibility(isHidden: Bool) {
        changeLoadingViewVisibilityChecked = true
    }
    
    func hideApiKeysDialog() {
        hideApiKeysDialogCalled = true
    }
}
