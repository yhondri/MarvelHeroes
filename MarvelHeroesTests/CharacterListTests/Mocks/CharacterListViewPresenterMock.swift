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
    private(set) var reloadTableViewCalled = false
    private(set) var showLoadingViewCalled = false
    private(set) var hideLoadingViewCalled = false
    private(set) var reloadCellAtCalled = false
    private(set) var removeCellAtCalled = false
    private(set) var showNoDataLabelCalled = false
    private(set) var hideNoDataLabelCalled = false
}

// MARK: - CharacterListInteractorOutput
extension CharacterListViewPresenterMock: CharacterListInteractorOutput {
    func onDidLoadCharacters(_ characters: [Character], newRowsIndexPaths: [IndexPath]) {
        onDidLoadCharactersCalled = true
    }
    
    func reloadTableView() {
        reloadTableViewCalled = true
    }
    
    func showLoadingView() {
        showNoDataLabelCalled = true
    }
    
    func hideLoadingView() {
        hideLoadingViewCalled = true
    }
    
    func reloadCellAt(_ indexPath: IndexPath) {
        reloadCellAtCalled = true
    }
    
    func removeCellAt(_ indexPath: IndexPath) {
        removeCellAtCalled = true
    }
    
    func showNoDataLabel(message: String) {
        showNoDataLabelCalled = true
    }
    
    func hideNoDataLabel() {
        hideNoDataLabelCalled = true
    }
    
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
