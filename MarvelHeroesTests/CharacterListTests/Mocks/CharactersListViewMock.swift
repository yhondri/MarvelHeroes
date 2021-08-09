//
//  CharactersListViewMock.swift
//  MarvelHeroesTests
//
//  Created by Yhondri Acosta Novas on 9/8/21.
//


import XCTest
@testable import MarvelHeroes

class CharactersListViewMock: CharacterListViewP {
    private(set) var onDidLoadCharactersChecked = false
    private(set) var showErrorLoadingDataChecked = false
    private(set) var changeLoadingViewVisibilityChecked = false
    private(set) var hideApiKeysDialogChecked = false
    
    func onDidLoadCharacters(_ newCharacters: [Character]) {
        onDidLoadCharactersChecked = true
    }
    
    func showErrorLoadingData() {
        showErrorLoadingDataChecked = true
    }
    
    func changeLoadingViewVisibility(isHidden: Bool) {
        changeLoadingViewVisibilityChecked = true
    }
    
    func hideApiKeysDialog() {
        hideApiKeysDialogChecked = true
    }
}
