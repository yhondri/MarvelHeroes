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
    
    func testOnInsertApiKeyIsCalledOnInteractor() {
        let view = CharactersListViewMock()
        presenter.view = view
        interactor.output = presenter
        presenter.interactor = interactor
        
        presenter.onInsertApiKeys(publicKey: "", privateKey: "")
        XCTAssertTrue(interactor.onInsertApiKeyChecked, "onInsertApiKeyChecked debe ser llamado")
    }
    
    func testOnLoadDataWorkflowSucceeded() {
        let view = CharactersListViewMock()
        presenter.view = view
        interactor.output = presenter
        interactor.onLoadDataSucceeded = true
        presenter.interactor = interactor
        
        presenter.onLoadData()
        XCTAssertTrue(interactor.onLoadDataIsChecked, "onLoadDataIsChecked debe ser llamado si el usuario hace Login")
        XCTAssertTrue(view.onDidLoadCharactersChecked, "El flujo de carga de carácteres ha fallado")
        XCTAssertTrue(view.hideApiKeysDialogChecked, "No se ha ocultado el diálogo de carga de credenciales")
    }
    
    func testOnLoadDataWorkflowFailed() {
        let view = CharactersListViewMock()
        presenter.view = view
        interactor.output = presenter
        interactor.onLoadDataSucceeded = false
        interactor.onLoadDataSucceeded = false
        presenter.interactor = interactor
        
        presenter.onLoadData()
        XCTAssertTrue(interactor.onLoadDataIsChecked, "onLoadDataIsChecked debe ser llamado si el usuario hace Login")
        XCTAssertTrue(view.showErrorLoadingDataChecked, "El flujo de carga de carácteres ha fallado")
    }

}
