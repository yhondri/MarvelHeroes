//
//  CharacterListInteractorTestMock.swift
//  MarvelHeroesTests
//
//  Created by Yhondri Acosta Novas on 9/8/21.
//

import XCTest
@testable import MarvelHeroes

class CharacterListInteractorTestMock: CharacterListInteractorInput {
    
    private(set) var onInsertApiKeyChecked = false
    private(set) var onLoadDataIsCalled = false
    var didSuccessFirstLoading: Bool = false

    weak var output: CharacterListInteractorOutput?
    var onLoadDataSucceeded = true

    func onInsertApiKeys(publicKey: String, privateKey: String) {
        onInsertApiKeyChecked = true
    }
    
    func onLoadData() {
        onLoadDataIsCalled = true
        
        if onLoadDataSucceeded  {
            output?.onDidLoadCharacters([])
            output?.onHideApiKeysDialog()
        } else {
            output?.onErrorLoadingCharacters()
        }
    }
}
