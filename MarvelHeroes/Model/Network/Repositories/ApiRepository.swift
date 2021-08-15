//
//  ApiRepository.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import UIKit

protocol ApiRepository: AnyObject {
    /// Inyecta en el NetworkDispatcher las credenciales del usuario necesarias para conectar con la API.
    /// - Parameter publicKey: Clave pública.
    /// - Parameter publicKey: Clave privada.
    func onInsertApiKeys(publicKey: String, privateKey: String)
    
    /// Obtiene un listado de personajes
    /// - Parameter completionHandler: Este parámetro es un bloque que devolverá la respuesta asíncrona del resultado de la llamada. Si la ejecución ha ido correctamente devolverá en el parámetro success un nuevo listado de personajes. Si ha ocurrido un error en el parámetro failure devolverá un error
    func getCharacters(completionHandler: @escaping (Result<[Character], DispatcherError>) -> Void)

    @available(iOS 15.0, *)
    func getCharacters() async throws -> [Character]

    /// Obtiene un listado de cómics en los que aparece el personaje cuyo id es pasado por parámetro.
    /// - Parameter characterId: El identificador del personaje cuyos cómics se quieren obtener.
    /// - Parameter completionHandler: Este parámetro es un bloque que devolverá la respuesta asíncrona del resultado de la llamada. Si la ejecución ha ido correctamente devolverá en el parámetro success un listado de los cómics en los que aparece el personaje. Si ha ocurrido un error en el parámetro failure devolverá un error
    func getComics(characterId: Int, completionHandler: @escaping (Result<[Comic], DispatcherError>) -> Void)
    
    @available(iOS 15.0, *)
    func getComics(characterId: Int) async throws -> [Comic]
}

class ApiRepositoryImpl: ApiRepository {
    
    private let dispatcher: Dispatcher
    private var loadedCharactersCount = 0
    private var totalCharacters = -1
    private let charactersLimit = 10
    
    var didLoadAllCharacters: Bool {
        loadedCharactersCount >= totalCharacters
    }
    
    init(dispatcher: Dispatcher = NetworkDispatcher(baseUrl: "http://gateway.marvel.com/v1/public")) {
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
    
    @available(iOS 15.0, *)
    func getCharacters() async throws -> [Character] {
        let response = try await dispatcher.execute(action: .getCharacters(limit: charactersLimit, offset: loadedCharactersCount)) as CharacterListResponse
        return response.data.characters
    }
    
    func getComics(characterId: Int, completionHandler: @escaping (Result<[Comic], DispatcherError>) -> Void) {
        dispatcher.execute(action: .getComics(characterId: characterId))
            .then { result in
                completionHandler(.success(result.data.comics))
            }.catch { error in
                completionHandler(.failure(.networkError(error)))
            }
    }
    
    @available(iOS 15.0, *)
    func getComics(characterId: Int) async throws -> [Comic] {
        let response = try await dispatcher.execute(action: .getComics(characterId: characterId)) as ComicsListResponse
        return response.data.comics
    }
}
