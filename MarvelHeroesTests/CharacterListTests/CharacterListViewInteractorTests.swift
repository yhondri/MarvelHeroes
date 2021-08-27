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
    lazy var interactor = CharacterListInteractor(apiRepository: apiRepository, moduleType: .characterList)

    func testOnLoadDataWorkflowWithSuccess() {
        interactor.output = presenter
        apiRepository.getCharactersSucceeded = true
        interactor.loadData()
        
        XCTAssertTrue(apiRepository.getCharactersCalled, "El flujo de carga de carácters no se ha completado con éxito. El repositorio no se ha llamado para obtener a los personajes")
        XCTAssertTrue(presenter.reloadTableViewCalled, "El flujo de carga de carácters no se ha completado con éxito. No se han mostrado los personajes")
    }
    
    func testOnLoadDataWorkflowWithFailure() {
        interactor.output = presenter
        apiRepository.getCharactersSucceeded = false
        interactor.loadData()

        let exp = expectation(description: "check_success")
        
        DispatchQueue.main.async {
            XCTAssertTrue(self.presenter.onErrorLoadingCharactersCalled, "El flujo de carga de carácters no se ha completado con éxito. No se ha mostrado el mensaje de error cuando ha fallado la carga de personajes.")
            exp.fulfill()
        }
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
