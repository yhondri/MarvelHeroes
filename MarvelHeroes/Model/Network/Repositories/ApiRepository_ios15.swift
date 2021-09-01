//
//  ApiRepository_ios15.swift
//  ApiRepository_ios15
//
//  Created by Yhondri Acosta Novas on 20/8/21.
//


import UIKit

protocol ApiRepositoryiOS15: ApiRepository {
    /// Obtiene un listado de personajes
    /// - Returns: Si todo ha ido bien, devuelve un listado de personajes, en caso contrario una excepción.
    func getCharacters() async throws -> [Character]

    /// Obtiene un listado de cómics en los que aparece el personaje cuyo id es pasado por parámetro.
    /// - Parameter characterId: El identificador del personaje cuyos cómics se quieren obtener.
    /// - Returns: Si todo ha ido bien, devuelve un listado de comics, en caso contrario una excepción.
    func getComics(characterId: Int) async throws -> [Comic]
}

extension ApiRepositoryImpl: ApiRepositoryiOS15 {    
    func getCharacters() async throws -> [Character] {
        guard let dispatcher = dispatcher as? DispatcheriOS15 else {
            fatalError("Este método sólo se puede llamar con un dispatcher que implemente DispatcheriOS15 -- \(#file) - \(#function)")
        }
        let response = try await dispatcher.execute(action: .getCharacters(limit: charactersLimit, offset: loadedCharactersCount)) as CharacterListResponse
        self.totalCharacters = response.data.total
        self.loadedCharactersCount += response.data.characters.count
        return response.data.characters
    }
    
    func getComics(characterId: Int64) async throws -> [Comic] {
        guard let dispatcher = dispatcher as? DispatcheriOS15 else {
            fatalError("Este método sólo se puede llamar con un dispatcher que implemente DispatcheriOS15 -- \(#file) - \(#function)")
        }
        let response = try await dispatcher.execute(action: .getComics(characterId: characterId)) as ComicsListResponse
        return response.data.comics
    }
}
