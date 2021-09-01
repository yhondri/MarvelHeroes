//
//  Actions.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 6/8/21.
//

import Foundation

// MARK: - GET
extension Action {
    
    /// Obtiene un listado de personajes. El resultado tendrá un máximo de x personajes que vendrán determinado por el parámetro limit, y se aplica paginación según el parámetro offset.
    /// - Parameter limit: El número máximo de personajes que debe devolver el servicio.
    /// - Parameter offset: El número de personajes que debe obviar el servicio desde 0 a offset.
    /// - Returns: Los personajes que se encuentran dentro de los parámetros limit y offset
    static func getCharacters(limit: Int, offset: Int) -> Action<CharacterListResponse> {
        let path = String(format: "/characters?limit=%d&offset=%d&", limit, offset)
        return .init(.get, path: path)
    }
    
    /// Obtiene el listado de comics del personaje cuyo id es pasado por parámetro.
    /// - Parameter characterId: El id del personaje del cual se quieren obtener los comics.
    /// - Returns: El listado de cómics en los que aparece el personaje.
    static func getComics(characterId: Int64) -> Action<ComicsListResponse> {
        let path = String(format: "/characters/%d/comics?", characterId)
        return .init(.get, path: path)
    }
}
