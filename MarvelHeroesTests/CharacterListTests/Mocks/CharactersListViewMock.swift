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
    private(set) var reloadTableViewCalled = false
    private(set) var showLoadingViewCalled = false
    private(set) var hideLoadingViewCalled = false
    private (set) var reloadCellAtCalled = false
    private (set) var removeCellAtCalled = false    
    private (set) var showNoDataLabelCalled = false
    private (set) var hideNoDataLabelCalled = false
    
    
    func onDidLoadCharacters(_ newCharacters: [Character]) {
        onDidLoadCharactersCalled = true
    }
    
    func showErrorLoadingData() {
        showErrorLoadingDataCalled = true
    }
    
    func changeLoadingViewVisibility(isHidden: Bool) {
        changeLoadingViewVisibilityChecked = true
    }
    
    func onDidLoadCharacters(_ characters: [Character], newRowsIndexPaths: [IndexPath]) {
        onDidLoadCharactersCalled = true
    }
    
    func reloadTableView() {
        reloadTableViewCalled = true
    }
    
    func showLoadingView() {
        showLoadingViewCalled = true
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
}
