//
//  ApiRepository.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

protocol ApiRepository: AnyObject {
    func onInsertApiKeys(publicKey: String, privateKey: String)
    func getCharacters(completionHandler: @escaping (Result<[Character], DispatcherError>) -> Void)
    func getComics(characterId: Int, completionHandler: @escaping (Result<[Comic], DispatcherError>) -> Void)
}

class ApiRepositoryImpl: ApiRepository {
    
    private let dispatcher: Dispatcher
    private var loadedCharactersCount = 0
    private var totalCharacters = -1
    private let charactersLimit = 10
    
    var didLoadAllCharacters: Bool {
        loadedCharactersCount >= totalCharacters
    }
    
    init(dispatcher: Dispatcher) {
        self.dispatcher = dispatcher
    }
    
    func onInsertApiKeys(publicKey: String, privateKey: String) {
        dispatcher.onInsertApiKeys(publicKey: publicKey, privateKey: privateKey)
    }

    func getCharacters(completionHandler: @escaping (Result<[Character], DispatcherError>) -> Void) {
        guard (loadedCharactersCount < totalCharacters) || totalCharacters == -1 else {
            completionHandler(.failure(.noData))
            return
        }
        
//        Security error because api is not https
        dispatcher.execute(action: .getCharacters(limit: charactersLimit, offset: loadedCharactersCount))
            .then { result in
                self.totalCharacters = result.data.total
                self.loadedCharactersCount += result.data.characters.count
                completionHandler(.success(result.data.characters))
            }.catch { error in
                completionHandler(.failure(.networkError(error)))
            }
    }
    
    func getComics(characterId: Int, completionHandler: @escaping (Result<[Comic], DispatcherError>) -> Void) {
        dispatcher.execute(action: .getComics(characterId: characterId))
            .then { result in
                completionHandler(.success(result.data.comics))
            }.catch { error in
                completionHandler(.failure(.networkError(error)))
            }
    }
}
