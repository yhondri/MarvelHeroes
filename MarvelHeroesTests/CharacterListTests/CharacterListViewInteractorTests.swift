//
//  CharacterListViewInteractorTests.swift
//  MarvelHeroesTests
//
//  Created by Yhondri Acosta Novas on 9/8/21.
//

import XCTest
@testable import MarvelHeroes

class CharacterListViewInteractorTests: XCTestCase {
    private let apiRepository = ApiRepositoryMock()
    private let presenter = CharacterListViewPresenterMock()
    
    func testOnLoadDataWorkflowWithSuccess() {
        let interactor = CharacterListInteractor(apiRepository: apiRepository)
        interactor.output = presenter
        apiRepository.getCharactersSucceeded = true
        interactor.onLoadData()
        
        XCTAssertTrue(apiRepository.getCharactersChecked, "El flujo de carga de carácters no se ha completado con éxito. El repositorio no se ha llamado para obtener a los personajes")
        XCTAssertTrue(presenter.onHideApiKeysDialogChecked, "El flujo de carga de carácters no se ha completado con éxito. El diálogo de credenciales se ha quedado visible. ")
        XCTAssertTrue(presenter.onDidLoadCharactersChecked, "El flujo de carga de carácters no se ha completado con éxito. No se han mostrado los personajes")
    }
    
    func testOnLoadDataWorkflowWithFailure() {
        let interactor = CharacterListInteractor(apiRepository: apiRepository)
        interactor.output = presenter
        apiRepository.getCharactersSucceeded = false
        interactor.onLoadData()

        XCTAssertTrue(presenter.onErrorLoadingCharactersChecked, "El flujo de carga de carácters no se ha completado con éxito. No se ha mostrado el mensaje de error cuando ha fallado la carga de personajes.")
    }
}
