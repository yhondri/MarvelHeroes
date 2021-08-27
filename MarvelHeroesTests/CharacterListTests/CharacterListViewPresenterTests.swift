//
//  CharacterListViewPresenterTests.swift
//  MarvelHeroesTests
//
//  Created by Yhondri Acosta Novas on 9/8/21.
//

import XCTest
@testable import MarvelHeroes

class CharacterListViewPresenterTests: XCTestCase {
    
    let presenter = CharacterListPresenter()
    let interactor = CharacterListInteractorTestMock()
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func testOnLoadDataWorkflowSucceeded() {
        let view = CharactersListViewMock()
        presenter.view = view
        interactor.output = presenter
        interactor.onLoadDataSucceeded = true
        interactor.moduleType = .characterList
        presenter.interactor = interactor
        
        presenter.loadData()
        XCTAssertTrue(interactor.loadDataCalled, "onLoadDataIsChecked debe ser llamado si el usuario hace Login")
        XCTAssertTrue(view.onDidLoadCharactersCalled, "El flujo de carga de carácteres ha fallado")
    }
    
    func testOnLoadDataWorkflowFailed() {
        let view = CharactersListViewMock()
        presenter.view = view
        interactor.output = presenter
        interactor.onLoadDataSucceeded = false
        interactor.moduleType = .characterList
        presenter.interactor = interactor
        
        presenter.loadData()
        XCTAssertTrue(interactor.loadDataCalled, "onLoadDataIsChecked debe ser llamado si el usuario hace Login")
        XCTAssertTrue(view.showErrorLoadingDataCalled, "El flujo de carga de carácteres ha fallado")
    }
}
