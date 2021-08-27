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
    private(set) var getCharactersCalled = false
    private(set) var getComicsChecked = false
    private(set) var onSelectFavoriteCalled = false
    private(set) var getFavoritesCalled = false
    private(set) var getFavoriteIdsCalled = false
    
    var getCharactersSucceeded = false
    var getComicsSucceeded = false
    
    func onInsertApiKeys(publicKey: String, privateKey: String) {
        onInsertApiKeysChecked = true
    }
    
    func getCharacters(completionHandler: @escaping (Result<[Character], DispatcherError>) -> Void) {
        getCharactersCalled = true
        
        if getCharactersSucceeded {
            completionHandler(.success(CharacterListResponse.getTestData().data.characters))
        } else {
            completionHandler(.failure(.noData))
        }
    }
    
    func getComics(characterId: Int64, completionHandler: @escaping (Result<[Comic], DispatcherError>) -> Void) {
        getComicsChecked = true
        
        if getComicsSucceeded {
            completionHandler(.success([]))
        } else {
            completionHandler(.failure(.noData))
        }
    }
    
    func onSelectFavorite(character: Character) {
        onSelectFavoriteCalled = true
    }
    
    func getFavorites() -> [Character] {
        getFavoritesCalled = true
        return []
    }
    
    func getFavoriteIds() -> Set<Int64> {
        getFavoriteIdsCalled = true
        return Set()
    }
}
