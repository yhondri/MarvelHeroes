//
//  ApiRepositoryMock.swift
//  MarvelHeroesTests
//
//  Created by Yhondri Acosta Novas on 9/8/21.
//

import XCTest
@testable import MarvelHeroes

class ApiRepositoryMock: ApiRepository {
    private(set) var onInsertApiKeysChecked = false
    private(set) var getCharactersChecked = false
    private(set) var getComicsChecked = false
    var getCharactersSucceeded = false
    var getComicsSucceeded = false
    
    func onInsertApiKeys(publicKey: String, privateKey: String) {
        onInsertApiKeysChecked = true
    }
    
    func getCharacters(completionHandler: @escaping (Result<[Character], DispatcherError>) -> Void) {
        getCharactersChecked = true
        
        if getCharactersSucceeded {
            completionHandler(.success(CharacterListResponse.getTestData().data.characters))
        } else {
            completionHandler(.failure(.noData))
        }
    }
    
    func getComics(characterId: Int, completionHandler: @escaping (Result<[Comic], DispatcherError>) -> Void) {
        getComicsChecked = true
        
        if getComicsSucceeded {
            completionHandler(.success([]))
        } else {
            completionHandler(.failure(.noData))
        }
    }
}
