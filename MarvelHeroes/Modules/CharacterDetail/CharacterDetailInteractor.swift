//
//  CharacterDetailInteractor.swift
//  MarvelHeroes
//
//  Created by Yhondri Acosta Novas on 8/8/21.
//

import Foundation

class CharacterDetailInteractor: CharacterDetailInteractorInput {
    weak var output: CharacterDetailInteractorOutput?
    let apiRepository: ApiRepository
    var character: Character
    
    init(character: Character, apiRepository: ApiRepository) {
        self.character = character
        self.apiRepository = apiRepository
    }
}
